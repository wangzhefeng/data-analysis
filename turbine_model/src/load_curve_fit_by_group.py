import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

def func(x, a, b):
    """
    回归方程y = a + b / x
    """
    return a + b / x

def calculate_points_below(df, func, a, b):
    """
    计算实际点在拟合曲线下面的占比的函数
    input:
        df - DataFrame
        func - 回归方程
        a - 位置参数
        b - 形状参数
    output:
        points_below_percent - 实际点在拟合曲线下面的占比
    """
    df["unit_energy_consumption_simulated"] = df["unit_production_actual"].apply(lambda x: func(x, a, b))
    for i in df.index:
        df.loc[i, "points_below"] = 1 if df.loc[i, "unit_energy_consumption_actual"] <= df.loc[i, "unit_energy_consumption_simulated"] else 0
    points_below_percent = df["points_below"].sum()/len(df)
    
    return points_below_percent

def load_curve_fit_by_group(df, group_number, X_min, X_max, set_quantile):
    """
    分组选点法拟合负载曲线
    input:
        df - DataFrame
        group_number - 分组个数
        X_min - X最小值
        X_max - X最大值
        set_quantile - 设置分位数
    output:
        a - 位置参数
        b - 形状参数
        points_below_percent - 实际点在拟合曲线下面的占比
    """
    group_width = int((X_max - X_min) / group_number)   # 分组宽度
    X_group = np.arange(X_min, X_max, group_width)      # 分组的X

    # 选取每组设定分位数的点
    X = []
    y = []
    for i in X_group:
        # 对点数大于零的组选点
        if len(df[(df["unit_production_actual"] >= i) & (df["unit_production_actual"] < i + group_width)]) > 0:
            temp_y = df[(df["unit_production_actual"] >= i) & (df["unit_production_actual"] < i + group_width)] ["unit_energy_consumption_actual"].quantile(set_quantile)
            y.append(temp_y)
            # X取每组中值
            temp_X = i + group_width / 2
            X.append(temp_X)
    popt, pcov = curve_fit(func, X, y)
    a = popt[0]
    b = popt[1]
    points_below_percent = calculate_points_below(df, func, a, b)

    return a, b, points_below_percent

if __name__ == "__main__":
    # # 读取csv文件计算实际单耗
    # df = pd.read_csv("original_data.csv")
    # df.columns=["timestamp", "unit_production_actual", "energy_consumption_actual"]
    # df["unit_energy_consumption_actual"] = df["energy_consumption_actual"] / df["unit_production_actual"]
    # # 拟合负载曲线
    # a, b, points_below_percent = load_curve_fit_by_group(df, 20, 4000, 11000, 0.1)

    # print("a: {}, b: {}, points_below_percent: {}".format(a, b, points_below_percent))

    # # 画图展示实际点和拟合曲线
    # plt.figure(figsize=(12, 8))
    # xdata = df["unit_production_actual"]                # 实际产量
    # ydata = df["unit_energy_consumption_actual"]        # 实际单耗
    # plt.plot(xdata, ydata, '*',label='original values')
    # plt.plot(xdata, df["unit_energy_consumption_simulated"], '*',label='curve_fit values')
    # plt.xlabel('x axis')
    # plt.ylabel('y axis')
    # plt.legend(loc=1)
    # plt.title('curve_fit')
    # plt.show()
    X_max = 100
    X_min = 0
    group_num = 20
    group_width = int((X_max - X_min) / group_number)   # 分组宽度
    X_group = np.arange(X_min, X_max, group_width)      # 分组的X
