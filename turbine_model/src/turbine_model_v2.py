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
        final_df.to_csv("/mnt/e/dev/data-analysis/eturb_model/result/eturb_m1_pressure_k1_k2_enthalpy.csv", index = None)
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
        final_df.to_csv("/mnt/e/dev/data-analysis/eturb_model/result/eturb_m2_pressure_k1_k2_enthalpy.csv", index = None)


def main_v2_bturb_m1(result_df, df, is_export_csv = 0):
    pass


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