# -*- coding: utf-8 -*-
import seuif97
import numpy as np
from sklearn import linear_model


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
                # self.alpha_1 = 0.186
                # self.alpha_2 = -0.104
                # self.beta = 0
                # v3
                self.alpha_1 = 0.173
                self.alpha_2 = -0.0852
                self.beta = -0.3293
            elif self.instance == "eturb_m2":
                # v1
                # self.alpha_1 = 0.236
                # self.alpha_2 = -0.193
                # self.beta = 0
                # v2
                # self.alpha_1 = 0.205
                # self.alpha_2 = -0.096
                # self.beta = 0
                # v3
                self.alpha_1 = 0.1823
                self.alpha_2 = -0.1065
                self.beta = -0.3139
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
        self.electricity_power = np.nan
        self.machine_status = np.nan
        self.parameters = []

    def regression_simple(self, steam_flow_in_history, steam_flow_side_history, electricity_generation_history, machine_statu):
        X = np.array([steam_flow_in_history, steam_flow_side_history]).T
        Y = np.array(electricity_generation_history).reshape(-1, 1)
        if machine_statu == 1:
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.parameters = [coefs[0][0], coefs[0][1], intercept[0]]
        else:
            self.parameters = [0, 0, 0]
    
    def electricity_sample(self, steam_flow_in, steam_flow_side):
        self.electricity_power = self.parameters * np.array([steam_flow_in, steam_flow_side, 1])


    def regression_enthalpy(self, steam_flow_in_history, steam_pressure_in_history, steam_temperature_in_history,
                            steam_pressure_out_history, steam_temperature_out_history, 
                            steam_flow_side_history, steam_pressure_side_history, steam_temperature_side_history,
                            electricity_generation_history, machine_statu):
        if machine_statu:
            # 利用压力、温度平均值计算焓
            eturb_h0 = np.array([seuif97.pt2h(x, y) for x, y in zip(steam_pressure_in_history, steam_temperature_in_history)])
            eturb_hc = np.array([seuif97.pt2h(x, y) for x, y in zip(steam_pressure_out_history, steam_temperature_out_history)])
            eturb_h1 = np.array([seuif97.pt2h(x, y) for x, y in zip((101 - steam_pressure_side_history) / 1000, steam_temperature_side_history)])
            eturb_h1_2 = np.array([seuif97.px2h(x, y) for x, y in zip((101 - steam_pressure_side_history) / 1000, steam_temperature_side_history)])
            X = np.array(((eturb_h0 - eturb_hc) * steam_flow_in_history + (eturb_hc - eturb_h1) * steam_flow_side_history) / 3600).T
            Y = np.array(electricity_generation_history).reshape(-1, 1)
            reg = linear_model.LinearRegression(fit_intercept = True).fit(X, Y)
            coefs = reg.coef_
            intercept = reg.intercept_
            self.parameters = [coefs[0][0], intercept[0]]
        else:
            self.parameters = [0, 0]

    def electricity_enthalpy(self, steam_flow_in, steam_pressure_in, steam_temperature_in,
                             steam_pressure_out, steam_temperature_out,
                             steam_flow_side, steam_pressure_side, steam_temperature_side):
        eturb_h0 = seuif97.pt2h(steam_pressure_in, steam_temperature_in)
        eturb_hc = seuif97.pt2h(steam_pressure_out, steam_temperature_out)
        eturb_h1 = seuif97.pt2h((101 - steam_pressure_side) / 1000, steam_temperature_side)
        eturb_h1_2 = seuif97.px2h((101 - steam_pressure_side) / 1000, steam_temperature_side)
        x_value = (steam_flow_in * (eturb_h0 - eturb_hc) + steam_flow_side * (eturb_hc - eturb_h1)) / 3600
        self.electricity_power = self.parameters * np.array([x_value, 1])

    
    def regression_complex(self, steam_flow_in_history, steam_pressure_in_history, steam_temperature_in_history,
                                 steam_pressure_out_history, steam_temperature_out_history,
                                 steam_flow_side_history, steam_pressure_side_history, steam_temperature_side_history,
                                 electricity_generation_history, machine_statu):
        if machine_statu:
            X = np.array([
                steam_flow_in_history,
                steam_pressure_in_history,
                steam_temperature_in_history,
                steam_pressure_out_history,
                steam_temperature_out_history,
                steam_flow_side_history,
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
            self.parameters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    def electricity_complex(self, steam_flow_in, steam_pressure_in, steam_temperature_in,
                                 steam_pressure_out, steam_temperature_out,
                                 steam_flow_side, steam_pressure_side, steam_temperature_side):
        self.electricity_power = self.parameters * np.array([
            steam_flow_in,
            steam_pressure_in,
            steam_temperature_in,
            steam_pressure_out,
            steam_temperature_out,
            steam_flow_side,
            steam_pressure_side,
            steam_temperature_side,
            1
        ])

    def machine_statu(self):
        self.machine_status = 1 if self.steam_flow_in > self.steam_flow_in_threshold else 0
