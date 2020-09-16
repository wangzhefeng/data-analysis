
import pandas as pd

data = pd.read_excel("xyg_data_directory.xlsx")

for sheet in data:
    table_name = None
    primary_key = None
    table = None

    sql = """
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;

        -- ----------------------------
        -- Table structure for %s
        -- ----------------------------
        DROP TABLE IF EXISTS `%s`;
        CREATE TABLE `%s` (
            `%s` %s %s COMMENT `%s`,
            PRIMARY KEY (`%s`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

        SET FOREIGN_KEY_CHECKS = 1;
    """ % (
        # comments 
        "production_plan_detail",
        # TABLE_NAME
        "production_plan_detail",
        # TABLE_NAME
        "production_plan_detail",
        # FIELD
        "SEQ_NO",
        # TYPE
        "bigint",
        # IS NULL
        "NOT NULL",
        # COMMENT
        "记录顺序号",
        # PRIMARY_KEY_NAME
        "SEQ_NO"
    )

    with open("xyg_sql.sql") as f:
        sql.write(f)
