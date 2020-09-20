SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- =================================================================
-- Table structure for input_craft_standard_card
-- =================================================================
DROP TABLE IF EXISTS `input_craft_standard_card`;
CREATE TABLE `input_craft_standard_card` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '标准工艺卡ID',
    `product_ingredients_card_id` BIGINT  NOT NULL  COMMENT '生产配料卡ID',
    `mark_no_class` VARCHAR(255) NOT NULL  COMMENT '牌号大类',
    `mark_no` VARCHAR(255) NOT NULL  COMMENT '牌号',
    `technical_standard` VARCHAR(255) NOT NULL  COMMENT '技术标准',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `material_norm` VARCHAR(255) NOT NULL  COMMENT '成材规格',
    `state` VARCHAR(255) NOT NULL  COMMENT '状态',
    `craft_path` VARCHAR(255) NOT NULL  COMMENT '工艺路径',
    `label` VARCHAR(255) NOT NULL  COMMENT '标签',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_standard_card';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_modify_record
-- =================================================================
DROP TABLE IF EXISTS `input_modify_record`;
CREATE TABLE `input_modify_record` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '修改记录ID',
    `craft_no` VARCHAR(255) NOT NULL  COMMENT '工艺卡编号',
    `standard_craft_card_id` BIGINT  NOT NULL  COMMENT '标准工艺卡ID',
    `modify_content` VARCHAR(255) NOT NULL  COMMENT '修改内容',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_modify_record';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_process_craft
-- =================================================================
DROP TABLE IF EXISTS `input_process_craft`;
CREATE TABLE `input_process_craft` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺工序ID',
    `standard_craft_card_id` BIGINT  NOT NULL  COMMENT '标准工艺卡ID',
    `process_class` VARCHAR(255) NOT NULL  COMMENT '工序类型',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `process_name` VARCHAR(255) NOT NULL  COMMENT '工序名称',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_process_craft';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_curve
-- =================================================================
DROP TABLE IF EXISTS `input_craft_curve`;
CREATE TABLE `input_craft_curve` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺曲线ID',
    `craft_curve_name` VARCHAR(255) NOT NULL  COMMENT '曲线名称',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_curve';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_curve_point
-- =================================================================
DROP TABLE IF EXISTS `input_craft_curve_point`;
CREATE TABLE `input_craft_curve_point` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺曲线点ID',
    `craft_curve_id` BIGINT  NOT NULL  COMMENT '工艺曲线ID',
    `temperature` DOUBLE(10,5) NOT NULL  COMMENT '温度',
    `time_interval` DOUBLE(10,5) NOT NULL  COMMENT '时长',
    `speed_rate` DOUBLE(10,5) NOT NULL  COMMENT '速率',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_curve_point';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_config_craft_fast_forging
-- =================================================================
DROP TABLE IF EXISTS `input_config_craft_fast_forging`;
CREATE TABLE `input_config_craft_fast_forging` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '快锻工艺配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `start_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度',
    `end_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '停锻温度',
    `forge_rate` DOUBLE(10,5) NOT NULL  COMMENT '锻造比',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_config_craft_fast_forging';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_config_craft_fast_forging_fire_order
-- =================================================================
DROP TABLE IF EXISTS `input_config_craft_fast_forging_fire_order`;
CREATE TABLE `input_config_craft_fast_forging_fire_order` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '快锻火次配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `fire_order` VARCHAR(255) NOT NULL  COMMENT '火次',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `deformation_process` VARCHAR(255) NOT NULL  COMMENT '变形过程',
    `after_forging_size` DOUBLE(10,5) NOT NULL  COMMENT '锻后尺寸',
    `reheating temperature` DOUBLE(10,5) NOT NULL  COMMENT '回炉加温温度',
    `reheating_duration` DOUBLE(10,5) NOT NULL  COMMENT '回炉加温时长',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_config_craft_fast_forging_fire_order';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_diameter_forging
-- =================================================================
DROP TABLE IF EXISTS `input_craft_diameter_forging`;
CREATE TABLE `input_craft_diameter_forging` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '径锻工艺配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `supplied_material_type` VARCHAR(255) NOT NULL  COMMENT '来料类型',
    `supplied_material_size` DOUBLE(10,5) NOT NULL  COMMENT '来料尺寸',
    `material_norm` VARCHAR(255) NOT NULL  COMMENT '成材规格',
    `start_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度',
    `end_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度',
    `heating_temperature` DOUBLE(10,5) NOT NULL  COMMENT '加热温度',
    `warm_stay_duration` DOUBLE(10,5) NOT NULL  COMMENT '保温时间',
    `daoci_file_name` VARCHAR(255) NOT NULL  COMMENT '道次文件',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_diameter_forging';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_finishing
-- =================================================================
DROP TABLE IF EXISTS `input_craft_finishing`;
CREATE TABLE `input_craft_finishing` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '精整工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `grinding_demand` VARCHAR(255) NOT NULL  COMMENT '修磨要求',
    `tolerance_demand` VARCHAR(255) NOT NULL  COMMENT '公差要求',
    `is_polishing` VARCHAR(255) NOT NULL  COMMENT '是否车光',
    `roughness_demand` VARCHAR(255) NOT NULL  COMMENT '粗糙度要求',
    `curvature` DOUBLE(10,5) NOT NULL  COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NOT NULL  COMMENT '切斜度',
    `polishing_method` VARCHAR(255) NOT NULL  COMMENT '定心/无心车光',
    `other` VARCHAR(255) NULL DEFAULT NULL COMMENT '其他',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_finishing';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_tempering
-- =================================================================
DROP TABLE IF EXISTS `input_craft_tempering`;
CREATE TABLE `input_craft_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `tempering_craft_card_id` BIGINT  NOT NULL  COMMENT '调质工艺卡ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_tempering';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for input_craft_package_store
-- =================================================================
DROP TABLE IF EXISTS `input_craft_package_store`;
CREATE TABLE `input_craft_package_store` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '包装入库工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `shape` VARCHAR(255) NOT NULL  COMMENT '外形',
    `size_tolerance` DOUBLE(10,5) NOT NULL  COMMENT '尺寸公差',
    `curvature` DOUBLE(10,5) NOT NULL  COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NOT NULL  COMMENT '切斜度',
    `package_demand` VARCHAR(255) NOT NULL  COMMENT '包装要求',
    `mark_demand` VARCHAR(255) NOT NULL  COMMENT '标识要求',
    `other` VARCHAR(255) NULL DEFAULT NULL COMMENT '其他',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'input_craft_package_store';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_produce_ingredients_card
-- =================================================================
DROP TABLE IF EXISTS `set_produce_ingredients_card`;
CREATE TABLE `set_produce_ingredients_card` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '生产配料卡ID(自增ID)',
    `product_craft_card_id` BIGINT  NOT NULL  COMMENT '产品工艺卡ID',
    `mark_no` VARCHAR(255) NOT NULL  COMMENT '牌号',
    `technical_standard` VARCHAR(255) NOT NULL  COMMENT '技术标准',
    `norm` VARCHAR(255) NOT NULL  COMMENT '规格',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_produce_ingredients_card';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_standard_card
-- =================================================================
DROP TABLE IF EXISTS `set_craft_standard_card`;
CREATE TABLE `set_craft_standard_card` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '产品工艺卡ID(自增ID)',
    `standard_craft_card_id` BIGINT  NOT NULL  COMMENT '标准工艺卡ID',
    `product_ingredients_card_id` BIGINT  NOT NULL  COMMENT '生产配料卡ID',
    `mark_no_class` VARCHAR(255) NOT NULL  COMMENT '牌号大类',
    `mark_no` VARCHAR(255) NOT NULL  COMMENT '牌号',
    `technical_standard` VARCHAR(255) NOT NULL  COMMENT '技术标准',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `material_norm` VARCHAR(255) NOT NULL  COMMENT '成材规格',
    `state` VARCHAR(255) NOT NULL  COMMENT '状态',
    `craft_path` VARCHAR(255) NOT NULL  COMMENT '工艺路径',
    `label` VARCHAR(255) NOT NULL  COMMENT '标签',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_standard_card';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_modify_record
-- =================================================================
DROP TABLE IF EXISTS `set_modify_record`;
CREATE TABLE `set_modify_record` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺卡编号',
    `standard_craft_card_id` BIGINT  NOT NULL  COMMENT '标准工艺卡ID',
    `modify_content` VARCHAR(255) NOT NULL  COMMENT '修改内容',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_modify_record';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_process_craft
-- =================================================================
DROP TABLE IF EXISTS `set_process_craft`;
CREATE TABLE `set_process_craft` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺工序ID',
    `product_craft_card_id` BIGINT  NOT NULL  COMMENT '产品工艺卡ID',
    `process_class` VARCHAR(255) NOT NULL  COMMENT '工序类型',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `process_name` VARCHAR(255) NOT NULL  COMMENT '工序名称',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_process_craft';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_curve
-- =================================================================
DROP TABLE IF EXISTS `set_craft_curve`;
CREATE TABLE `set_craft_curve` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺曲线ID',
    `craft_curve_name` VARCHAR(255) NOT NULL  COMMENT '曲线名称',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_curve';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_curve_point
-- =================================================================
DROP TABLE IF EXISTS `set_craft_curve_point`;
CREATE TABLE `set_craft_curve_point` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺曲线点ID',
    `craft_curve_id` BIGINT  NOT NULL  COMMENT '工艺曲线ID',
    `temperature` DOUBLE(10,5) NOT NULL  COMMENT '温度',
    `time_interval` DOUBLE(10,5) NOT NULL  COMMENT '时长',
    `speed_rate` DOUBLE(10,5) NOT NULL  COMMENT '速率',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_curve_point';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_config_craft_fast_forging
-- =================================================================
DROP TABLE IF EXISTS `set_config_craft_fast_forging`;
CREATE TABLE `set_config_craft_fast_forging` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '快锻工艺配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `start_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度',
    `end_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '停锻温度',
    `forge_rate` DOUBLE(10,5) NOT NULL  COMMENT '锻造比',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_config_craft_fast_forging';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_config_craft_fast_forging_fire_order
-- =================================================================
DROP TABLE IF EXISTS `set_config_craft_fast_forging_fire_order`;
CREATE TABLE `set_config_craft_fast_forging_fire_order` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '快锻火次配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `fire_order` VARCHAR(255) NOT NULL  COMMENT '火次',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `deformation_process` VARCHAR(255) NOT NULL  COMMENT '变形过程',
    `after_forging_size` DOUBLE(10,5) NOT NULL  COMMENT '锻后尺寸',
    `reheating temperature` DOUBLE(10,5) NOT NULL  COMMENT '回炉加温温度',
    `reheating_duration` DOUBLE(10,5) NOT NULL  COMMENT '回炉加温时长',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_config_craft_fast_forging_fire_order';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_diameter_forging
-- =================================================================
DROP TABLE IF EXISTS `set_craft_diameter_forging`;
CREATE TABLE `set_craft_diameter_forging` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '径锻工艺配置ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `supplied_material_type` VARCHAR(255) NOT NULL  COMMENT '来料类型',
    `supplied_material_size` DOUBLE(10,5) NOT NULL  COMMENT '来料尺寸',
    `material_norm` VARCHAR(255) NOT NULL  COMMENT '成材规格',
    `start_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '开锻温度',
    `end_forge_temperature` DOUBLE(10,5) NOT NULL  COMMENT '终锻温度',
    `heating_temperature` DOUBLE(10,5) NOT NULL  COMMENT '加热温度',
    `warm_stay_duration` DOUBLE(10,5) NOT NULL  COMMENT '保温时间',
    `daoci_file_name` VARCHAR(255) NOT NULL  COMMENT '道次文件',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_diameter_forging';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_finishing
-- =================================================================
DROP TABLE IF EXISTS `set_craft_finishing`;
CREATE TABLE `set_craft_finishing` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '精整工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `grinding_demand` VARCHAR(255) NOT NULL  COMMENT '修磨要求',
    `tolerance_demand` VARCHAR(255) NOT NULL  COMMENT '公差要求',
    `is_polishing` VARCHAR(255) NOT NULL  COMMENT '是否车光',
    `roughness_demand` VARCHAR(255) NOT NULL  COMMENT '粗糙度要求',
    `curvature` DOUBLE(10,5) NOT NULL  COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NOT NULL  COMMENT '切斜度',
    `polishing_method` VARCHAR(255) NOT NULL  COMMENT '定心/无心车光',
    `other` VARCHAR(255) NULL DEFAULT NULL COMMENT '其他',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_finishing';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_tempering
-- =================================================================
DROP TABLE IF EXISTS `set_craft_tempering`;
CREATE TABLE `set_craft_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `tempering_craft_card_id` VARCHAR(255) NOT NULL  COMMENT '调质工艺卡ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_tempering';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for set_craft_package_store
-- =================================================================
DROP TABLE IF EXISTS `set_craft_package_store`;
CREATE TABLE `set_craft_package_store` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '包装入库工艺ID',
    `process_craft_id` BIGINT  NOT NULL  COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL  COMMENT '工序',
    `device` VARCHAR(255) NOT NULL  COMMENT '设备',
    `shape` VARCHAR(255) NOT NULL  COMMENT '外形',
    `size_tolerance` DOUBLE(10,5) NOT NULL  COMMENT '尺寸公差',
    `curvature` DOUBLE(10,5) NOT NULL  COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NOT NULL  COMMENT '切斜度',
    `package_demand` VARCHAR(255) NOT NULL  COMMENT '包装要求',
    `mark_demand` VARCHAR(255) NOT NULL  COMMENT '标识要求',
    `other` VARCHAR(255) NULL DEFAULT NULL COMMENT '其他',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_package_store';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_craft_regulation
-- =================================================================
DROP TABLE IF EXISTS `regulation_craft_regulation`;
CREATE TABLE `regulation_craft_regulation` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺规程ID',
    `regulation_name` VARCHAR(255) NOT NULL  COMMENT '规程名称',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_craft_regulation';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_chapter
-- =================================================================
DROP TABLE IF EXISTS `regulation_chapter`;
CREATE TABLE `regulation_chapter` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '章ID',
    `name` VARCHAR(255) NOT NULL  COMMENT '名称',
    `craft_regulation_id` BIGINT  NOT NULL  COMMENT '工艺规程ID',
    `content` VARCHAR(255) NOT NULL  COMMENT '内容',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_chapter';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_section
-- =================================================================
DROP TABLE IF EXISTS `regulation_section`;
CREATE TABLE `regulation_section` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '节ID',
    `chapter_id` BIGINT  NOT NULL  COMMENT '章ID',
    `name` VARCHAR(255) NOT NULL  COMMENT '名称',
    `content` VARCHAR(255) NOT NULL  COMMENT '内容',
    `table_info` VARCHAR(255) NOT NULL  COMMENT '表格信息',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_section';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_steel_no
-- =================================================================
DROP TABLE IF EXISTS `regulation_steel_no`;
CREATE TABLE `regulation_steel_no` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '钢号ID',
    `steel_no` VARCHAR(255) NOT NULL  COMMENT '钢号',
    `steel_group_id` BIGINT  NOT NULL  COMMENT '表格行ID(钢组ID)',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_steel_no';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_table
-- =================================================================
DROP TABLE IF EXISTS `regulation_table`;
CREATE TABLE `regulation_table` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '表格ID',
    `name` VARCHAR(255) NOT NULL  COMMENT '名称',
    `section_id` BIGINT  NOT NULL  COMMENT '节ID',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_table';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_table_row
-- =================================================================
DROP TABLE IF EXISTS `regulation_table_row`;
CREATE TABLE `regulation_table_row` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '表格行ID',
    `steel_group` VARCHAR(255) NOT NULL  COMMENT '钢组名',
    `curve` VARCHAR(255) NOT NULL  COMMENT '曲线',
    `table_id` BIGINT  NOT NULL  COMMENT '表格ID',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_table_row';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_curve
-- =================================================================
DROP TABLE IF EXISTS `regulation_curve`;
CREATE TABLE `regulation_curve` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '曲线ID',
    `curve` VARCHAR(255) NOT NULL  COMMENT '曲线',
    `table_id` BIGINT  NOT NULL  COMMENT '表格ID',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_curve';
SET FOREIGN_KEY_CHECKS = 1;



-- =================================================================
-- Table structure for regulation_curve_point
-- =================================================================
DROP TABLE IF EXISTS `regulation_curve_point`;
CREATE TABLE `regulation_curve_point` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '曲线点ID',
    `curve_id` BIGINT  NOT NULL  COMMENT '曲线ID',
    `temperature` DOUBLE(10,5) NOT NULL  COMMENT '温度',
    `time_period` DOUBLE(10,5) NOT NULL  COMMENT '时长',
    `speed_rate` DOUBLE(10,5) NOT NULL  COMMENT '速率',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'regulation_curve_point';
SET FOREIGN_KEY_CHECKS = 1;


