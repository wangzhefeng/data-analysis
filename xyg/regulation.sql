SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_craft_regulation`;
CREATE TABLE `regulation_craft_regulation` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `regulation_name` VARCHAR(255) NOT NULL COMMENT '规程名称',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_craft_regulation';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_chapter`;
CREATE TABLE `regulation_chapter` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `name` VARCHAR(255) NOT NULL COMMENT '名称',
    `craft_regulation_id` VARCHAR(255) NOT NULL COMMENT '工艺规程ID',
    `content` VARCHAR(255) NOT NULL COMMENT '内容',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_chapter';

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_section`;
CREATE TABLE `regulation_section` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `chapter_id`  VARCHAR(255) NOT NULL COMMENT '章ID',
    `name` VARCHAR(255) NOT NULL COMMENT '名称',
    `content` VARCHAR(255) NOT NULL COMMENT '内容',
    `table_info`  VARCHAR(255) NOT NULL COMMENT '表格信息',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_section';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_table`;
CREATE TABLE `regulation_table` (
    `id`  BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `name`    VARCHAR(255) NOT NULL COMMENT '名称',
    `section_id`  VARCHAR(255) NOT NULL COMMENT '节ID',
    `remark`  VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_table';

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_table_row`;
CREATE TABLE `regulation_table_row` (
    `id`  BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `steel_group` VARCHAR(255) NOT NULL COMMENT '钢组名',
    `curve`   VARCHAR(255) NOT NULL COMMENT '曲线',
    `table_id`    VARCHAR(255) NOT NULL COMMENT '表格ID',
    `remark`  VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_table_row';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_curve`;
CREATE TABLE `regulation_curve` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `curve` VARCHAR(255) NOT NULL COMMENT '曲线',
    `table_id`    VARCHAR(255) NOT NULL COMMENT '表格ID',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_curve';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_steel_no`;
CREATE TABLE `regulation_steel_no` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `steel_no`    VARCHAR(255) NOT NULL COMMENT '钢号',
    `steel_group_id`  VARCHAR(255) NOT NULL COMMENT '表格行ID(钢组ID)',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_steel_no';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for input_product_craft_card
-- ----------------------------
DROP TABLE IF EXISTS `regulation_curve_point`;
CREATE TABLE `regulation_curve_point` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `temperature` DOUBLE(10,5)  NOT NULL COMMENT '温度',
    `time_period` DOUBLE(10,5)  NOT NULL COMMENT '时长',
    `speed_rate`  DOUBLE(10,5)  NOT NULL COMMENT '速率',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_curve_point';

SET FOREIGN_KEY_CHECKS = 1;

