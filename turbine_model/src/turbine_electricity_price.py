# -*- coding: utf-8 -*-
import numpy as np
import traceback
import logging
import settings


# 外购电价峰值、谷值、平值时间区间段
timezone_min_lower_1 = settings.TIMEZONE_MIN_LOWER_1
timezone_min_upper_1 = settings.TIMEZONE_MIN_UPPER_1
timezone_mid_lower_1 = settings.TIMEZONE_MID_LOWER_1
timezone_mid_upper_1 = settings.TIMEZONE_MID_UPPER_1
timezone_mid_lower_2 = settings.TIMEZONE_MID_LOWER_2
timezone_mid_upper_2 = settings.TIMEZONE_MID_UPPER_2
timezone_mid_lower_3 = settings.TIMEZONE_MID_LOWER_3
timezone_mid_upper_3 = settings.TIMEZONE_MID_UPPER_3
timezone_max_lower_1 = settings.TIMEZONE_MAX_LOWER_1
timezone_max_upper_1 = settings.TIMEZONE_MAX_UPPER_1
timezone_max_lower_2 = settings.TIMEZONE_MAX_LOWER_2
timezone_max_upper_2 = settings.TIMEZONE_MAX_UPPER_2


def electricity_power_ext_array_preprocessing(electricity_power_ext):
    """
    外购电电功率处理
    """
    relu = lambda x: x if x >= -0.7 else 0
    electricity_power_new = [relu(x) for x in electricity_power_ext]
    electricity_power_ext_preprocessed = np.array(electricity_power_new)

    return electricity_power_ext_preprocessed


def electricity_price_ext_array_preprocessing_v1(electricity_power_ext, electricity_price_ext_buy, electricity_price_sale):
    """
    外购电电价处理
    """
    relu = lambda x, y: y if x >= settings.ELECTRICITY_POWER_EXT_SALE_THREAD else electricity_price_sale
    electricity_price_ext = np.array([relu(x, y) for x, y in zip(electricity_power_ext, electricity_price_ext_buy)])

    return electricity_price_ext


def electricity_price_ext_array_preprocessing(electricity_power_ext, electricity_price_ext_buy):
    """
    外购电电价处理
    """
    relu = lambda x, y: y if x >= settings.ELECTRICITY_POWER_EXT_SALE_THREAD else 0
    electricity_price_ext = np.array([relu(x, y) for x, y in zip(electricity_power_ext, electricity_price_ext_buy)])

    return electricity_price_ext


def electricity_price_ext_preprocessing(electricity_power_ext, electricity_price_buy, electricity_price_sale):
    """
    外购电电价处理
    """
    electricity_price_ext = electricity_price_buy if electricity_power_ext >= settings.ELECTRICITY_POWER_EXT_SALE_THREAD else electricity_price_sale

    return electricity_price_ext


def calculate_electricity_price_ext(now_hour, electricity_price_ext_peak, electricity_price_ext_valley, electricity_price_ext_flat):
    """
    外购电电价计算
    """
    try:
        if now_hour >= timezone_min_lower_1 and now_hour < timezone_min_upper_1:
            electricity_price_ext = electricity_price_ext_valley
        elif (now_hour >= timezone_mid_lower_1 and now_hour < timezone_mid_upper_1) or \
            (now_hour >= timezone_mid_lower_2 and now_hour < timezone_mid_upper_2) or \
            (now_hour >= timezone_mid_lower_3 and now_hour <= timezone_mid_upper_3):
            electricity_price_ext = electricity_price_ext_flat
        elif (now_hour >= timezone_max_lower_1 and now_hour < timezone_max_upper_1) or \
            (now_hour >= timezone_max_lower_2 and now_hour < timezone_max_upper_2):
            electricity_price_ext = electricity_price_ext_peak
    except:
        electricity_price_ext = np.nan
        traceback.print_exc()

    return electricity_price_ext


def calculate_electricity_price(current_hour,
                                hp_steam_dayprice, 
                                lp_steam_dayprice, 
                                steam_flow_in, 
                                steam_flow_side, 
                                electricity_generation,
                                electricity_price_ext_peak,
                                electricity_price_ext_valley, 
                                electricity_price_ext_flat,
                                electricity_price_sale,
                                electricity_power_ext):
    """
    汽轮发电机组自发电电价计算、外购电电价计算、综合电价计算
    """
    try:
        # 自发电电价计算
        electricity_price_gene = (hp_steam_dayprice * steam_flow_in - lp_steam_dayprice * steam_flow_side) / (electricity_generation * 1000)
        
        # 外购电电价处理
        electricity_price_ext_buy = calculate_electricity_price_ext(                    # 峰谷平电价
            current_hour, 
            electricity_price_ext_peak, 
            electricity_price_ext_valley, 
            electricity_price_ext_flat)
        electricity_price_ext = electricity_price_ext_preprocessing(                    # 外购电、外卖电电价
            electricity_power_ext, 
            electricity_price_ext_buy, 
            electricity_price_sale
        )
        
        # 综合电价计算
        electricity_price_overall = ((electricity_generation) * electricity_price_gene + (electricity_power_ext) * electricity_price_ext) / \
                                    ((electricity_generation) + electricity_power_ext)
    except:
        electricity_price_gene = np.nan
        electricity_price_ext = np.nan
        electricity_price_overall = np.nan
        traceback.print_exc()

    results = {
        "electricity_price_gene": electricity_price_gene,
        "electricity_price_ext": electricity_price_ext,
        "electricity_price_overall": electricity_price_overall
    }

    return results


def calculate_electricity_dayprice(hp_steam_dayprice,
                                   lp_steam_dayprice,
                                   steam_flow_in,
                                   steam_flow_side,
                                   electricity_generation,
                                   electricity_power_ext,
                                   # electricity_price_ext_peak, 
                                   # electricity_price_ext_valley, 
                                   # electricity_price_ext_flat,
                                   # electricity_price_sale,
                                   electricity_price_ext):
    """
    每天用电成本计算：自发电、外购电、综合用电成本
        - Task 调度：每天 23:59:59 计算一次
    """
    # 自发电日成本
    try:
        electricity_dayprice_int = (hp_steam_dayprice * np.sum(steam_flow_in) - lp_steam_dayprice * np.sum(steam_flow_side)) / (np.sum(electricity_generation) * 1000)
    except:
        electricity_dayprice_int = np.nan
        traceback.print_exc()
    
    # 外购电日成本
    try:
        # electricity_price_ext_array = []
        # for i in range(24):
        #     electricity_price_ext = calculate_electricity_price_ext(
        #         i, electricity_price_ext_peak, electricity_price_ext_valley, electricity_price_ext_flat
        #     )
        #     electricity_price_ext_array.append(electricity_price_ext)
        # if len(electricity_power_ext) < 24:
        #     electricity_price_ext_array = electricity_price_ext_array[-len(electricity_power_ext):]

        # electricity_price_ext = electricity_price_ext_array_preprocessing(
        #     electricity_power_ext, 
        #     electricity_price_ext_array, 
        #     electricity_price_sale
        # )
        electricity_price_ext = electricity_price_ext_array_preprocessing(
            electricity_power_ext, 
            electricity_price_ext
        )
        electricity_power_ext = electricity_power_ext_array_preprocessing(
            electricity_power_ext
        )
        electricity_dayprice_ext = (np.sum(electricity_power_ext * electricity_price_ext)) / np.sum(electricity_power_ext)
    except:
        electricity_dayprice_ext = np.nan
        traceback.print_exc()
    
    # 综合电成本
    try:
        electricity_dayprice_overall = (np.sum(electricity_power_ext * electricity_price_ext) + (electricity_dayprice_int * np.sum(electricity_generation))) / \
                                       (np.sum(electricity_power_ext) + np.sum(electricity_generation))
    except:
        electricity_dayprice_overall = np.nan
        traceback.print_exc()
    
    if electricity_dayprice_int is np.nan or electricity_dayprice_ext is np.nan or electricity_dayprice_overall is np.nan:
        electricity_dayprice_int = np.nan
        electricity_dayprice_ext = np.nan
        electricity_dayprice_overall = np.nan
    
    results = {
        "electricity_dayprice_int": electricity_dayprice_int,
        "electricity_dayprice_ext": electricity_dayprice_ext,
        "electricity_dayprice_overall": electricity_dayprice_overall
    }

    return results
