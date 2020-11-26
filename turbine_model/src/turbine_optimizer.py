# -*- coding: utf-8 -*-
import logging
import numpy as np
from scipy.optimize import minimize


# 汽轮机单次调整进汽、抽汽量
TURBINE_STEAM_ADJUST_DELTA = 20


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

    # ----------------------
    # 外购电约束条件 version 1
    # ----------------------
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
    # ----------------------
    # 外购电约束条件 version 2
    # ----------------------
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
