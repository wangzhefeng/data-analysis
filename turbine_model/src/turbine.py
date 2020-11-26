# -*- coding: utf-8 -*-
import seuif97
import logging
import traceback
import numpy as np
import pandas as pd
from scipy.optimize import minimize
from sklearn import linear_model


# 汽轮机单次调整进汽、抽汽量
TURBINE_STEAM_ADJUST_DELTA = 20
# 汽轮发电机组停开机状态判断进汽量
ETURB_M1_MACHINE_STATUS = 10
ETURB_M2_MACHINE_STATUS = 10
BTURB_M1_MACHINE_STATUS = 10


def electricity_price_ext_preprocessing(electricity_power_ext, electricity_price_buy, electricity_price_sale):
    """
    外购电电价处理
    """
    electricity_price_ext = electricity_price_buy if electricity_power_ext >= settings.ELECTRICITY_POWER_EXT_SALE_THREAD else electricity_price_sale

    return electricity_price_ext

class Eturb:
    
    def __init__(self, instance, steam_flow_in, steam_flow_in_threshold, **kwargs):
        self.instance = instance
        self.steam_flow_in = steam_flow_in
        self.steam_flow_in_threshold = steam_flow_in_threshold
        self.__dict__.update(kwargs)
        self.alpha_1 = np.nan
        self.alpha_2 = np.nan
        self.beta = np.nan
        self.electricity_power = np.nan
        self.machine_status = np.nan

    def effect_m_g(self, machine_statu):
        if machine_statu == 1:
            if self.instance == "eturb_m1":
                # v1
                # self.alpha_1 = 0.236
                # self.alpha_2 = -0.193
                # self.beta = 0
                # v2
                self.alpha_1 = 0.173
                self.alpha_2 = -0.0852
                self.beta = -0.3293
                # 1109
                # self.alpha_1 = 0.
                # self.alpha_2 = -0.036
                # self.beta = -0.3293
            elif self.instance == "eturb_m2":
                # v1
                # self.alpha_1 = 0.236
                # self.alpha_2 = -0.193
                # self.beta = 0
                # v2
                self.alpha_1 = 0.1823
                self.alpha_2 = -0.1065
                self.beta = -0.3139
                # 1109
                # self.alpha_1 = 0.187
                # self.alpha_2 = -0.114
                # self.beta = -0.571
        else:
            self.alpha_1 = 0.01
            self.alpha_2 = 0.01
            self.beta = 0
        # logging.error("yida_turbine_model_v2.py turbine:%s, alpha_1:%s, alpha_2:%s, beta:%s", self.instance, self.alpha_1, self.alpha_2, self.beta)

    def electricity_func(self, steam_flow_in, steam_flow_side):
        self.electricity_power = self.alpha_1 * steam_flow_in + self.alpha_2 * steam_flow_side + self.beta
        # logging.error("yida_turbine_model_v2.py turbine:%s, electricity_power:%s", self.instance, self.electricity_power)
    
    def calculate_machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0
        # logging.error("yida_turbine_model_v2.py turbine:%s, machine_status:%s", self.instance, self.machine_status)


class Bturb:

    def __init__(self, instance, steam_flow_in, steam_flow_in_threshold, **kwargs):
        self.instance = instance
        self.steam_flow_in = steam_flow_in
        self.steam_flow_in_threshold = steam_flow_in_threshold
        self.__dict__.update(kwargs)
        self.alpha = np.nan
        self.beta = np.nan
        self.electricity_power = np.nan
        self.machine_status = np.nan

    def effect_m_g(self, machine_statu):
        if machine_statu == 1:
            self.alpha = 0.06997
            self.beta = -0.9152
        else:
            self.alpha = 0
            self.beta = 0
        # logging.error(
        #     "yida_turbine_model_v2.py turbine:%s, alpha:%s, beta:%s", 
        #     self.instance, self.alpha, self.beta
        # )
    
    def electricity_func(self, steam_flow_in):
        self.electricity_power = self.alpha * steam_flow_in + self.beta
        # logging.error("yida_turbine_model_v2.py turbine:%s, electricity_power:%s", self.instance, self.electricity_power)
    
    def calculate_machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0
        # logging.error("yida_turbine_model_v2.py turbine:%s, machine_status:%s", self.instance, self.machine_status)


# ===================================================================================
# 
# ===================================================================================
def objective(args):
    """
    目标函数
    """
    hp_steam_dayprice, \
    electricity_price_ext, \
    hp_steam_current, \
    electricity_power_ext_current = args
    
    def obj(x):
        return hp_steam_dayprice * (hp_steam_current + x[0]) + electricity_price_ext * (electricity_power_ext_current + x[1]) * 1000

    return obj


def contraint(args):
    """
    约束条件
    (hp_steam_current + x[0])                       : 3台汽机高压蒸汽进汽量, t/h
    (electricity_power_ext_current + x[1])          : 生产车间外购电电功率, MWh
    (eturb_m1_electricity_generation_current + x[2]): #1 汽机自发电发电功率, MWh
    (eturb_m2_electricity_generation_current + x[3]): #2 汽机自发电发电功率, MWh
    (bturb_m1_electricity_generation_current + x[4]): #3 汽机自发电发电功率, MWh
    (eturb_m1_steam_flow_in_current + x[5])         : #1 汽机进汽量, t/h
    (eturb_m2_steam_flow_in_current + x[6])         : #2 汽机进汽量, t/h
    (bturb_m1_steam_flow_in_current + x[7])         : #3 汽机进汽量, t/h
    (eturb_m1_steam_flow_side_current + x[8])       : #1 汽机抽汽量, t/h
    (eturb_m2_steam_flow_side_current + x[9])       : #2 汽机抽汽量, t/h
    """
    steamflow_pred_avg, \
    electricity_power_pred_avg, \
    lp_steam_throtte, \
    eturb_m1_alpha_1, \
    eturb_m1_alpha_2, \
    eturb_m1_beta, \
    eturb_m2_alpha_1, \
    eturb_m2_alpha_2, \
    eturb_m2_beta, \
    bturb_m1_alpha, \
    bturb_m1_beta, \
    eturb_m1_in_min, \
    eturb_m1_in_max, \
    eturb_m2_in_min, \
    eturb_m2_in_max, \
    bturb_m1_in_min, \
    bturb_m1_in_max, \
    eturb_m1_out_min, \
    eturb_m1_out_max, \
    eturb_m2_out_min, \
    eturb_m2_out_max, \
    electricity_power_ext_max, \
    hp_steam_current, \
    eturb_m1_electricity_generation_current, \
    eturb_m2_electricity_generation_current, \
    bturb_m1_electricity_generation_current, \
    electricity_power_ext_current, \
    eturb_m1_steam_flow_in_current, \
    eturb_m2_steam_flow_in_current, \
    bturb_m1_steam_flow_in_current, \
    eturb_m1_steam_flow_side_current, \
    eturb_m2_steam_flow_side_current = args

    # if electricity_power_ext_current > 0:
    #     electricity_power_ext_cons = (
    #         # 外购电电功率 > 0
    #         {"type": "ineq", "fun": lambda x: (electricity_power_ext_current + x[1]) - 0},
    #         # 外购电电功率<外购电最大电功率
    #         {"type": "ineq", "fun": lambda x: electricity_power_ext_max - (electricity_power_ext_current + x[1])},
    #     )
    # else:
    #     electricity_power_ext_cons = (
    #         # 外购电电功率(卖电) < 0
    #         {"type": "ineq", "fun": lambda x: 0 - (electricity_power_ext_current + x[1])},
    #     )

    electricity_power_ext_cons = (
        # 外购电电功率<外购电最大电功率
        {"type": "ineq", "fun": lambda x: electricity_power_ext_max - (electricity_power_ext_current + x[1])},
        # {"type": "ineq", "fun": lambda x: 0.3 - (electricity_power_ext_current + x[1])},
    )

    cons = (
        # -------------------------
        # 等式约束
        # -------------------------
        # 电力平衡
        {"type": "eq", "fun": lambda x: ((eturb_m1_electricity_generation_current + x[2]) + 
                                         (eturb_m2_electricity_generation_current + x[3]) + 
                                         (bturb_m1_electricity_generation_current + x[4])) + (electricity_power_ext_current + x[1]) - electricity_power_pred_avg},
        # 低压蒸汽平衡
        {"type": "eq", "fun": lambda x: ((bturb_m1_steam_flow_in_current + x[7]) + 
                                         (eturb_m1_steam_flow_side_current + x[8]) + 
                                         (eturb_m2_steam_flow_side_current + x[9])) + lp_steam_throtte - steamflow_pred_avg},
        # 高压蒸汽平衡
        {"type": "eq", "fun": lambda x: ((eturb_m1_steam_flow_in_current + x[5]) + 
                                         (eturb_m2_steam_flow_in_current + x[6]) + 
                                         (bturb_m1_steam_flow_in_current + x[7])) + lp_steam_throtte - (hp_steam_current + x[0])},
        # 1#汽机发电
        {"type": "eq", "fun": lambda x: eturb_m1_alpha_1 * x[5] + eturb_m1_alpha_2 * x[8] + eturb_m1_beta - x[2]},
        # 2#汽机发电
        {"type": "eq", "fun": lambda x: eturb_m2_alpha_1 * x[6] + eturb_m2_alpha_2 * x[9] + eturb_m2_beta - x[3]},
        # 3#汽机发电
        {"type": "eq", "fun": lambda x: bturb_m1_alpha * x[7] + bturb_m1_beta - x[4]},
        # -------------------------
        # 不等式约束
        # -------------------------
        # 1#汽轮发电机组进汽汽下限
        {"type": "ineq", "fun": lambda x: (eturb_m1_steam_flow_in_current + x[5]) - eturb_m1_in_min},
        # 1#汽轮发电机组进汽汽上限
        {"type": "ineq", "fun": lambda x: eturb_m1_in_max - (eturb_m1_steam_flow_in_current + x[5])},
        # 2#汽轮发电机组进汽汽下限
        {"type": "ineq", "fun": lambda x: (eturb_m2_steam_flow_in_current + x[6]) - eturb_m2_in_min},
        # 2#汽轮发电机组进汽汽上限
        {"type": "ineq", "fun": lambda x: eturb_m2_in_max - (eturb_m2_steam_flow_in_current + x[6])},
        # 3#汽轮发电机组进汽汽下限
        {"type": "ineq", "fun": lambda x: (bturb_m1_steam_flow_in_current + x[7]) - bturb_m1_in_min},
        # 3#汽轮发电机组进汽汽上限
        {"type": "ineq", "fun": lambda x: bturb_m1_in_max - (bturb_m1_steam_flow_in_current + x[7])},
        # 1#汽轮发电机组抽汽下限
        {"type": "ineq", "fun": lambda x: (eturb_m1_steam_flow_side_current + x[8]) - eturb_m1_out_min},
        # 1#汽轮发电机组抽汽上限
        {"type": "ineq", "fun": lambda x: eturb_m1_out_max - (eturb_m1_steam_flow_side_current + x[8])},
        # 2#汽轮发电机组抽汽下限
        {"type": "ineq", "fun": lambda x: (eturb_m2_steam_flow_side_current + x[9]) - eturb_m2_out_min},
        # 2#汽轮发电机组抽汽上限
        {"type": "ineq", "fun": lambda x: eturb_m2_out_max - (eturb_m2_steam_flow_side_current + x[9])},
        # 1#汽轮发电机组进汽-抽汽
        {"type": "ineq", "fun": lambda x: (eturb_m1_steam_flow_in_current + x[5]) - (eturb_m1_steam_flow_side_current + x[8]) - 20},
        # 2#汽轮发电机组进汽汽下限
        {"type": "ineq", "fun": lambda x: (eturb_m2_steam_flow_in_current + x[6]) - (eturb_m2_steam_flow_side_current + x[9]) - 20},
        # 1#汽机进汽单次调整量下限(减少进汽量)
        {"type": "ineq", "fun": lambda x: x[5] - (-TURBINE_STEAM_ADJUST_DELTA)},
        # 1#汽机进汽单次调整量上限(增加进汽量)
        {"type": "ineq", "fun": lambda x: TURBINE_STEAM_ADJUST_DELTA - x[5]},
        # 2#汽机进汽单次调整量下限(减少进汽量)
        {"type": "ineq", "fun": lambda x: x[6] - (-TURBINE_STEAM_ADJUST_DELTA)},
        # 2#汽机进汽单次调整量上限(增加进汽量)
        {"type": "ineq", "fun": lambda x: TURBINE_STEAM_ADJUST_DELTA - x[6]},
        # 3#汽机进汽单次调整量下限(减少进汽量)
        {"type": "ineq", "fun": lambda x: x[7] - (-TURBINE_STEAM_ADJUST_DELTA)},
        # 3#汽机进汽单次调整量上限(增加进汽量)
        {"type": "ineq", "fun": lambda x: TURBINE_STEAM_ADJUST_DELTA - x[7]},
        # 1#汽机抽汽单次调整量下限(减少进汽量)
        {"type": "ineq", "fun": lambda x: x[8] - (-TURBINE_STEAM_ADJUST_DELTA)},
        # 1#汽机抽汽单次调整量上限(增加进汽量)
        {"type": "ineq", "fun": lambda x: TURBINE_STEAM_ADJUST_DELTA - x[8]},
        # 2#汽机抽汽单次调整量下限(减少进汽量)
        {"type": "ineq", "fun": lambda x: x[9] - (-TURBINE_STEAM_ADJUST_DELTA)},
        # 2#汽机抽汽单次调整量上限(增加进汽量)
        {"type": "ineq", "fun": lambda x: TURBINE_STEAM_ADJUST_DELTA - x[9]}
    )
    cons = cons + electricity_power_ext_cons

    return cons


def optimizer(args_obj, args_con, x0):
    """
    目标函数优化器
    """
    cons = contraint(args_con)
    res = minimize(
        objective(args_obj),
        x0 = np.asarray(x0),
        method = "SLSQP",
        constraints = cons,
        # options = {
        #     "maxiter": 9,
        #     "disp": True
        # }
    )

    return res


def optimizer_n_model(args_obj, args_con, x0, method):
    """
    目标函数优化器
    """
    cons = contraint(args_con)
    res = minimize(
        objective(args_obj),
        x0 = np.asarray(x0),
        method = method,
        constraints = cons,
        # options = {
        #     "maxiter": 9,
        #     "disp": True
        # }
    )

    return res


# ==========================================================================================================
# 汽轮发电机组负荷分配优化模型
# ==========================================================================================================
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


def turbine_optimizer_main_model(hp_steam_dayprice,
                                #  electricity_price_buy,
                                #  electricity_price_sale,
                                 electricity_price_ext,
                                 steamflow_pred_avg,
                                 electricity_power_pred_avg,
                                 lp_steam_throtte, 
                                 steam_flow_in_array, 
                                 steam_flow_side_array, 
                                 electricity_generation_array,
                                 steam_in_upper_limit_array, 
                                 steam_in_lower_limit_array,
                                 steam_out_upper_limit_array, 
                                 steam_out_lower_limit_array,
                                 electricity_power_ext_max, 
                                 electricity_power_ext):
    # ---------------------------------
    # 电价处理(外购电、外卖电)
    # ---------------------------------
    # try:
    #     electricity_price_ext = electricity_price_ext_preprocessing(electricity_power_ext, electricity_price_buy, electricity_price_sale)
    # except:
    #     traceback.print_exc()
    # ---------------------------------
    # 建立汽轮发电机组实例
    # ---------------------------------
    try:
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
        hp_steam = eturb_m1.steam_flow_in + eturb_m2.steam_flow_in + bturb_m1.steam_flow_in
    except:
        traceback.print_exc()
    # ---------------------------------
    # 构造参数
    # ---------------------------------
    try:
        # 目标变量参数
        args_obj = (
            hp_steam_dayprice,      # 元/t
            electricity_price_ext,  # 元/kWh
            hp_steam,               # t/h
            electricity_power_ext   # MW
        )
        # 约束条件参数
        args_con = (
            steamflow_pred_avg, 
            electricity_power_pred_avg, 
            lp_steam_throtte,
            eturb_m1.alpha_1, 
            eturb_m1.alpha_2, 
            eturb_m1.beta,
            eturb_m2.alpha_1, 
            eturb_m2.alpha_2, 
            eturb_m2.beta, 
            bturb_m1.alpha, 
            bturb_m1.beta,
            eturb_m1.machine_steam_in_lower_limit, 
            eturb_m1.machine_steam_in_upper_limit,
            eturb_m2.machine_steam_in_lower_limit, 
            eturb_m2.machine_steam_in_upper_limit,
            bturb_m1.machine_steam_in_lower_limit, 
            bturb_m1.machine_steam_in_upper_limit,
            eturb_m1.machine_steam_ext_lower_limit, 
            eturb_m1.machine_steam_ext_upper_limit,
            eturb_m2.machine_steam_ext_lower_limit, 
            eturb_m2.machine_steam_ext_upper_limit,
            electricity_power_ext_max, 
            hp_steam,
            eturb_m1.electricity_generation, 
            eturb_m2.electricity_generation,
            bturb_m1.electricity_generation,
            electricity_power_ext,
            eturb_m1.steam_flow_in, 
            eturb_m2.steam_flow_in, 
            bturb_m1.steam_flow_in,
            eturb_m1.steam_flow_side, 
            eturb_m2.steam_flow_side
        )
        # 决策变量初值
        x0 = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        # 优化算法
        # --------------------------------------
        # 单模型
        # --------------------------------------
        result = optimizer(args_obj, args_con, x0)
        object_value_min = result.fun
        optim_status = result.success
        optim_result = result.x
        # logging.error("yida_turbine_model_v2.py optim_results:%s", {
        #     "优化得到的目标函数最小值": object_value_min,
        #     "优化状态": optim_status,
        #     "锅炉高压蒸汽产汽量": optim_result[0],
        #     "生产车间外购电电功率": optim_result[1],
        #     "汽机1自发电发电功率": optim_result[2],
        #     "汽机2自发电发电功率": optim_result[3],
        #     "汽机3自发电发电功率": optim_result[4],
        #     "汽机1进汽量": optim_result[5],
        #     "汽机2进汽量": optim_result[6],
        #     "汽机3进汽量": optim_result[7],
        #     "汽机1抽汽量": optim_result[8],
        #     "汽机2抽汽量": optim_result[9],
        # })
    except:
        traceback.print_exc()
    # ---------------------------------
    # 优化结果处理
    # ---------------------------------
    try:
        if optim_status:
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
            logging.error(f"优化状态:{optim_status}")
            logging.error(f"外购电电价:{electricity_price_ext}")
            logging.error("优化数据:%s", {
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
            logging.error("实际数据:%s", {
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
            logging.error(f"优化得到的目标函数最小值1-算法={object_value_min}")

            # electricity_price_ext = electricity_price_ext_preprocessing(electricity_power_ext_opt, electricity_price_buy, electricity_price_sale)
            # object_value_min_2 = hp_steam_dayprice * (eturb_m1_hp_steam_machine_opt + eturb_m2_hp_steam_machine_opt + bturb_m1_hp_steam_machine_opt) + electricity_price_ext * electricity_power_ext_opt * 1000
            # logging.error(f"优化得到的目标函数最小值2-算法={object_value_min_2}")
            # object_value_min_2 = hp_steam_dayprice * (optim_result[0] + hp_steam) + electricity_price_ext * electricity_power_ext_opt * 1000
            # logging.error(f"优化得到的目标函数最小值3-人工={object_value_min_2}")

            object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"实际得到的目标函数最小值-人工={object_value_actual}")
        else:
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
            electricity_power_ext_opt = electricity_power_ext
            # 成本计算
            object_value_min = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"优化得到的目标函数最小值-人工={object_value_min}")
            object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"实际得到的目标函数最小值-人工={object_value_actual}")
    except:
        traceback.print_exc()



def turbine_optimizer_main_model_n_model(hp_steam_dayprice,
                                         #  electricity_price_buy,
                                         #  electricity_price_sale,
                                         electricity_price_ext,
                                         steamflow_pred_avg,
                                         electricity_power_pred_avg,
                                         lp_steam_throtte, 
                                         steam_flow_in_array, 
                                         steam_flow_side_array, 
                                         electricity_generation_array,
                                         steam_in_upper_limit_array, 
                                         steam_in_lower_limit_array,
                                         steam_out_upper_limit_array, 
                                         steam_out_lower_limit_array,
                                         electricity_power_ext_max, 
                                         electricity_power_ext):
    # ---------------------------------
    # 电价处理(外购电、外卖电)
    # ---------------------------------
    # try:
    #     electricity_price_ext = electricity_price_ext_preprocessing(electricity_power_ext, electricity_price_buy, electricity_price_sale)
    # except:
    #     traceback.print_exc()
    # ---------------------------------
    # 建立汽轮发电机组实例
    # ---------------------------------
    try:
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
        hp_steam = eturb_m1.steam_flow_in + eturb_m2.steam_flow_in + bturb_m1.steam_flow_in
    except:
        traceback.print_exc()
    # ---------------------------------
    # 构造参数
    # ---------------------------------
    try:
        # 目标变量参数
        args_obj = (
            hp_steam_dayprice,      # 元/t
            electricity_price_ext,  # 元/kWh
            hp_steam,               # t/h
            electricity_power_ext   # MW
        )
        # 约束条件参数
        args_con = (
            steamflow_pred_avg, 
            electricity_power_pred_avg, 
            lp_steam_throtte,
            eturb_m1.alpha_1, 
            eturb_m1.alpha_2, 
            eturb_m1.beta,
            eturb_m2.alpha_1, 
            eturb_m2.alpha_2, 
            eturb_m2.beta, 
            bturb_m1.alpha, 
            bturb_m1.beta,
            eturb_m1.machine_steam_in_lower_limit, 
            eturb_m1.machine_steam_in_upper_limit,
            eturb_m2.machine_steam_in_lower_limit, 
            eturb_m2.machine_steam_in_upper_limit,
            bturb_m1.machine_steam_in_lower_limit, 
            bturb_m1.machine_steam_in_upper_limit,
            eturb_m1.machine_steam_ext_lower_limit, 
            eturb_m1.machine_steam_ext_upper_limit,
            eturb_m2.machine_steam_ext_lower_limit, 
            eturb_m2.machine_steam_ext_upper_limit,
            electricity_power_ext_max, 
            hp_steam,
            eturb_m1.electricity_generation, 
            eturb_m2.electricity_generation,
            bturb_m1.electricity_generation,
            electricity_power_ext,
            eturb_m1.steam_flow_in, 
            eturb_m2.steam_flow_in, 
            bturb_m1.steam_flow_in,
            eturb_m1.steam_flow_side, 
            eturb_m2.steam_flow_side
        )
        # 决策变量初值
        x0 = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        # 优化算法
        # --------------------------------------
        # 多模型
        # --------------------------------------
        METHODS = [
            "Nelder-Mead",
            "Powell",
            "CG",
            "BFGS",
            "Newton-CG",
            "L-BFGS-B",
            "TNC",
            "COBYLA",
            "SLSQP",
            "trust-constr",
            "dogleg",
            "trust-ncg",
            "trust-exact",
            "trust-krylov"
        ]
        object_value_min_list = []
        optim_status_list = []
        optim_result_list = []
        for method in METHODS:
            result = optimizer(args_obj, args_con, x0, method)
            object_value_min = result.fun
            optim_status = result.success
            optim_result = result.x
            object_value_min_list.append(object_value_min)
            optim_status_list.append(optim_status)
            optim_result_list.append(optim_result)
    except:
        traceback.print_exc()
    # ---------------------------------
    # 优化结果处理
    # ---------------------------------
    try:
        if optim_status:
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
            logging.error(f"优化状态:{optim_status}")
            logging.error(f"外购电电价:{electricity_price_ext}")
            logging.error("优化数据:%s", {
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
            logging.error("实际数据:%s", {
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
            logging.error(f"优化得到的目标函数最小值1-算法={object_value_min}")

            # electricity_price_ext = electricity_price_ext_preprocessing(electricity_power_ext_opt, electricity_price_buy, electricity_price_sale)
            # object_value_min_2 = hp_steam_dayprice * (eturb_m1_hp_steam_machine_opt + eturb_m2_hp_steam_machine_opt + bturb_m1_hp_steam_machine_opt) + electricity_price_ext * electricity_power_ext_opt * 1000
            # logging.error(f"优化得到的目标函数最小值2-算法={object_value_min_2}")
            # object_value_min_2 = hp_steam_dayprice * (optim_result[0] + hp_steam) + electricity_price_ext * electricity_power_ext_opt * 1000
            # logging.error(f"优化得到的目标函数最小值3-人工={object_value_min_2}")

            object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"实际得到的目标函数最小值-人工={object_value_actual}")
        else:
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
            electricity_power_ext_opt = electricity_power_ext
            # 成本计算
            object_value_min = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"优化得到的目标函数最小值-人工={object_value_min}")
            object_value_actual = hp_steam_dayprice * hp_steam + electricity_price_ext * electricity_power_ext * 1000
            logging.error(f"实际得到的目标函数最小值-人工={object_value_actual}")
    except:
        traceback.print_exc()




def get_result(data):
    final_result = pd.DataFrame()
    for i in range(len(data)):
        turbine_optimizer_main_model(
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
            steam_in_upper_limit_array = [90, 90, 75],
            steam_in_lower_limit_array = [70, 70, 20],
            steam_out_upper_limit_array = [40, 40],
            steam_out_lower_limit_array = [15, 15],
            electricity_power_ext_max = 8,
            electricity_power_ext = data["electricity_power_ext"].iloc[i])
        final_result = pd.concat([final_result, df], axis = 0)
    print(final_result)
    final_result.to_excel("/mnt/e/dev/data-download/yida_test/不超过上下限-修改外购电电功率约束条件-不收敛时返回当前负荷-电力蒸汽实际值1109-2.xlsx")


def get_result_i(data, i):
    turbine_optimizer_main_model(
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
        steam_in_upper_limit_array = [90, 90, 75],
        steam_in_lower_limit_array = [70, 70, 20],
        steam_out_upper_limit_array = [40, 40],
        steam_out_lower_limit_array = [15, 15],
        electricity_power_ext_max = 8,
        electricity_power_ext = data["electricity_power_ext"].iloc[i])





if __name__ == "__main__":
    # eturb_m1_result, \
    # eturb_m2_result, \
    # bturb_m1_result, \
    # steampipeline_result = turbine_optimizer_main_model(
    #     hp_steam_dayprice = 95.788,
    #     # electricity_price_buy = 0.283,
    #     # electricity_price_sale = 0.397,
    #     electricity_price_ext = 0.283,
    #     steamflow_pred_avg = 65,
    #     electricity_power_pred_avg = 20.72375,
    #     lp_steam_throtte = 0,
    #     steam_flow_in_array = [73.39, 80.6, 0],
    #     steam_flow_side_array = [29.39, 33.76],
    #     electricity_generation_array = [10.12, 10.58, 0],
    #     steam_in_upper_limit_array = [90, 90, 75],
    #     steam_in_lower_limit_array = [70, 70, 20],
    #     steam_out_upper_limit_array = [40, 40],
    #     steam_out_lower_limit_array = [15, 15],
    #     electricity_power_ext_max = 8,
    #     electricity_power_ext = 0.3575
    # )
    data_1109 = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1109/result-1109.csv")
    data_1110 = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1110/result-1110.csv")
    data_1109_dropna = pd.read_csv("/mnt/e/dev/data-analysis/turbine_model/data/1109/result-1109_dropna.csv")
    # get_result(data = data_1109_2)
    get_result_i(data_1109_dropna, 848)

