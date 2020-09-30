SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for basic_curve_menu
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_menu`;
CREATE TABLE `basic_curve_menu` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '基础曲线树形菜单ID',
    `basic_curve_id` INT unsigned NULL DEFAULT NULL COMMENT '基础曲线表ID',
    `parent_id` INT unsigned NULL DEFAULT NULL COMMENT '父ID',
    `node_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '节点名称',
    `upper_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '上限',
    `lower_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '下限',
    `category_id` INT unsigned NULL DEFAULT NULL COMMENT '基础分类ID',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '基础曲线-树形菜单';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_craft_diameter_passfile
-- =================================================================
DROP TABLE IF EXISTS `info_craft_diameter_passfile`;
CREATE TABLE `info_craft_diameter_passfile` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '径锻道次文件配置ID',
    `process_craft_id` INT unsigned NULL DEFAULT NULL COMMENT '基础表格-径锻ID',
    `supplied_material_type` VARCHAR(255) NOT NULL  COMMENT '来料类型',
    `supplied_material_size` DOUBLE(10,5) NOT NULL  COMMENT '来料尺寸',
    `material_norm_min` DOUBLE(10,5) NOT NULL  COMMENT '成材规格_下限',
    `material_norm_max` DOUBLE(10,5) NOT NULL  COMMENT '成材规格_上限',
    `start_forge_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度_下限',
    `start_forge_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度_上限',
    `end_forge_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度_下限',
    `end_forge_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度_上限',
    `heating_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '加热温度_下限',
    `heating_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '加热温度_上限',
    `warm_stay_duration_min` DOUBLE(10,5) NOT NULL  COMMENT '保温时间_下限',
    `warm_stay_duration_max` DOUBLE(10,5) NOT NULL  COMMENT '保温时间_上限',
    `pass_file_name` VARCHAR(255) NOT NULL  COMMENT '道次文件',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-径锻道次文件配置';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_craft_diameter_passfile
-- =================================================================
DROP TABLE IF EXISTS `card_craft_diameter_passfile`;
CREATE TABLE `card_craft_diameter_passfile` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '径锻道次文件配置ID',
    `process_craft_id` INT unsigned NULL DEFAULT NULL COMMENT '基础表格-径锻ID',
    `supplied_material_type` VARCHAR(255) NOT NULL  COMMENT '来料类型',
    `supplied_material_size` DOUBLE(10,5) NOT NULL  COMMENT '来料尺寸',
    `material_norm_min` DOUBLE(10,5) NOT NULL  COMMENT '成材规格_下限',
    `material_norm_max` DOUBLE(10,5) NOT NULL  COMMENT '成材规格_上限',
    `start_forge_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度_下限',
    `start_forge_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度_上限',
    `end_forge_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度_下限',
    `end_forge_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度_上限',
    `heating_temperature_min` DOUBLE(10,5) NOT NULL  COMMENT '加热温度_下限',
    `heating_temperature_max` DOUBLE(10,5) NOT NULL  COMMENT '加热温度_上限',
    `warm_stay_duration_min` DOUBLE(10,5) NOT NULL  COMMENT '保温时间_下限',
    `warm_stay_duration_max` DOUBLE(10,5) NOT NULL  COMMENT '保温时间_上限',
    `pass_file_name` VARCHAR(255) NOT NULL  COMMENT '道次文件',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-径锻道次文件配置';
SET FOREIGN_KEY_CHECKS = 1;


