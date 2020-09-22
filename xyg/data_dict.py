import os
import numpy as np
import pandas as pd
import datetime

HOST = "47.98.51.189:3306"
DATABASE = "xyg_qm"
DATA_PATH = "/mnt/e/dev/data-analysis/xyg/xyg_0922.xlsx"
RESULT_PATH = "/mnt/e/dev/data-analysis/xyg/result"
TIMESTAMP = '{0:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now())
SQL_FILE = os.path.join(RESULT_PATH, "xyg_%s.sql" % TIMESTAMP)


def write_sql_string(sql):
    final_sql_header = "SET NAMES utf8mb4;\nSET FOREIGN_KEY_CHECKS = 0;\n\n"
    with open(SQL_FILE, "a") as f:
        f.write(final_sql_header)
        f.write(sql)


def get_database_tabel_parameters():
    table = pd.read_excel(DATA_PATH, sheet_name = "table", header = 0)
    table.reset_index(drop = True)

    return table


def get_sql_string(table):
    final_sql_string = str()
    for index, table_row in table.iterrows():
        table_name = table_row[1]
        table_data = pd.read_excel(DATA_PATH, sheet_name = table_row[0], header = 0, keep_default_na = False)
        table_data.reset_index(drop = True)
        # 主键参数
        primary_key = table_data[table_data["主键"] == 1]["字段名称"].iloc[0]
        # 外键参数
        # foreign_key = table_data[table_data["外键"] == 1]["字段名称"].iloc[0]
        # master_table = table_data[table_data["外键"] == 1]["外连表"]
        # master_table_primary_key = table_data[table_data["外键"] == 1]["外联表字段"]
        # 字段参数
        sql_string = str()
        for table_data_index, table_data_table_row in table_data.iterrows():
            field_name = table_data_table_row[2]
            field_type = table_data_table_row[3]
            field_type_length = table_data_table_row[4]
            field_default = table_data_table_row[6]
            if field_default == "DEFAULT NULL":
                field_is_null = "NULL"
            else:
                field_is_null = table_data_table_row[5]
            field_comment = table_data_table_row[1]
            # ---------------------
            # SQL String
            # ---------------------
            if field_type == "VARCHAR" or field_type == "DATETIME":
                sql_row = "    `%s` %s %s %s COMMENT '%s'" % (
                    field_name, 
                    field_type + "(" + str(int(field_type_length)) + ")", 
                    field_is_null, 
                    field_default, 
                    field_comment
                )
            elif field_type == "DOUBLE":
                sql_row = "    `%s` %s %s %s COMMENT '%s'" % (
                    field_name, 
                    field_type + field_type_length, 
                    field_is_null, 
                    field_default, 
                    field_comment
                )
            else:
                sql_row = "    `%s` %s %s %s %s COMMENT '%s'" % (
                    field_name, 
                    field_type, 
                    str(field_type_length), 
                    field_is_null, 
                    field_default, 
                    field_comment
                )
            sql_string = sql_string + "\n" + sql_row + ","
        
        # 建表语句
        table_sql_string = "-- =================================================================" + "\n" + \
                           "-- Table structure for %s" % table_name + "\n" + \
                           "-- =================================================================" + "\n" + \
                           "DROP TABLE IF EXISTS `%s`;" % table_name + "\n" + \
                           "CREATE TABLE `%s` (" % table_name + \
                           "%s" % sql_string + "\n" + \
                           "    PRIMARY KEY (`%s`) USING BTREE," % primary_key + "\n" + \
                           "    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)," + "\n" + \
                           "    INDEX (`index`)" + "\n" + \
                           ") ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '%s';" % table_name + "\n" + \
                           "SET FOREIGN_KEY_CHECKS = 1;" + "\n" * 3
        final_sql_string = final_sql_string + table_sql_string
        
    return final_sql_string



if __name__ == "__main__":
    # 数据库参数表
    table = get_database_tabel_parameters()
    # 建表语句
    sql = get_sql_string(table)
    # 写入 SQL 建表语句
    write_sql_string(sql)
