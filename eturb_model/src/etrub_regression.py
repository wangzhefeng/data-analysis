#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import os
import sys
import numpy as np
import pandas as pd
from sklearn import linear_model
from sklearn.metrics import r2_score
import seuif97


def get_origin_data():
    """
    origin data
    """
    # raw data
    eturb_m1_data = pd.read_csv("/mnt/e/dev/test/eturb_model/data/eturb_m1_1min_metrics.csv", header = 0, index_col = None)
    eturb_m2_data = pd.read_csv("/mnt/e/dev/test/eturb_model/data/eturb_m2_1min_metrics.csv", header = 0, index_col = None)
    
    data = pd.DataFrame()
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
    data = data.reset_index(drop = True)
    
    return data


def get_result_data():
    result_data = pd.DataFrame()
    file_names = [
        "eturb_m1_result_base",
        "eturb_m1_result_delta",
        "eturb_m1_result_origin",
        "eturb_m2_result_base",
        "eturb_m2_result_delta",
        "eturb_m2_result_origin"
    ]
    for name in file_names:
        temp_data = pd.read_csv("/mnt/e/dev/test/eturb_model/result/regression/%s.csv" % name, header = 0, index_col = None)
        result_data = pd.concat([result_data, temp_data], axis = 1, sort = False)

    return result_data


def data_preprocessing(data, method, is_export_csv = 0):
    """
    data preprocessing
    """
    df = pd.DataFrame()
    if method == "origin":
        df = data
    elif method == "base":
        df = data
    elif method == "delta":
        df["eturb_m1_steam_flow_in"] = np.array(data["eturb_m1_steam_flow_in"].iloc[1:1441]) - np.array(data["eturb_m1_steam_flow_in"].iloc[0:1440])
        df["eturb_m1_steam_flow_side"] = np.array(data["eturb_m1_steam_flow_side"].iloc[1:1441]) - np.array(data["eturb_m1_steam_flow_side"].iloc[0:1440])
        df["eturb_m1_electricity_generation"] = np.array(data["eturb_m1_electricity_generation"].iloc[1:1441]) - np.array(data["eturb_m1_electricity_generation"].iloc[0:1440])
        df["eturb_m2_steam_flow_in"] = np.array(data["eturb_m2_steam_flow_in"].iloc[1:1441]) - np.array(data["eturb_m2_steam_flow_in"].iloc[0:1440])
        df["eturb_m2_steam_flow_side"] = np.array(data["eturb_m2_steam_flow_side"].iloc[1:1441]) - np.array(data["eturb_m2_steam_flow_side"].iloc[0:1440])
        df["eturb_m2_electricity_generation"] = np.array(data["eturb_m2_electricity_generation"].iloc[1:1441]) - np.array(data["eturb_m2_electricity_generation"].iloc[0:1440])
        if is_export_csv:
            df.to_csv("/mnt/e/dev/test/eturb_model/result/raw_data.csv", index = None)
    elif method == "mean":
        for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
            temp_df = pd.DataFrame(data.iloc[i:j].mean(axis = 0))
            df = pd.concat([df, temp_df.transpose()], axis = 0, sort = False)
    
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


def main_v1(data, method, is_export_csv = 0):
    eturb_m1_result_df = pd.DataFrame()
    eturb_m2_result_df = pd.DataFrame()
    for i, j in zip(range(0, 1450, 10), range(60, 1450, 10)):
        if method == "origin":
            temp_df = data.iloc[i:j]
        elif method == "base":
            temp_df = data.iloc[i:j] - data.iloc[i]
        elif method == "delta":
            temp_df = data.iloc[i:j]
        
        eturb_m1_X_temp = np.array([temp_df["eturb_m1_steam_flow_in"], temp_df["eturb_m1_steam_flow_side"]]).T
        eturb_m1_Y_temp = np.array([temp_df["eturb_m1_electricity_generation"]]).reshape(-1, 1)
        eturb_m2_X_temp = np.array([temp_df["eturb_m2_steam_flow_in"], temp_df["eturb_m2_steam_flow_side"]]).T
        eturb_m2_Y_temp = np.array([temp_df["eturb_m2_electricity_generation"]]).reshape(-1, 1)
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
        # eturb_m2
        # -----------------------------------------
        if method == "origin":
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
        else:
            eturb_m2_coefs, eturb_m2_R2 = regression_func(eturb_m2_X_temp, eturb_m2_Y_temp, fit_intercept = False)
            eturb_m2_k1 = eturb_m2_coefs[0][0]
            eturb_m2_k2 = eturb_m2_coefs[0][1]
            eturb_m2_temp_result_df = pd.DataFrame(
                data = {
                    "eturb_m2_%s_k1" % method: [eturb_m2_k1],
                    "eturb_m2_%s_k2" % method: [eturb_m2_k2],
                    "eturb_m2_%s_R2" % method: [eturb_m2_R2],
                },
                index = None, 
                columns = np.array(["eturb_m2_%s_k1" % method, "eturb_m2_%s_k2" % method, "eturb_m2_%s_R2" % method])
            )
        # -----------------------------------------
        # result
        # -----------------------------------------
        eturb_m1_result_df = pd.concat([eturb_m1_result_df, eturb_m1_temp_result_df], axis = 0)
        eturb_m2_result_df = pd.concat([eturb_m2_result_df, eturb_m2_temp_result_df], axis = 0)
    # -----------------------------------------
    # result data export to csv file
    # -----------------------------------------
    if is_export_csv:
        eturb_m1_result_df.to_csv("/mnt/e/dev/test/eturb_model/result/eturb_m1_result_%s.csv" % method, index = None)
        eturb_m2_result_df.to_csv("/mnt/e/dev/test/eturb_model/result/eturb_m2_result_%s.csv" % method, index = None)

    return eturb_m1_result_df, eturb_m2_result_df


def main_v2_eturb_m2(result_df, df, is_export_csv = 0):
    result_df = result_df[["eturb_m2_origin_k1", "eturb_m2_origin_k2"]].reset_index(drop = True)
    df = df[
        [
            "eturb_m2_steam_pressure_in", 
            "eturb_m2_steam_temperature_in",  
            "eturb_m2_steam_pressure_side", 
            "eturb_m2_steam_temperature_side", 
            "eturb_m2_steam_pressure_out", 
            "eturb_m2_steam_temperature_out"
        ]
    ].reset_index(drop=True)
    # df["eturb_m1_steam_pressure_out"] = (df["eturb_m1_steam_pressure_out"] + 101) / 1000
    h_df = pd.DataFrame()
    for col in range(len(df)):
        df_col = df.iloc[col]
        eturb_m1_h0 = seuif97.pt2h(df_col["eturb_m2_steam_pressure_in"], df_col["eturb_m2_steam_temperature_in"])
        eturb_m1_hc = seuif97.pt2h((df_col["eturb_m2_steam_pressure_out"] + 101) / 1000, df_col["eturb_m2_steam_temperature_out"])
        eturb_m1_h1 = seuif97.pt2h(df_col["eturb_m2_steam_pressure_side"], df_col["eturb_m2_steam_temperature_side"])
        temp_df = pd.DataFrame(
            data = {
                "eturb_m2_h0": [eturb_m1_h0],
                "eturb_m2_hc": [eturb_m1_hc],
                "eturb_m2_h1": [eturb_m1_h1],
            },
            index = None, 
            columns = np.array(["eturb_m2_h0", "eturb_m2_hc", "eturb_m2_h1"])
        )
        h_df = pd.concat([h_df, temp_df], axis = 0, sort = False).reset_index(drop = True)
    # --------------------------------------------------------------
    # input data export to csv file
    # --------------------------------------------------------------
    if is_export_csv:
        final_df = pd.concat([result_df, df, h_df], axis = 1)
        final_df.to_csv("/mnt/e/dev/test/eturb_model/result/eturb_m2_pressure_k1_k2_enthalpy.csv", index = None)


def main_v2_eturb_m1(result_df, df, is_export_csv = 0):
    result_df = result_df[["eturb_m1_origin_k1", "eturb_m1_origin_k2"]].reset_index(drop = True)
    df = df[
        [
            "eturb_m1_steam_pressure_in", 
            "eturb_m1_steam_temperature_in",  
            "eturb_m1_steam_pressure_side", 
            "eturb_m1_steam_temperature_side", 
            "eturb_m1_steam_pressure_out", 
            "eturb_m1_steam_temperature_out"
        ]
    ].reset_index(drop=True)
    # df["eturb_m1_steam_pressure_out"] = (df["eturb_m1_steam_pressure_out"] + 101) / 1000
    h_df = pd.DataFrame()
    for col in range(len(df)):
        df_col = df.iloc[col]
        eturb_m1_h0 = seuif97.pt2h(df_col["eturb_m1_steam_pressure_in"], df_col["eturb_m1_steam_temperature_in"])
        eturb_m1_hc = seuif97.pt2h((df_col["eturb_m1_steam_pressure_out"] + 101) / 1000, df_col["eturb_m1_steam_temperature_out"])
        eturb_m1_h1 = seuif97.pt2h(df_col["eturb_m1_steam_pressure_side"], df_col["eturb_m1_steam_temperature_side"])
        temp_df = pd.DataFrame(
            data = {
                "eturb_m1_h0": [eturb_m1_h0],
                "eturb_m1_hc": [eturb_m1_hc],
                "eturb_m1_h1": [eturb_m1_h1],
            },
            index = None, 
            columns = np.array(["eturb_m1_h0", "eturb_m1_hc", "eturb_m1_h1"])
        )
        h_df = pd.concat([h_df, temp_df], axis = 0, sort = False).reset_index(drop = True)
    # --------------------------------------------------------------
    # input data export to csv file
    # --------------------------------------------------------------
    if is_export_csv:
        final_df = pd.concat([result_df, df, h_df], axis = 1)
        final_df.to_csv("/mnt/e/dev/test/eturb_model/result/eturb_m1_pressure_k1_k2_enthalpy.csv", index = None)
    # --------------------------------------------------------------
    # k1 ~ a(P_in - P_out) + b
    # --------------------------------------------------------------
    k1_X = np.array([df["eturb_m1_steam_pressure_in"] - df["eturb_m1_steam_pressure_out"]]).T
    k1_Y = np.array([result_df["eturb_m1_origin_k1"]]).reshape(-1, 1)
    k1_coefs, k1_intercept, k1_R2 = regression_func(k1_X, k1_Y, fit_intercept = True)
    k1_a = k1_coefs[0][0]
    k1_b = k1_intercept[0]
    print(k1_a, k1_b, k1_R2)
    # --------------------------------------------------------------
    # k1 ~ a(H_in - H_out) + b
    # --------------------------------------------------------------
    k1_h_X = np.array([h_df["eturb_m1_h0"] - h_df["eturb_m1_hc"]]).T
    k1_Y = np.array([result_df["eturb_m1_origin_k1"]]).reshape(-1, 1)
    k1_h_coefs, k1_h_intercept, k1_h_R2 = regression_func(k1_h_X, k1_Y, fit_intercept = True)
    k1_h_a = k1_h_coefs[0][0]
    k1_h_b = k1_h_intercept[0]
    print(k1_h_a, k1_h_b, k1_h_R2)
    # --------------------------------------------------------------
    # k2 ~ a(P_in - P_side) + b
    # --------------------------------------------------------------
    k2_X = np.array([df["eturb_m1_steam_pressure_out"] - df["eturb_m1_steam_pressure_side"]]).T
    k2_Y = np.array([result_df["eturb_m1_origin_k2"]]).reshape(-1, 1)

    k2_coefs, k2_intercept, k2_R2 = regression_func(k2_X, k2_Y, fit_intercept = True)
    k2_a = k2_coefs[0][0]
    k2_b = k2_intercept[0]
    print(k2_a, k2_b, k2_R2)
    # --------------------------------------------------------------
    # k2 ~ a(H_side - H_out) + b
    # --------------------------------------------------------------
    k2_h_X = np.array([h_df["eturb_m1_hc"] - h_df["eturb_m1_h1"]]).T
    k2_Y = np.array([result_df["eturb_m1_origin_k2"]]).reshape(-1, 1)
    k2_h_coefs, k2_h_intercept, k2_h_R2 = regression_func(k2_h_X, k2_Y, fit_intercept = True)
    k2_h_a = k2_h_coefs[0][0]
    k2_h_b = k2_h_intercept[0]
    print(k2_h_a, k2_h_b, k2_h_R2)


def main_v3(df, method):
    df = df[
        [
            "eturb_m1_steam_flow_in", 
            "eturb_m1_steam_flow_side", 
            "eturb_m1_electricity_generation",
            # "eturb_m2_steam_flow_in", 
            # "eturb_m2_steam_flow_side", 
            # "eturb_m2_electricity_generation"
        ]
    ].reset_index(drop = True).iloc[0:1440]
    if method == "base":
        regression_df = pd.DataFrame()
        for i in range(len(df)):
            temp_df = pd.DataFrame(df.iloc[i] - df.iloc[0])
            regression_df = pd.concat([regression_df, temp_df.transpose()], axis = 0, sort = False)
    elif method == "origin":
        regression_df = df
    
    eturb_m1_X_temp = np.array([regression_df["eturb_m1_steam_flow_in"], regression_df["eturb_m1_steam_flow_side"]]).T
    eturb_m1_Y_temp = np.array([regression_df["eturb_m1_electricity_generation"]]).reshape(-1, 1)
    coefs, intercept, R2 = regression_func(eturb_m1_X_temp, eturb_m1_Y_temp, fit_intercept = True)
    a = coefs[0][0]
    b = intercept[0]
    print("Alpha1: %s, Alpha2: %s, R2 Score: %s" % (a, b, R2))


if __name__ == "__main__":
    # ============================================================
    # regression 1
    # ============================================================
    # METHOD = "origin"
    # data = get_origin_data()
    # df = data_preprocessing(data, method = METHOD, is_export_csv = 0)
    # eturb_m1_result_df, eturb_m2_result_df = main_v1(df, method = METHOD)
    # ============================================================
    # regression 2
    # ============================================================
    # METHOD = "mean"
    # result_df = get_result_data()
    # data = get_origin_data()
    # df = data_preprocessing(data, method = METHOD, is_export_csv = 0)
    # main_v2_eturb_m1(result_df, df, is_export_csv = 0)
    # main_v2_eturb_m2(result_df, df, is_export_csv = 1)
    # ============================================================
    # regression 3
    # ============================================================
    METHOD = "origin"
    data = get_origin_data()
    df = data_preprocessing(data, method = METHOD, is_export_csv = 0)
    main_v3(df, method = METHOD)
    
    
