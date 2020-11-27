# -*- coding: utf-8 -*-
import seuif97
import numpy as np
from sklearn import linear_model


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
        self.electricity_power = np.nan
        self.machine_status = np.nan
        self.parameters = []

    def regression_simple(self, steam_flow_in_history, electricity_generation_history, machine_statu):
        X = np.array([steam_flow_in_history]).T
        Y = np.array(electricity_generation_history).reshape(-1, 1)
        if machine_statu == 1:
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.parameters = [coefs[0][0], intercept[0]]
        else:
            self.parameters = [0, 0]
    
    def electricity_sample(self, steam_flow_in):
        self.electricity_power = self.parameters * np.array([steam_flow_in, 1])


    def regression_enthalpy(self, steam_flow_in_history, steam_pressure_in_history, steam_temperature_in_history, 
                            steam_pressure_side_history, steam_temperature_side_history,
                            electricity_generation_history, machine_statu):
        if machine_statu:
            # 利用压力、温度平均值计算焓
            eturb_h0 = np.array([seuif97.pt2h(x, y) for x, y in zip(steam_pressure_in_history, steam_temperature_in_history)])
            eturb_h1 = np.array([seuif97.pt2h(x, y) for x, y in zip(steam_pressure_side_history, steam_temperature_side_history)])
            X = np.array(((eturb_h0 - eturb_h1) * steam_flow_in_history) / 3600).T
            Y = np.array(electricity_generation_history).reshape(-1, 1)
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.parameters = [coefs[0][0], intercept[0]]
        else:
            self.parameters = [0, 0]

    def electricity_enthalpy(self, steam_flow_in, steam_pressure_in, steam_temperature_in, steam_pressure_side, steam_temperature_side):
        eturb_h0 = seuif97.pt2h(steam_pressure_in, steam_temperature_in)
        eturb_h1 = seuif97.pt2h(steam_pressure_side, steam_temperature_side)
        x_value = (steam_flow_in * (eturb_h0 - eturb_h1)) / 3600
        self.electricity_power = self.parameters * np.array([x_value, 1])

    
    def regression_complex(self, steam_flow_in_history, steam_pressure_in_history, steam_temperature_in_history, 
                           steam_pressure_side_history, steam_temperature_side_history, 
                           electricity_generation_history, machine_statu):
        if machine_statu:
            X = np.array([
                steam_flow_in_history,
                steam_pressure_in_history,
                steam_temperature_in_history,
                steam_pressure_side_history,
                steam_temperature_side_history,
                electricity_generation_history
            ]).T
            Y = np.array(electricity_generation_history).reshape(-1, 1)
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.parameters = [coefs[0][i] for i in len(coefs[0])]
            self.parameters.appned(intercept[0])
        else:
            self.parameters = [0, 0, 0, 0, 0, 0, 0]

    def electricity_complex(self, steam_flow_in, steam_pressure_in, steam_temperature_in,
                            steam_pressure_out, steam_temperature_out,
                            steam_flow_side, steam_pressure_side, steam_temperature_side):
        self.electricity_power = self.parameters * np.array([
            steam_flow_in,
            steam_pressure_in,
            steam_temperature_in,
            steam_pressure_side,
            steam_temperature_side,
            1
        ])

    def machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0