# -*- coding: utf-8 -*-
import os
import sys
import numpy as np
import pandas as pd
import seuif97
from sklearn import linear_model
from sklearn.metrics import r2_score
import seuif97


# win
root_path = "e:/dev/data-analysis/turbine_model"
# linux
# root_path = "/mnt/e/dev/data-analysis/turbine_model"


data_path = os.path.join(root_path, "data")
result_path = os.path.join(root_path, "result")


data_path_0817 = os.path.join(data_path, "0187")
data_path_0904 = os.path.join(data_path, "0904-0906")
data_path_0907 = os.path.join(data_path, "0907")
data_path_0909 = os.path.join(data_path, "0909")
data_path_0910 = os.path.join(data_path, "0910")
data_path_1109 = os.path.join(data_path, "1109")
data_path_1110 = os.path.join(data_path, "1110")


regression_data_path_0817 = os.path.join(result_path, "regression-0817")
regression_data_path_0904 = os.path.join(result_path, "regression-0904-0906")
regression_data_path_0907 = os.path.join(result_path, "regression-0907")
regression_data_path_0909 = os.path.join(result_path, "regression-0909")


def get_origin_data(period):
    """
    origin data
    """
    data = pd.DataFrame()
    if period == 1:
        eturb_m1_data = pd.read_csv(os.path.join(data_path_0817, "eturb_m1_1min_metrics-0817.csv"), header = 0, index_col = None)
        eturb_m2_data = pd.read_csv(os.path.join(data_path_0817, "eturb_m2_1min_metrics-0817.csv"), header = 0, index_col = None)
        # eturb_m1
        data["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m1_steam_pressure_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m1_steam_temperature_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m1_steam_flow_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m1_steam_pressure_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m1_steam_temperature_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m1_steam_pressure_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m1_steam_temperature_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m1_electricity_generation"] = eturb_m1_data["ExtCondensTurbineOP.electricity_generation"]
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_pressure_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m2_steam_temperature_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_steam_pressure_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m2_steam_temperature_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m2_steam_pressure_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m2_steam_temperature_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]
    elif period == 2:
        eturb_m1_data = pd.read_csv(os.path.join(data_path_0904, "eturb_m1_1min_0904-0906.csv"), header = 0, index_col = None)
        eturb_m2_data = pd.read_csv(os.path.join(data_path_0904, "eturb_m2_1min_0904-0906.csv"), header = 0, index_col = None)
        bturb_m1_data = pd.read_csv(os.path.join(data_path_0904, "bturb_m1_1min_0904-0906.csv"), header = 0, index_col = None)
        # eturb_m1
        data["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m1_steam_pressure_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m1_steam_temperature_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m1_steam_flow_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m1_steam_pressure_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m1_steam_temperature_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m1_steam_pressure_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m1_steam_temperature_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m1_electricity_generation"] = eturb_m1_data["ExtCondensTurbineOP.electricity_generation"]
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_pressure_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m2_steam_temperature_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_steam_pressure_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m2_steam_temperature_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m2_steam_pressure_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m2_steam_temperature_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]
        # bturb_m1
        data["bturb_m1_steam_flow_in"] = bturb_m1_data["BackPresTurbineOP.steam_flow_in"]
        data["bturb_m1_steam_pressure_in"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_in"]
        data["bturb_m1_steam_temperature_in"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_in"]
        data["bturb_m1_steam_pressure_out"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_out"]
        data["bturb_m1_steam_temperature_out"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_out"]
        data["bturb_m1_electricity_generation"] = bturb_m1_data["BackPresTurbineOP.electricity_generation"]
    elif period == 3:
        eturb_m1_data = pd.read_csv(os.path.join(data_path_0907, "eturb_m1_1min_0907.csv"), header = 0, index_col = None)
        eturb_m2_data = pd.read_csv(os.path.join(data_path_0907, "eturb_m2_1min_0907.csv"), header = 0, index_col = None)
        bturb_m1_data = pd.read_csv(os.path.join(data_path_0907, "bturb_m1_1min_0907.csv"), header = 0, index_col = None)
        # eturb_m1
        data["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m1_steam_pressure_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m1_steam_temperature_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m1_steam_flow_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m1_steam_pressure_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m1_steam_temperature_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m1_steam_pressure_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m1_steam_temperature_out"] = eturb_m1_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m1_electricity_generation"] = eturb_m1_data["ExtCondensTurbineOP.electricity_generation"]
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_pressure_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m2_steam_temperature_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_steam_pressure_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m2_steam_temperature_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m2_steam_pressure_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m2_steam_temperature_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]
        # bturb_m1
        data["bturb_m1_steam_flow_in"] = bturb_m1_data["BackPresTurbineOP.steam_flow_in"]
        data["bturb_m1_steam_pressure_in"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_in"]
        data["bturb_m1_steam_temperature_in"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_in"]
        data["bturb_m1_steam_pressure_out"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_out"]
        data["bturb_m1_steam_temperature_out"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_out"]
        data["bturb_m1_electricity_generation"] = bturb_m1_data["BackPresTurbineOP.electricity_generation"]
    elif period == 4:
        bturb_m1_data = pd.read_csv(os.path.join(data_path_0909, "bturb_m1_1min_0909.csv"), header = 0, index_col = None)
        # bturb_m1
        data["bturb_m1_steam_flow_in"] = bturb_m1_data["BackPresTurbineOP.steam_flow_in"]
        data["bturb_m1_steam_pressure_in"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_in"]
        data["bturb_m1_steam_temperature_in"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_in"]
        data["bturb_m1_steam_pressure_out"] = bturb_m1_data["BackPresTurbineOP.steam_pressure_out"]
        data["bturb_m1_steam_temperature_out"] = bturb_m1_data["BackPresTurbineOP.steam_temperature_out"]
        data["bturb_m1_electricity_generation"] = bturb_m1_data["BackPresTurbineOP.electricity_generation"]
    elif period == 5:
        eturb_m2_data = pd.read_csv(os.path.join(data_path_0910, "eturb_m2_1min_0910.csv"), header = 0, index_col = None)
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_pressure_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_in"]
        data["eturb_m2_steam_temperature_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_steam_pressure_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_side"]
        data["eturb_m2_steam_temperature_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_side"]
        data["eturb_m2_steam_pressure_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_pressure_out"]
        data["eturb_m2_steam_temperature_out"] = eturb_m2_data["ExtCondensTurbineOP.steam_temperature_out"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]
    elif period == 6:
        eturb_m1_data = pd.read_csv(os.path.join(data_path_1109, "eturb_m1_1min_1109.csv"), header = 0, index_col = None)
        eturb_m2_data = pd.read_csv(os.path.join(data_path_1109, "eturb_m2_1min_1109.csv"), header = 0, index_col = None)
        # eturb_m1
        data["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m1_steam_flow_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m1_electricity_generation"] = eturb_m1_data["ExtCondensTurbineOP.electricity_generation"]
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]
    elif period == 7:
        eturb_m1_data = pd.read_csv(os.path.join(data_path_1110, "eturb_m1_1min_1110.csv"), header = 0, index_col = None)
        eturb_m2_data = pd.read_csv(os.path.join(data_path_1110, "eturb_m2_1min_1110.csv"), header = 0, index_col = None)
        # eturb_m1
        data["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m1_steam_flow_side"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m1_electricity_generation"] = eturb_m1_data["ExtCondensTurbineOP.electricity_generation"]
        # eturb_m2
        data["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
        data["eturb_m2_steam_flow_side"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_side"]
        data["eturb_m2_electricity_generation"] = eturb_m2_data["ExtCondensTurbineOP.electricity_generation"]

    data = data.reset_index(drop = True)
    
    return data


def data_preprocessing(data, method, is_export_csv = 0):
    """
    data preprocessing
    """
    df = pd.DataFrame()
    if method == "origin":
        df = data.iloc[0:1440]
    elif method == "base":
        df = data.iloc[0:1440]
    elif method == "delta":
        df["eturb_m1_steam_flow_in"] = np.array(data["eturb_m1_steam_flow_in"].iloc[1:1441]) - np.array(data["eturb_m1_steam_flow_in"].iloc[0:1440])
        df["eturb_m1_steam_flow_side"] = np.array(data["eturb_m1_steam_flow_side"].iloc[1:1441]) - np.array(data["eturb_m1_steam_flow_side"].iloc[0:1440])
        df["eturb_m1_electricity_generation"] = np.array(data["eturb_m1_electricity_generation"].iloc[1:1441]) - np.array(data["eturb_m1_electricity_generation"].iloc[0:1440])
        df["eturb_m2_steam_flow_in"] = np.array(data["eturb_m2_steam_flow_in"].iloc[1:1441]) - np.array(data["eturb_m2_steam_flow_in"].iloc[0:1440])
        df["eturb_m2_steam_flow_side"] = np.array(data["eturb_m2_steam_flow_side"].iloc[1:1441]) - np.array(data["eturb_m2_steam_flow_side"].iloc[0:1440])
        df["eturb_m2_electricity_generation"] = np.array(data["eturb_m2_electricity_generation"].iloc[1:1441]) - np.array(data["eturb_m2_electricity_generation"].iloc[0:1440])
        df["bturb_m1_steam_flow_in"] = np.array(data["bturb_m1_steam_flow_in"].iloc[1:1441]) - np.array(data["bturb_m1_steam_flow_in"].iloc[0:1440])
        df["bturb_m1_electricity_generation"] = np.array(data["bturb_m1_electricity_generation"].iloc[1:1441]) - np.array(data["bturb_m1_electricity_generation"].iloc[0:1440])
        df = df.iloc[0:1440]
        if is_export_csv:
            df.to_csv(os.path.join(result_path, "raw_data.csv"), index = None)
    elif method == "mean":
        for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
            temp_df = pd.DataFrame(data.iloc[i:j].mean(axis = 0))
            df = pd.concat([df, temp_df.transpose()], axis = 0, sort = False)
        df = df.iloc[0:1440]
    
    return df


def regression_func(X, Y, fit_intercept):
    reg = linear_model.LinearRegression(fit_intercept = fit_intercept).fit(X, Y)
    if fit_intercept:
        coefs = reg.coef_
        intercept = reg.intercept_
        R2 = reg.score(X, Y)

        return coefs, intercept, R2
    else:
        coefs = reg.coef_
        R2 = reg.score(X, Y)

        return coefs, R2


def eturb_m1_regression(data, method, is_export_csv = 0):
    eturb_m1_result_df = pd.DataFrame()
    for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
        if method == "origin":
            temp_df = data.iloc[i:j]
        elif method == "base":
            temp_df = data.iloc[i:j] - data.iloc[i]
        elif method == "delta":
            temp_df = data.iloc[i:j]
        
        eturb_m1_X_temp = np.array([temp_df["eturb_m1_steam_flow_in"], temp_df["eturb_m1_steam_flow_side"]]).T
        eturb_m1_Y_temp = np.array([temp_df["eturb_m1_electricity_generation"]]).reshape(-1, 1)
        # -----------------------------------------
        # eturb_m1
        # -----------------------------------------
        if method == "origin":
            eturb_m1_coefs, eturb_m1_intercept, eturb_m1_R2 = regression_func(eturb_m1_X_temp, eturb_m1_Y_temp, fit_intercept = True)
            eturb_m1_k1 = eturb_m1_coefs[0][0]
            eturb_m1_k2 = eturb_m1_coefs[0][1]
            eturb_m1_b = eturb_m1_intercept[0]
            eturb_m1_temp_result_df = pd.DataFrame(
                data = {
                    "eturb_m1_origin_k1": [eturb_m1_k1],
                    "eturb_m1_origin_k2": [eturb_m1_k2],
                    "eturb_m1_origin_b": [eturb_m1_b],
                    "eturb_m1_origin_R2": [eturb_m1_R2],
                }, 
                index = None, 
                columns = np.array(["eturb_m1_origin_k1", "eturb_m1_origin_k2", "eturb_m1_origin_b", "eturb_m1_origin_R2"])
            )
        else:
            eturb_m1_coefs, eturb_m1_R2 = regression_func(eturb_m1_X_temp, eturb_m1_Y_temp, fit_intercept = False)
            eturb_m1_k1 = eturb_m1_coefs[0][0]
            eturb_m1_k2 = eturb_m1_coefs[0][1]
            eturb_m1_temp_result_df = pd.DataFrame(
                data = {
                    "eturb_m1_%s_k1" % method: [eturb_m1_k1],
                    "eturb_m1_%s_k2" % method: [eturb_m1_k2],
                    "eturb_m1_%s_R2" % method: [eturb_m1_R2],
                }, 
                index = None, 
                columns = np.array(["eturb_m1_%s_k1" % method, "eturb_m1_%s_k2" % method, "eturb_m1_%s_R2" % method])
            )
        # -----------------------------------------
        # result
        # -----------------------------------------
        eturb_m1_result_df = pd.concat([eturb_m1_result_df, eturb_m1_temp_result_df], axis = 0)
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m1_result_df.to_csv(os.path.join(result_path, "eturb_m1_result_%s.csv") % method, index = None)

    return eturb_m1_result_df


def eturb_m1_regression_all(data, is_export_csv = 0):
    eturb_m1_X_temp = np.array([data["eturb_m1_steam_flow_in"], data["eturb_m1_steam_flow_side"]]).T
    eturb_m1_Y_temp = np.array([data["eturb_m1_electricity_generation"]]).reshape(-1, 1)
    eturb_m1_coefs, eturb_m1_intercept, eturb_m1_R2 = regression_func(eturb_m1_X_temp, eturb_m1_Y_temp, fit_intercept = True)
    eturb_m1_k1 = eturb_m1_coefs[0][0]
    eturb_m1_k2 = eturb_m1_coefs[0][1]
    eturb_m1_b = eturb_m1_intercept[0]
    eturb_m1_temp_result_df = pd.DataFrame(
        data = {
            "eturb_m1_origin_k1": [eturb_m1_k1],
            "eturb_m1_origin_k2": [eturb_m1_k2],
            "eturb_m1_origin_b": [eturb_m1_b],
            "eturb_m1_origin_R2": [eturb_m1_R2],
        }, 
        index = None, 
        columns = np.array(["eturb_m1_origin_k1", "eturb_m1_origin_k2", "eturb_m1_origin_b", "eturb_m1_origin_R2"])
    )
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m1_temp_result_df.to_csv(os.path.join(result_path, "eturb_m1_result.csv"), index = None)

    return eturb_m1_temp_result_df



def eturb_m2_regression(data, method, is_export_csv = 0):
    eturb_m2_result_df = pd.DataFrame()

    for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
        if method == "origin":
            temp_df = data.iloc[i:j]
        elif method == "base":
            temp_df = data.iloc[i:j] - data.iloc[i]
        elif method == "delta":
            temp_df = data.iloc[i:j]
        
        eturb_m2_X_temp = np.array([temp_df["eturb_m2_steam_flow_in"]]).T
        eturb_m2_Y_temp = np.array([temp_df["eturb_m2_electricity_generation"]]).reshape(-1, 1)
        # -----------------------------------------
        # eturb_m2
        # -----------------------------------------
        if method == "origin":
            eturb_m2_coefs, eturb_m2_intercept, eturb_m2_R2 = regression_func(eturb_m2_X_temp, eturb_m2_Y_temp, fit_intercept = True)
            eturb_m2_k1 = eturb_m2_coefs[0][0]
            eturb_m2_b = eturb_m2_intercept[0]
            eturb_m2_temp_result_df = pd.DataFrame(
                data = {
                    "eturb_m2_origin_k1": [eturb_m2_k1],
                    "eturb_m2_origin_b": [eturb_m2_b],
                    "eturb_m2_origin_R2": [eturb_m2_R2],
                },
                index = None, 
                columns = np.array(["eturb_m2_origin_k1", "eturb_m2_origin_b", "eturb_m2_origin_R2"])
            )
        else:
            eturb_m2_coefs, eturb_m2_R2 = regression_func(eturb_m2_X_temp, eturb_m2_Y_temp, fit_intercept = False)
            eturb_m2_k1 = eturb_m2_coefs[0][0]
            eturb_m2_temp_result_df = pd.DataFrame(
                data = {
                    "eturb_m2_%s_k1" % method: [eturb_m2_k1],
                    "eturb_m2_%s_R2" % method: [eturb_m2_R2],
                },
                index = None, 
                columns = np.array(["eturb_m2_%s_k1" % method, "eturb_m2_%s_R2" % method])
            )
        # -----------------------------------------
        # result
        # -----------------------------------------
        eturb_m2_result_df = pd.concat([eturb_m2_result_df, eturb_m2_temp_result_df], axis = 0)
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m2_result_df.to_csv(os.path.join(result_path, "eturb_m2_result_%s.csv") % method, index = None)

    return eturb_m2_result_df


def eturb_m2_regression_all_without_steam_flow_side(data, is_export_csv = 0):
    eturb_m2_X_temp = np.array([data["eturb_m2_steam_flow_in"]]).T
    eturb_m2_Y_temp = np.array([data["eturb_m2_electricity_generation"]]).reshape(-1, 1)
    eturb_m2_coefs, eturb_m2_intercept, eturb_m2_R2 = regression_func(eturb_m2_X_temp, eturb_m2_Y_temp, fit_intercept = True)
    eturb_m2_k1 = eturb_m2_coefs[0][0]
    eturb_m2_b = eturb_m2_intercept[0]
    eturb_m2_temp_result_df = pd.DataFrame(
        data = {
            "eturb_m2_origin_k1": [eturb_m2_k1],
            "eturb_m2_origin_b": [eturb_m2_b],
            "eturb_m2_origin_R2": [eturb_m2_R2],
        },
        index = None, 
        columns = np.array(["eturb_m2_origin_k1", "eturb_m2_origin_b", "eturb_m2_origin_R2"])
    )
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m2_temp_result_df.to_csv(os.path.join(result_path, "eturb_m2_result.csv"), index = None)

    return eturb_m2_temp_result_df

def eturb_m2_regression_all(data, is_export_csv = 0):
    eturb_m2_X_temp = np.array([data["eturb_m2_steam_flow_in"], data["eturb_m2_steam_flow_side"]]).T
    eturb_m2_Y_temp = np.array([data["eturb_m2_electricity_generation"]]).reshape(-1, 1)
    eturb_m2_coefs, eturb_m2_intercept, eturb_m2_R2 = regression_func(eturb_m2_X_temp, eturb_m2_Y_temp, fit_intercept = True)
    eturb_m2_k1 = eturb_m2_coefs[0][0]
    eturb_m2_k2 = eturb_m2_coefs[0][1]
    eturb_m2_b = eturb_m2_intercept[0]
    eturb_m2_temp_result_df = pd.DataFrame(
        data = {
            "eturb_m2_origin_k1": [eturb_m2_k1],
            "eturb_m2_origin_k2": [eturb_m2_k2],
            "eturb_m2_origin_b": [eturb_m2_b],
            "eturb_m2_origin_R2": [eturb_m2_R2],
        },
        index = None, 
        columns = np.array(["eturb_m2_origin_k1", "eturb_m2_origin_k2", "eturb_m2_origin_b", "eturb_m2_origin_R2"])
    )
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m2_temp_result_df.to_csv(os.path.join(result_path, "eturb_m2_result.csv"), index = None)

    return eturb_m2_temp_result_df


def bturb_m1_regression(data, method, is_export_csv = 0):
    bturb_m1_result_df = pd.DataFrame()

    for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
        if method == "origin":
            temp_df = data.iloc[i:j]
        elif method == "base":
            temp_df = data.iloc[i:j] - data.iloc[i]
        elif method == "delta":
            temp_df = data.iloc[i:j]
        
        bturb_m1_X_temp = np.array([temp_df["bturb_m1_steam_flow_in"]]).T
        bturb_m1_Y_temp = np.array([temp_df["bturb_m1_electricity_generation"]]).reshape(-1, 1)
        # -----------------------------------------
        # bturb_m1
        # -----------------------------------------
        if method == "origin":
            bturb_m1_coefs, bturb_m1_intercept, bturb_m1_R2 = regression_func(bturb_m1_X_temp, bturb_m1_Y_temp, fit_intercept = True)
            bturb_m1_k1 = bturb_m1_coefs[0][0]
            bturb_m1_b = bturb_m1_intercept[0]
            bturb_m1_temp_result_df = pd.DataFrame(
                data = {
                    "bturb_m1_origin_k1": [bturb_m1_k1],
                    "bturb_m1_origin_b": [bturb_m1_b],
                    "bturb_m1_origin_R2": [bturb_m1_R2],
                }, 
                index = None, 
                columns = np.array(["bturb_m1_origin_k1", "bturb_m1_origin_b", "bturb_m1_origin_R2"])
            )
        else:
            bturb_m1_coefs, bturb_m1_R2 = regression_func(bturb_m1_X_temp, bturb_m1_Y_temp, fit_intercept = False)
            bturb_m1_k1 = bturb_m1_coefs[0][0]
            bturb_m1_temp_result_df = pd.DataFrame(
                data = {
                    "bturb_m1_%s_k1" % method: [bturb_m1_k1],
                    "bturb_m1_%s_R2" % method: [bturb_m1_R2],
                }, 
                index = None, 
                columns = np.array(["bturb_m1_%s_k1" % method, "bturb_m1_%s_R2" % method])
            )
        # -----------------------------------------
        # result
        # -----------------------------------------
        bturb_m1_result_df = pd.concat([bturb_m1_result_df, bturb_m1_temp_result_df], axis = 0)
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        bturb_m1_result_df.to_csv(os.path.join(result_path, "bturb_m1_result_%s.csv") % method, index = None)

    return bturb_m1_result_df


def bturb_m1_regression_all(data, is_export_csv = 0):
    bturb_m1_X_temp = np.array([data["bturb_m1_steam_flow_in"]]).T
    bturb_m1_Y_temp = np.array([data["bturb_m1_electricity_generation"]]).reshape(-1, 1)
    bturb_m1_coefs, bturb_m1_intercept, bturb_m1_R2 = regression_func(bturb_m1_X_temp, bturb_m1_Y_temp, fit_intercept = True)
    bturb_m1_k1 = bturb_m1_coefs[0][0]
    bturb_m1_b = bturb_m1_intercept[0]
    bturb_m1_temp_result_df = pd.DataFrame(
        data = {
            "bturb_m1_origin_k1": [bturb_m1_k1],
            "bturb_m1_origin_b": [bturb_m1_b],
            "bturb_m1_origin_R2": [bturb_m1_R2],
        }, 
        index = None, 
        columns = np.array(["bturb_m1_origin_k1", "bturb_m1_origin_b", "bturb_m1_origin_R2"])
    )
    # result data export to csv file
    if is_export_csv:
        bturb_m1_temp_result_df.to_csv(os.path.join(result_path, "bturb_m1_result.csv"), index = None)

    return bturb_m1_temp_result_df



def get_result_data(period):
    result_data = pd.DataFrame()
    if period == 1:
        file_names = [
            "eturb_m1_result_base",
            "eturb_m1_result_delta",
            "eturb_m1_result_origin",
            "eturb_m2_result_base",
            "eturb_m2_result_delta",
            "eturb_m2_result_origin",
        ]
        for name in file_names:
            temp_data = pd.read_csv(os.path.join(regression_data_path_0817, "%s.csv" % name), header = 0, index_col = None)
            result_data = pd.concat([result_data, temp_data], axis = 1, sort = False)
    elif period == 2:
        file_names = [
            "eturb_m1_result_base",
            "eturb_m1_result_delta",
            "eturb_m1_result_origin",
            "eturb_m2_result_base",
            "eturb_m2_result_delta",
            "eturb_m2_result_origin",
            "bturb_m1_result_base",
            "bturb_m1_result_delta",
            "bturb_m1_result_origin",
        ]
        for name in file_names:
            temp_data = pd.read_csv(os.path.join(regression_data_path_0904, "%s.csv" % name), header = 0, index_col = None)
            result_data = pd.concat([result_data, temp_data], axis = 1, sort = False)
    elif period == 3:
        file_names = [
            "eturb_m1_result_base",
            "eturb_m1_result_delta",
            "eturb_m1_result_origin",
            "eturb_m2_result_base",
            "eturb_m2_result_delta",
            "eturb_m2_result_origin",
            "bturb_m1_result_base",
            "bturb_m1_result_delta",
            "bturb_m1_result_origin",
        ]
        for name in file_names:
            temp_data = pd.read_csv(os.path.join(regression_data_path_0907, "%s.csv" % name), header = 0, index_col = None)
            result_data = pd.concat([result_data, temp_data], axis = 1, sort = False)

    return result_data



def data_sample(df, x, y, group_number, quantile):
    """
    分组选点法
    x: 分组变量
    y: 取值变量
    """
    group_width = (np.max(df[x]) - np.min(df[x])) / group_number   # 分组宽度
    x_group = np.arange(np.min(df[x]), np.max(df[x]), group_width) # 分组的X
    # 选取每组中设定的分位数的点, 对点数大于零的组选点
    if len(quantile) == 3:
        data_x = np.array([])
        data_y = np.array([])
        for i in x_group:
            if len(df[(df[x] >= i) & (df[x] < i + group_width)]) > 0:
                temp_y = np.array(df[(df[x] >= i) & (df[x] < i + group_width)][y].quantile(quantile))
                temp_x = np.array([(i + group_width / 4), (i + group_width / 2), (i + 3 * group_width / 4)])
                data_x = np.concatenate([data_x, temp_x], axis = 0)
                data_y = np.concatenate([data_y, temp_y], axis = 0)
    elif len(quantile) == 1:
        data_x = []
        data_y = []
        for i in x_group:
            if len(df[(df[x] >= i) & (df[x] < i + group_width)]) > 0:
                temp_y = float(df[(df[x] >= i) & (df[x] < i + group_width)][y].quantile(quantile))
                temp_x = float(i + group_width / 2)
                data_x.append(temp_x)
                data_y.append(temp_y)
    
    return data_x, data_y


def main():
    # ============================================================
    # regression 1
    # ============================================================
    METHOD = "origin"
    # 0907
    df_0907 = get_origin_data(period = 3)
    # eturb_m1
    eturb_m1_result = eturb_m1_regression_all(df_0907, is_export_csv = 0)
    print("eturb_m1 all data regression result:", eturb_m1_result)

    # eturb_m2
    eturb_m2_result = eturb_m2_regression_all(df_0907, is_export_csv = 0)
    print("eturb_m2 all data regression result:", eturb_m2_result)
    
    # bturb_m1 data
    bturb_m1_0907 = df_0907[[
        "bturb_m1_steam_flow_in",
        "bturb_m1_steam_pressure_in",
        "bturb_m1_steam_temperature_in",
        "bturb_m1_electricity_generation",
        "bturb_m1_steam_pressure_out",
        "bturb_m1_steam_temperature_out"
    ]]
    bturb_m1_0909 = get_origin_data(period = 4)
    bturb_m1_all = pd.concat([bturb_m1_0907, bturb_m1_0909], axis = 0, sort = False)
    bturb_m1_result = bturb_m1_regression_all(bturb_m1_all, is_export_csv = 0)
    print("bturb_m1 all data regression result:", bturb_m1_result)
    # ============================================================
    # 分层抽样数据
    # ============================================================
    METHOD = "origin"
    # 0907
    df_0907 = get_origin_data(period = 3)
    # bturb_m1 data
    bturb_m1_0907 = df_0907[[
        "bturb_m1_steam_flow_in",
        "bturb_m1_steam_pressure_in",
        "bturb_m1_steam_temperature_in",
        "bturb_m1_electricity_generation",
        "bturb_m1_steam_pressure_out",
        "bturb_m1_steam_temperature_out"
    ]]
    bturb_m1_0909 = get_origin_data(period = 4)
    bturb_m1_all = pd.concat([bturb_m1_0907, bturb_m1_0909], axis = 0, sort = False)
    # ---------------------------------------
    ## steam_flow_in in [70, 90] && steam_flow_side in [15, 35]
    # ---------------------------------------
    eturb_m1_df = df_0907[[
        "eturb_m1_steam_flow_in",
        "eturb_m1_steam_pressure_in",
        "eturb_m1_steam_temperature_in",
        "eturb_m1_steam_flow_side",
        "eturb_m1_steam_pressure_side",
        "eturb_m1_steam_temperature_side",
        "eturb_m1_steam_pressure_out",
        "eturb_m1_steam_temperature_out",
        "eturb_m1_electricity_generation",
    ]]
    eturb_m1_df = eturb_m1_df[
        (eturb_m1_df["eturb_m1_steam_flow_in"] >= 70) &
        (eturb_m1_df["eturb_m1_steam_flow_in"] <= 90) &
        (eturb_m1_df["eturb_m1_steam_flow_side"] >= 15) &
        (eturb_m1_df["eturb_m1_steam_flow_side"] <= 35)
    ]
    # print(eturb_m1_df)
    #TODO 回归

    # ---------------------------------------
    # steam_flow_in in [50, 60]
    # ---------------------------------------
    eturb_m2_df = df_0907[[
        "eturb_m2_steam_flow_in",
        "eturb_m2_steam_pressure_in",
        "eturb_m2_steam_temperature_in",
        "eturb_m2_steam_flow_side",
        "eturb_m2_steam_pressure_side",
        "eturb_m2_steam_temperature_side",
        "eturb_m2_steam_pressure_out",
        "eturb_m2_steam_temperature_out",
        "eturb_m2_electricity_generation",
    ]]
    eturb_m2_df = eturb_m2_df[
        (eturb_m2_df["eturb_m2_steam_flow_in"] >= 50) & 
        (eturb_m2_df["eturb_m2_steam_flow_in"] <= 60)
    ]
    # print(eturb_m2_df)
    eturb_m2_new_steam_flow_in, eturb_m2_new_electricity_generation = data_sample(
        df = eturb_m2_df, 
        x = "eturb_m2_steam_flow_in", 
        y = "eturb_m2_electricity_generation", 
        group_number = 50, 
        quantile = [0.5]
    )
    # print(eturb_m2_new_steam_flow_in)
    # print(eturb_m2_new_electricity_generation)
    eturb_m2_data = pd.DataFrame({
        "eturb_m2_steam_flow_in": eturb_m2_new_steam_flow_in,
        "eturb_m2_electricity_generation": eturb_m2_new_electricity_generation
    })
    # print(eturb_m2_data)
    eturb_m2_result = eturb_m2_regression_all(eturb_m2_data, is_export_csv = 0)
    print("eturb_m2 sample data regression result:", eturb_m2_result)
    # ---------------------------------------
    # steam_flow_in in [26, 32]
    # ---------------------------------------
    bturb_m1_df = bturb_m1_all[
        (bturb_m1_all["bturb_m1_steam_flow_in"] >= 26) & 
        (bturb_m1_all["bturb_m1_steam_flow_in"] <= 32)
    ]
    # print(bturb_m1_df)
    bturb_m1_new_steam_flow_in, bturb_m1_new_electricity_generation = data_sample(
        df = bturb_m1_df, 
        x = "bturb_m1_steam_flow_in", 
        y = "bturb_m1_electricity_generation", 
        group_number = 50, 
        quantile = [0.5]
    )
    # print(bturb_m1_new_steam_flow_in)
    # print(bturb_m1_new_electricity_generation)

    bturb_m1_data = pd.DataFrame({
        "bturb_m1_steam_flow_in": bturb_m1_new_steam_flow_in,
        "bturb_m1_electricity_generation": bturb_m1_new_electricity_generation
    })
    # print(bturb_m1_data)
    bturb_m1_result = bturb_m1_regression_all(bturb_m1_data, is_export_csv = 0)
    print("bturb_m1 sample data regression result:", bturb_m1_result)


if __name__ == "__main__":
    eturb_m2_0910 = get_origin_data(period = 5)
    print(eturb_m2_0910)