
import pandas as pd



HOST = "47.98.51.189:3306"
DATABASE = "xyg_qm"






# for sheet in data:
#     table_name = None
#     primary_key = None
#     table = None

#     sql = """
#         SET NAMES utf8mb4;
#         SET FOREIGN_KEY_CHECKS = 0;

#         -- ----------------------------
#         -- Table structure for %s
#         -- ----------------------------
#         DROP TABLE IF EXISTS `%s`;
#         CREATE TABLE `%s` (
#             `%s` %s %s COMMENT `%s`,
#             PRIMARY KEY (`%s`) USING BTREE
#         ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

#         SET FOREIGN_KEY_CHECKS = 1;
#     """ % (
#         # comments 
#         "production_plan_detail",
#         # TABLE_NAME
#         "production_plan_detail",
#         # TABLE_NAME
#         "production_plan_detail",
#         # FIELD
#         "SEQ_NO",
#         # TYPE
#         "bigint",
#         # IS NULL
#         "NOT NULL",
#         # COMMENT
#         "记录顺序号",
#         # PRIMARY_KEY_NAME
#         "SEQ_NO"
#     )

#     with open("xyg_sql.sql") as f:
#         sql.write(f)



if __name__ == "__main__":
    table_data = pd.read_excel(
        "/mnt/e/dev/data-analysis/xyg/xyg.xlsx",
        sheet_name = "录入_标准工艺卡",
        header = 0,
        nrows = 4
    )
    print(table_data)
    # field_data = pd.read_excel(
    #     "/mnt/e/dev/data-analysis/xyg/xyg.xlsx",
    #     skiprows = 5, 
    #     sheet_name = "录入_标准工艺卡",
    #     header = 1
    # )
    # print(field_data)





input_craft_standard_card
input_modify_record
input_process_craft
input_craft_curve
input_craft_curve_point
input_config_craft_fast_forging
input_config_craft_fast_forging_fire_order
input_craft_diameter_forging
input_craft_finishing
input_craft_tempering
input_craft_package_store
regulation_craft_regulation
regulation_chapter
regulation_section
regulation_steel_no
regulation_table
regulation_table_row
regulation_curve
regulation_curve_point
set_craft_standard_card
input_modify_record
input_produce_ingredients_card
input_process_craft
input_craft_curve
input_craft_curve_point
input_config_craft_fast_forging
input_config_craft_fast_forging_fire_order
input_craft_diameter_forging
input_craft_finishing




录入_标准工艺卡
录入_修改记录
录入_工序工艺
录入_工艺曲线
录入_工艺曲线点
录入_快锻工艺配置
录入_快锻火次配置
录入_径锻工艺配置
录入_精整工艺
录入_调质工艺
录入_包装入库工艺
设置_产品工艺卡
设置_修改记录
设置_生产配料卡
设置_工序工艺
设置_工艺曲线
设置_工艺曲线点
设置_快锻工艺配置
设置_快锻火次配置
设置_径锻工艺配置
设置_精整工艺
设置_调质工艺
设置_包装入库工艺
规程_工艺规程
规程_章
规程_节
规程_钢号
规程_表格
规程_表格行
规程_曲线
规程_曲线点






