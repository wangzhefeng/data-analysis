# -*- coding: utf-8 -*-
import numpy as np


class Bturb:
    """
    背压汽轮发电机组
    """
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
    
    def electricity_func(self, steam_flow_in):
        self.electricity_power = self.alpha * steam_flow_in + self.beta
    
    def calculate_machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0


class Bturb_V1:
    """
    背压汽轮发电机组
    """
    def __init__(self, instance, steam_flow_in, steam_flow_in_threshold, **kwargs):
        self.instance = instance
        self.steam_flow_in = steam_flow_in
        self.steam_flow_in_threshold = steam_flow_in_threshold
        self.__dict__.update(kwargs)
        self.bturb_h0 = np.nan
        self.bturb_h1 = np.nan
        self.alpha = np.nan
        self.beta = np.nan
        self.electricity_power = np.nan
        self.machine_status = np.nan

    def effect_m_g(self, steam_flow_in_history, electricity_generation_history, machine_statu):
        """
        用历史数据估计抽凝汽轮发电机组综合效率(发电效率*机械效率)
        """
        X = np.array([steam_flow_in_history]).T
        Y = np.array(electricity_generation_history).reshape(-1, 1)

        if machine_statu == 1:
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.alpha = coefs[0][0]
            self.beta =  intercept[0]
        else:
            self.alpha = 0
            self.beta = 0
    
    def electricity_func(self, steam_flow_in):
        """
        背压汽轮发电机组发电量-高压蒸汽进汽量、低压蒸汽抽汽量关系
        """
        self.electricity_power = self.alpha * steam_flow_in + self.beta
    
    def bturb_regresssion_enthalpy(self, 
                                   steam_pressure_in_history,
                                   steam_temperature_in_history,
                                   steam_pressure_out_history,
                                   steam_temperature_out_history,
                                   steam_flow_in_history,
                                   electricity_generation_history):
        # 压力、温度平均值
        steam_pressure_in_avg = np.mean(steam_pressure_in_history)
        steam_temperature_in_avg = np.mean(steam_temperature_in_history)
        steam_pressure_out_avg = np.mean(steam_pressure_out_history)
        steam_pressure_out_avg = steam_pressure_out_avg / 1000
        steam_temperature_out_avg = np.mean(steam_temperature_out_history)
        # 利用压力、温度平均值计算焓
        bturb_h0 = seuif97.pt2h(steam_pressure_in_avg, steam_temperature_in_avg)
        bturb_h1 = seuif97.pt2h(steam_pressure_out_avg, steam_temperature_out_avg)
        # 用历史数据估计背压汽轮发电机组机械-发电效率参数
        X = np.array((bturb_h0 - bturb_h1) * steam_flow_in_history / 3600)
        Y = np.array(electricity_generation_history)
        reg = linear_model.LinearRegression()
        reg.fit(X.reshape(-1, 1), Y.reshape(-1, 1))
        estimated_eta_m_g = reg.coef_
        estimated_eta_m_g = np.mean(Y/X)
        self.estimated_eta_m_g = estimated_eta_m_g[0][0]
    
    def electricity_func_enthalpy(self, turbine_steam_HP):
        self.electricity_power = self.estimated_eta_m_g * turbine_steam_HP * (self.bturb_h0 - self.bturb_h1) / 3600
    
    def calculate_machine_statu(self):
        """
        汽轮发电机组运行状态计算
        """
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0