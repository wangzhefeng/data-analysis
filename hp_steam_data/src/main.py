#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import numpy as np
import pandas as pd
import os


PROJECT_PATH = "/mnt/e/dev/test/hp_steam_data/"
DATA_PATH = os.path.join(PROJECT_PATH, "data")
RESULT_PATH = os.path.join(PROJECT_PATH, "result")


def get_origin_data():
    """
    origin data
    """
    # raw data
    eturb_m1_data = pd.read_csv("/mnt/e/dev/test/hp_steam_data/data/eturb_m1_1min_metrics-0817.csv", header = 0, index_col = None)
    eturb_m2_data = pd.read_csv("/mnt/e/dev/test/hp_steam_data/data/eturb_m2_1min_metrics-0817.csv", header = 0, index_col = None)
    boiler_m1_data = pd.read_csv("/mnt/e/dev/test/hp_steam_data/data/boiler_m1_1min_outlet_steam_flow.csv", header = 0, index_col = None)
    boiler_m3_data = pd.read_csv("/mnt/e/dev/test/hp_steam_data/data/boiler_m3_1min_outlet_steam_flow.csv", header = 0, index_col = None)
    steampipeline_p1_data = pd.read_csv("/mnt/e/dev/test/hp_steam_data/data/steampipeline_p1_1min_hp_steam_pressure.csv", header = 0, index_col = None)
    # data aggregate
    df = pd.DataFrame()
    # eturb_m1
    df["eturb_m1_steam_flow_in"] = eturb_m1_data["ExtCondensTurbineOP.steam_flow_in"]
    df["eturb_m2_steam_flow_in"] = eturb_m2_data["ExtCondensTurbineOP.steam_flow_in"]
    df["boiler_m1_outlet_steam_flow"] = boiler_m1_data["CFBoilerOP.outlet_steam_flow"]
    df["boiler_m3_outlet_steam_flow"] = boiler_m3_data["CFBoilerOP.outlet_steam_flow"]
    df["steampipeline_p1_hp_steam_pressure"] = steampipeline_p1_data["SteamPipelineOP.hp_steam_pressure"]
    df["boiler_steam_flow"] = df["boiler_m1_outlet_steam_flow"] + df["boiler_m3_outlet_steam_flow"]
    df["turbine_steam_flow"] = df["eturb_m1_steam_flow_in"] + df["eturb_m2_steam_flow_in"]
    df = df.reset_index(drop = True)
    
    return df




def main():
    # print(os.listdir(DATA_PATH))
    df = get_origin_data()
    print(df.head())
    # df.to_csv("/mnt/e/dev/test/hp_steam_data/result/steam_pressure_data.csv", index = None)


if __name__ == "__main__":
    main()




