# -*- coding: utf-8 -*-
import numpy as np


class Eturb:
    """
    抽凝汽轮发电机组
    """
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

    def electricity_func(self, steam_flow_in, steam_flow_side):
        self.electricity_power = self.alpha_1 * steam_flow_in + self.alpha_2 * steam_flow_side + self.beta
    
    def calculate_machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0


class Eturb_V1:
    """
    抽凝汽轮发电机组
    """
    def __init__(self, instance, steam_flow_in, steam_flow_in_threshold, **kwargs):
        self.instance = instance
        self.steam_flow_in = steam_flow_in
        self.steam_flow_in_threshold = steam_flow_in_threshold
        self.__dict__.update(kwargs)
        self.eturb_h0 = np.nan
        self.eturb_hc = np.nan
        self.eturb_h1 = np.nan
        self.electricity_power = np.nan
        self.machine_status = np.nan

    def eturb_regression_simple(self, 
                                steam_flow_in_history, 
                                steam_flow_side_history, 
                                electricity_generation_history, 
                                machine_statu):
        """
        用历史数据估计抽凝汽轮发电机组综合效率(机械效率*发电效率)
        """
        X = np.array([steam_flow_in_history, steam_flow_side_history]).T
        Y = np.array(electricity_generation_history).reshape(-1, 1)
        if machine_statu == 1:
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.alpha_1 = coefs[0][0]
            self.alpha_2 = coefs[0][1]
            self.beta = intercept[0]
        else:
            self.alpha_1 = 0.01
            self.alpha_2 = 0.01
            self.beta = 0
    
    def electricity_func_sample(self, steam_flow_in, steam_flow_side):
        """
        抽凝汽轮发电机组发电量-高压蒸汽进汽量、低压蒸汽抽汽量关系
        """
        self.electricity_power = self.alpha_1 * steam_flow_in + self.alpha_2 * steam_flow_side + self.beta

    def eturb_regression_enthalpy(self, 
                                  steam_pressure_in_history,
                                  steam_temperature_in_history,
                                  steam_pressure_out_history,
                                  steam_temperature_out_history,
                                  steam_pressure_side_history,
                                  steam_temperature_side_history,
                                  steam_flow_in_history,
                                  steam_flow_side_history,
                                  electricity_generation_history):
        # 压力、温度平均值
        steam_pressure_in_avg = np.mean(steam_pressure_in_history)
        steam_temperature_in_avg = np.mean(steam_temperature_in_history)
        steam_pressure_out_avg = np.mean(steam_pressure_out_history)
        steam_temperature_out_avg = np.mean(steam_temperature_out_history)
        steam_pressure_side_avg = np.mean(steam_pressure_side_history)
        steam_pressure_side_avg = (101 - steam_pressure_side_avg) / 1000
        steam_temperature_side_avg = np.mean(steam_temperature_side_history)
        # 利用压力、温度平均值计算焓
        eturb_h0 = seuif97.pt2h(steam_pressure_in_avg, steam_temperature_in_avg)
        eturb_hc = seuif97.pt2h(steam_pressure_out_avg, steam_temperature_out_avg)
        eturb_h1 = seuif97.pt2h(steam_pressure_side_avg, steam_temperature_side_avg)
        # 用历史数据估计背压汽轮发电机组机械-发电效率参数
        X = np.array(((eturb_h0 - eturb_hc) * steam_flow_in_history + (eturb_hc - eturb_h1) * steam_flow_side_history) / 3600)
        Y = np.array(electricity_generation_history)
        reg = linear_model.LinearRegression()
        reg.fit(X.reshape(-1, 1), Y.reshape(-1, 1))
        estimated_eta_m_g = reg.coef_
        estimated_eta_m_g = np.mean(Y/X)
        # 输出结果处理
        self.eturb_h0 = eturb_h0
        self.eturb_hc = eturb_hc
        self.eturb_h1 = eturb_h1
        self.estimated_eta_m_g = estimated_eta_m_g[0][0]

    def electricity_func_enthalpy(self, turbine_steam_HP, turbine_steam_LP):
        self.electricity_power = self.estimated_eta_m_g * (turbine_steam_LP * (self.eturb_h0 - self.eturb_h1) +
                                 (turbine_steam_HP - turbine_steam_LP) * (self.eturb_h0 - self.eturb_hc)) / 3600

    def calculate_machine_statu(self):
        """
        汽轮发电机组运行状态计算
        """
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0
