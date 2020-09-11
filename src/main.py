

import numpy as np
import pandas as pd


df = pd.DataFrame({
    "a": [
        70.871667,
        70.426667,
        70.048333,
        70.466667,
        70.960000,
        70.340909,
        70.606667,
        70.809091,
        70.785455,
        70.812500,
        70.903333,
        70.900000,
        70.949091,
        70.955000,
        70.831667,
        70.838333,
        70.308182,
        70.766667,
        70.670833,
        71.000000,
        70.327500,
        70.680909,
        70.947273,
        70.904167,
        70.272727
    ]
})
print(df["a"].quantile(0.5))




def data_sample(df, x, y, group_number, x_min, x_max, quantile):
    """
    分组选点法
    """
    x_min = np.min(df[x])
    x_max = np.max(df[y])
    group_width = int((x_max - x_min) / group_number)   # 分组宽度
    x_group = np.arange(x_min, x_max, group_width)      # 分组的X

    # 选取每组中设定的分位数的点
    # 对点数大于零的组选点
    data = []
    for i in x_group:
        if len(df[(df[x] >= i) & (df[x] < i + group_width)]) > 0:
            temp_x = df[(df[x] >= i) & (df[x] < i + group_width)][y].quantile(quantile)
            data.append(temp_x)
    
    return data