# -*- coding: utf-8 -*-
import logging
import traceback
import numpy as np
import pandas as pd
from scipy.optimize import minimize
from sklearn import linear_model
from Eturb import Eturb
from Bturb import Bturb
from turbine_optimizer import objective, contraint, optimizer


# 汽轮发电机组停开机状态判断进汽量
ETURB_M1_MACHINE_STATUS = 10
ETURB_M2_MACHINE_STATUS = 10
BTURB_M1_MACHINE_STATUS = 10


def create_turbine_instance(steam_flow_in_array):
    # 建立汽轮发电机组示例
    eturb_m1 = Eturb(
        instance = "eturb_m1",
        steam_flow_in = steam_flow_in_array[0],
        steam_flow_in_threshold = ETURB_M1_MACHINE_STATUS
    )
    eturb_m2 = Eturb(
        instance = "eturb_m2",
        steam_flow_in = steam_flow_in_array[1],
        steam_flow_in_threshold = ETURB_M2_MACHINE_STATUS
    )
    bturb_m1 = Bturb(
        instance = "bturb_m1",
        steam_flow_in = steam_flow_in_array[2],
        steam_flow_in_threshold = BTURB_M1_MACHINE_STATUS
    )
    # 判断汽机开停炉状态
    eturb_m1.calculate_machine_statu()
    eturb_m2.calculate_machine_statu()
    bturb_m1.calculate_machine_statu()
    
    return eturb_m1, eturb_m2, bturb_m1


def turbine_optimizer_main_model(hp_steam_dayprice, electricity_price_ext,
                                 steamflow_pred_avg, electricity_power_pred_avg,
                                 lp_steam_throtte, 
                                 steam_flow_in_array, steam_flow_side_array, electricity_generation_array,
                                 steam_in_upper_limit_array, steam_in_lower_limit_array,
                                 steam_out_upper_limit_array, steam_out_lower_limit_array,
                                 electricity_power_ext_max, electricity_power_ext):
    # ---------------------------------
    # 建立汽轮发电机组实例
    # ---------------------------------
    eturb_m1, eturb_m2, bturb_m1 = create_turbine_instance(steam_flow_in_array)
    # eturb_m1
    eturb_m1.steam_flow_side = steam_flow_side_array[0]
    eturb_m1.electricity_generation = electricity_generation_array[0]
    eturb_m1.machine_steam_in_upper_limit = steam_in_upper_limit_array[0] * eturb_m1.machine_status
    eturb_m1.machine_steam_in_lower_limit = steam_in_lower_limit_array[0] * eturb_m1.machine_status
    eturb_m1.machine_steam_ext_upper_limit = steam_out_upper_limit_array[0] * eturb_m1.machine_status
    eturb_m1.machine_steam_ext_lower_limit = steam_out_lower_limit_array[0] * eturb_m1.machine_status
    # eturb_m2
    eturb_m2.steam_flow_side = steam_flow_side_array[1]
    eturb_m2.electricity_generation = electricity_generation_array[1]
    eturb_m2.machine_steam_in_upper_limit = steam_in_upper_limit_array[1] * eturb_m2.machine_status
    eturb_m2.machine_steam_in_lower_limit = steam_in_lower_limit_array[1] * eturb_m2.machine_status
    eturb_m2.machine_steam_ext_upper_limit = steam_out_upper_limit_array[1] * eturb_m2.machine_status
    eturb_m2.machine_steam_ext_lower_limit = steam_out_lower_limit_array[1] * eturb_m2.machine_status
    # bturb_m1
    bturb_m1.electricity_generation = electricity_generation_array[2]
    bturb_m1.machine_steam_in_upper_limit = steam_in_upper_limit_array[2] * bturb_m1.machine_status
    bturb_m1.machine_steam_in_lower_limit = steam_in_lower_limit_array[2] * bturb_m1.machine_status
    # 估计汽轮发电机组综合效率
    eturb_m1.effect_m_g(eturb_m1.machine_status)
    eturb_m2.effect_m_g(eturb_m2.machine_status)
    bturb_m1.effect_m_g(bturb_m1.machine_status)
    # 高压蒸汽进汽总量
    hp_steam = eturb_m1.steam_flow_in + eturb_m2.steam_flow_in + bturb_m1.steam_flow_in
    #TODO test
    # hp_steam = None
    # ---------------------------------
    # 构造参数
    # ---------------------------------
    # 目标变量参数
    args_obj = (hp_steam_dayprice, electricity_price_ext, hp_steam, electricity_power_ext)
    # 约束条件参数
    args_con = (steamflow_pred_avg, electricity_power_pred_avg, lp_steam_throtte,
                eturb_m1.alpha_1, eturb_m1.alpha_2, eturb_m1.beta,
                eturb_m2.alpha_1, eturb_m2.alpha_2, eturb_m2.beta, 
                bturb_m1.alpha, bturb_m1.beta,
                eturb_m1.machine_steam_in_lower_limit, eturb_m1.machine_steam_in_upper_limit,
                eturb_m2.machine_steam_in_lower_limit, eturb_m2.machine_steam_in_upper_limit,
                bturb_m1.machine_steam_in_lower_limit, bturb_m1.machine_steam_in_upper_limit,
                eturb_m1.machine_steam_ext_lower_limit, eturb_m1.machine_steam_ext_upper_limit,
                eturb_m2.machine_steam_ext_lower_limit, eturb_m2.machine_steam_ext_upper_limit,
                electricity_power_ext_max, hp_steam,
                eturb_m1.electricity_generation, eturb_m2.electricity_generation, bturb_m1.electricity_generation,
                electricity_power_ext,
                eturb_m1.steam_flow_in, eturb_m2.steam_flow_in, bturb_m1.steam_flow_in,
                eturb_m1.steam_flow_side, eturb_m2.steam_flow_side)
    # 决策变量初值
    x0 = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    # ---------------------------------
    # 优化算法
    # ---------------------------------
    # 优化算法
    result = optimizer(args_obj, args_con, x0)
    # 优化算法结果
    object_value_min = result.fun
    optim_status = result.success
    optim_result = result.x
    # ---------------------------------
    # 优化结果处理
    # ---------------------------------
    if optim_status:
        logging.error("=====================")
        logging.error("算法收敛...")
        logging.error("=====================")
        # 建议进汽量
        eturb_m1_hp_steam_machine_opt = optim_result[5] + eturb_m1.steam_flow_in
        eturb_m2_hp_steam_machine_opt = optim_result[6] + eturb_m2.steam_flow_in
        bturb_m1_hp_steam_machine_opt = optim_result[7] + bturb_m1.steam_flow_in
        # 建议抽汽量
        eturb_m1_lp_steam_machine_opt = optim_result[8] + eturb_m1.steam_flow_side
        eturb_m2_lp_steam_machine_opt = optim_result[9] + eturb_m2.steam_flow_side
        # 建议发电量
        eturb_m1_electricity_machine_opt = optim_result[2] + eturb_m1.electricity_generation
        eturb_m2_electricity_machine_opt = optim_result[3] + eturb_m2.electricity_generation
        bturb_m1_electricity_machine_opt = optim_result[4] + bturb_m1.electricity_generation
        # 进汽量变化值
        eturb_m1_steam_flow_in_delta = optim_result[5]
        eturb_m2_steam_flow_in_delta = optim_result[6]
        bturb_m1_steam_flow_in_delta = optim_result[7]
        # 建议外购电
        electricity_power_ext_opt = optim_result[1] + electricity_power_ext
        # ---------------------------------
        # 日志输出
        # ---------------------------------
        logging.error("优化状态 = %s", optim_status)
        logging.error("外购电电价 = %s", electricity_price_ext)
        logging.error("高压蒸汽价格 = %s", hp_steam_dayprice)
        logging.error("优化数据 = %s", {
            "汽机高压蒸汽产进汽量": optim_result[0] + hp_steam,
            "生产车间外购电电功率": electricity_power_ext_opt,
            "汽机1自发电发电功率": eturb_m1_electricity_machine_opt,
            "汽机2自发电发电功率": eturb_m2_electricity_machine_opt,
            "汽机3自发电发电功率": bturb_m1_electricity_machine_opt,
            "汽机1进汽量": eturb_m1_hp_steam_machine_opt,
            "汽机2进汽量": eturb_m2_hp_steam_machine_opt,
            "汽机3进汽量": bturb_m1_hp_steam_machine_opt,
            "汽机1抽汽量": eturb_m1_lp_steam_machine_opt,
            "汽机2抽汽量": eturb_m2_lp_steam_machine_opt,
        })
        logging.error("实际数据 = %s", {
            "汽机高压蒸汽产进汽量-实际": hp_steam,
            "生产车间外购电电功率-实际": electricity_power_ext,
            "汽机1自发电发电功率-实际": eturb_m1.electricity_generation,
            "汽机2自发电发电功率-实际": eturb_m2.electricity_generation,
            "汽机3自发电发电功率-实际": bturb_m1.electricity_generation,
            "汽机1进汽量-实际": eturb_m1.steam_flow_in,
            "汽机2进汽量-实际": eturb_m2.steam_flow_in,
            "汽机3进汽量-实际": bturb_m1.steam_flow_in,
            "汽机1抽汽量-实际": eturb_m1.steam_flow_side,
            "汽机2抽汽量-实际": eturb_m2.steam_flow_side,
        })
        # 成本计算
        logging.error("优化得到的目标函数最小值 = %s", object_value_min)
        object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
        logging.error("实际得到的目标函数最小值 = %s", object_value_actual)
    else:
        logging.error("=====================")
        logging.error("算法不收敛...")
        logging.error("=====================")
        # 高压蒸汽产量
        hp_steam_opt = hp_steam
        # 建议进汽量
        eturb_m1_hp_steam_machine_opt = eturb_m1.steam_flow_in
        eturb_m2_hp_steam_machine_opt = eturb_m2.steam_flow_in
        bturb_m1_hp_steam_machine_opt = bturb_m1.steam_flow_in
        # 建议抽汽量
        eturb_m1_lp_steam_machine_opt = eturb_m1.steam_flow_side
        eturb_m2_lp_steam_machine_opt = eturb_m2.steam_flow_side
        # 建议发电量
        eturb_m1_electricity_machine_opt = eturb_m1.electricity_generation
        eturb_m2_electricity_machine_opt = eturb_m2.electricity_generation
        bturb_m1_electricity_machine_opt = bturb_m1.electricity_generation
        # 进汽量变化值
        eturb_m1_steam_flow_in_delta = 0
        eturb_m2_steam_flow_in_delta = 0
        bturb_m1_steam_flow_in_delta = 0
        # 外购电建议值
        electricity_power_ext_opt = electricity_power_ext
        # ---------------------------------
        # 日志输出
        # ---------------------------------
        logging.error("优化状态:%s", optim_status)
        logging.error("外购电电价:%s", electricity_price_ext)
        logging.error("高压蒸汽价格:%s", hp_steam_dayprice)
        logging.error("实际数据 = %s", {
            "汽机高压蒸汽产进汽量-实际": hp_steam_opt,
            "生产车间外购电电功率-实际": electricity_power_ext,
            "汽机1自发电发电功率-实际": eturb_m1.electricity_generation,
            "汽机2自发电发电功率-实际": eturb_m2.electricity_generation,
            "汽机3自发电发电功率-实际": bturb_m1.electricity_generation,
            "汽机1进汽量-实际": eturb_m1.steam_flow_in,
            "汽机2进汽量-实际": eturb_m2.steam_flow_in,
            "汽机3进汽量-实际": bturb_m1.steam_flow_in,
            "汽机1抽汽量-实际": eturb_m1.steam_flow_side,
            "汽机2抽汽量-实际": eturb_m2.steam_flow_side,
        })
        # 成本计算
        object_value_min = hp_steam_dayprice * hp_steam_opt + electricity_price_ext * electricity_power_ext_opt * 1000
        logging.error("优化得到的目标函数最小值 = %s", object_value_min)
        object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
        logging.error("实际得到的目标函数最小值 = %s", object_value_actual)
    
    df = pd.DataFrame({
        # "steam_flow_in_eturb_m1": [eturb_m1.steam_flow_in],
        # "hp_steam_machine_opt_eturb_m1": [eturb_m1_hp_steam_machine_opt],
        # "steam_flow_side_eturb_m1": [eturb_m1.steam_flow_side],
        # "lp_steam_machine_opt_eturb_m1": [eturb_m1_lp_steam_machine_opt],
        # "electricity_generation_eturb_m1": [eturb_m1.electricity_generation],
        # "electricity_machine_opt_eturb_m1": [eturb_m1_electricity_machine_opt],
        # "steam_flow_in_eturb_m2": [eturb_m2.steam_flow_in],
        # "hp_steam_machine_opt_eturb_m2": [eturb_m2_hp_steam_machine_opt],
        # "steam_flow_side_eturb_m2": [eturb_m2.steam_flow_side],
        # "lp_steam_machine_opt_eturb_m2": [eturb_m2_lp_steam_machine_opt],
        # "electricity_generation_eturb_m2": [eturb_m2.electricity_generation],
        # "electricity_machine_opt_eturb_m2": [eturb_m2_electricity_machine_opt],
        # "steam_flow_in_eturb": [eturb_m1.steam_flow_in + eturb_m2.steam_flow_in],
        # "hp_steam_machine_opt_eturb": [eturb_m1_hp_steam_machine_opt + eturb_m2_hp_steam_machine_opt],
        # "steam_flow_side_eturb": [eturb_m1.steam_flow_side + eturb_m2.steam_flow_side],
        # "lp_steam_machine_opt_eturb": [eturb_m1_lp_steam_machine_opt + eturb_m2_lp_steam_machine_opt],
        # "electricity_generation_eturb": [eturb_m1.electricity_generation + eturb_m2.electricity_generation],
        # "electricity_machine_opt_eturb": [eturb_m1_electricity_machine_opt + eturb_m2_electricity_machine_opt],
        # "electricity_power_ext": [electricity_power_ext],
        # "electricity_power_ext_opt": [electricity_power_ext_opt],
        "object_value_min": [object_value_min],
        "object_value_actual": [object_value_actual],
        "optim_status": [optim_status],
    })

    return df


def get_result(data):
    final_result = pd.DataFrame()
    for i in range(len(data)):
        df = turbine_optimizer_main_model(
            hp_steam_dayprice = 95.788,
            electricity_price_ext = data["electricity_price_ext"].iloc[i],
            # 算法6
            steamflow_pred_avg = data["lp_steam_pred_avg"].iloc[i],
            electricity_power_pred_avg = data["electricity_power_pred_avg"].iloc[i],
            # 算法8
            # steamflow_pred_avg = data["lp_steam_pred_avg_adjust"].iloc[i],
            # electricity_power_pred_avg = data["electricity_power_pred_avg_adjust"].iloc[i],
            lp_steam_throtte = 0,
            steam_flow_in_array = [
                data["steam_flow_in_eturb_m1"].iloc[i], 
                data["steam_flow_in_eturb_m2"].iloc[i], 
                0
            ],
            steam_flow_side_array = [
                data["steam_flow_side_eturb_m1"].iloc[i], 
                data["steam_flow_side_eturb_m2"].iloc[i]],
            electricity_generation_array = [
                data["electricity_generation_eturb_m1"].iloc[i], 
                data["electricity_generation_eturb_m2"].iloc[i], 
                0
            ],
            steam_in_upper_limit_array = [90, 90, 75],
            steam_in_lower_limit_array = [70, 70, 20],
            steam_out_upper_limit_array = [40, 40],
            steam_out_lower_limit_array = [15, 15],
            electricity_power_ext_max = 8,
            electricity_power_ext = data["electricity_power_ext"].iloc[i]
        )
        final_result = pd.concat([final_result, df], axis = 0)
        # final_result["outlet_steam_flow_boiler_m1"] = data["outlet_steam_flow_boiler_m1"].iloc[i]
        # final_result["hp_steam_boiler_opt_array_boiler_m1"] = data["hp_steam_boiler_opt_array_boiler_m1"].iloc[i]
        # final_result["outlet_steam_flow_boiler_m3"] = data["outlet_steam_flow_boiler_m3"].iloc[i]
        # final_result["hp_steam_boiler_opt_array_boiler_m3"] = data["hp_steam_boiler_opt_array_boiler_m3"].iloc[i]
        # final_result["outlet_steam_flow_boiler"] = data["outlet_steam_flow_boiler_m1"].iloc[i] + data["outlet_steam_flow_boiler_m3"].iloc[i]
        # final_result["hp_steam_boiler_opt_array_boiler"] = data["hp_steam_boiler_opt_array_boiler_m1"].iloc[i] + data["hp_steam_boiler_opt_array_boiler_m3"].iloc[i]
        # 算法6
        # final_result["steamflow_pred_avg"] = data["lp_steam_pred_avg"].iloc[i]
        # final_result["electricity_power_pred_avg"] = data["electricity_power_pred_avg"].iloc[i]
        # 算法8
        # final_result["steamflow_pred_avg"] = data["lp_steam_pred_avg_adjust"].iloc[i]
        # final_result["electricity_power_pred_avg"] = data["electricity_power_pred_avg_adjust"].iloc[i]
    # ------------
    # wsl
    # ------------
    # final_result.to_excel("/mnt/e/dev/data-download/yida_test/不超过上下限-修改外购电电功率约束条件-不收敛时返回当前负荷-电力蒸汽实际值1109-2.xlsx")
    # ------------
    # cam
    # ------------
    # final_result.to_excel("/Users/zfwang/work/dev/data-analysis/turbine_model/result/溢达数据-算法-06.xlsx")
    final_result.to_excel("/Users/zfwang/work/dev/data-analysis/turbine_model/result/溢达数据-算法-08.xlsx")




def unit_test():
    """

    """
    df = turbine_optimizer_main_model(
        hp_steam_dayprice = 95.788,
        electricity_price_ext = 0.88,
        steamflow_pred_avg = 68,
        electricity_power_pred_avg = 19.7,
        lp_steam_throtte = 0,
        steam_flow_in_array = [
            63, 
            47, 
            40
        ],
        steam_flow_side_array = [
            22.36, 
            0
        ],
        electricity_generation_array = [
            9.17, 
            9.43, 
            1.8
        ],
        steam_in_upper_limit_array = [90, 90, 90],
        steam_in_lower_limit_array = [0, 0, 0],
        steam_out_upper_limit_array = [40, 0],
        steam_out_lower_limit_array = [0, 0],
        electricity_power_ext_max = 8,
        electricity_power_ext = 4
    )





def get_result_i(data, i):
    df = turbine_optimizer_main_model(
        hp_steam_dayprice = 95.788,
        electricity_price_ext = data["electricity_price_ext"].iloc[i],
        steamflow_pred_avg = data["lp_steam_pred_avg_adjust"].iloc[i],
        electricity_power_pred_avg = data["electricity_power_pred_avg_adjust"].iloc[i],
        lp_steam_throtte = 0,
        steam_flow_in_array = [
            data["steam_flow_in_eturb_m1"].iloc[i], 
            data["steam_flow_in_eturb_m2"].iloc[i], 
            0
        ],
        steam_flow_side_array = [
            data["steam_flow_side_eturb_m1"].iloc[i], 
            data["steam_flow_side_eturb_m2"].iloc[i]],
        electricity_generation_array = [
            data["electricity_generation_eturb_m1"].iloc[i], 
            data["electricity_generation_eturb_m2"].iloc[i], 
            0
        ],
        steam_in_upper_limit_array = [80, 80, 75],
        steam_in_lower_limit_array = [70, 70, 20],
        steam_out_upper_limit_array = [30, 40],
        steam_out_lower_limit_array = [15, 15],
        electricity_power_ext_max = 8,
        electricity_power_ext = data["electricity_power_ext"].iloc[i]
    )


if __name__ == "__main__":
    # ----------
    # wsl
    # ----------
    # data_1109 = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1109/result-1109.csv")
    # data_1110 = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1110/result-1110.csv")
    data_1109_dropna = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1109/result-1109_dropna.csv")
    # ----------
    # cam
    # ----------
    # data_1109 = pd.read_csv("/Users/zfwang/work/dev/data-analysis/turbine_model/data/1109/result-1109.csv")
    # data_1110 = pd.read_csv("/Users/zfwang/work/dev/data-analysis/turbine_model/data/1110/result-1110.csv")
    # data_1109_dropna = pd.read_csv("/Users/zfwang/work/dev/data-analysis/turbine_model/data/1109/result-1109_dropna.csv")
    # ----------
    #
    # ----------
    # get_result(data = data_1109_dropna)
    get_result_i(data_1109_dropna, 848)
    # unit_test()
