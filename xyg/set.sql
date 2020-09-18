SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for TABLE_NAME
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_standard_card`;
CREATE TABLE `set_craft_standard_card` (
    `id`  BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `card_id` VARCHAR(255) NOT NULL     COMMENT '标准工艺卡ID',
    `craft_no`    VARCHAR(255) NOT NULL     COMMENT '编号',
    `craft_name`  VARCHAR(255) NOT NULL     COMMENT '名称',
    `mark_no_class`   VARCHAR(255) NOT NULL     COMMENT '牌号大类',
    `mark_no` VARCHAR(255) NOT NULL     COMMENT '牌号',
    `standard`    VARCHAR(255) NOT NULL     COMMENT '技术标准',
    `quality_key_point`   VARCHAR(255) NOT NULL     COMMENT '质量要点',
    `material_norm`   VARCHAR(255) NOT NULL     COMMENT '成材规格',
    `state`   VARCHAR(255) NOT NULL     COMMENT '状态',
    `craft_path`  VARCHAR(255) NOT NULL     COMMENT '工艺路径',
    `label`   VARCHAR(255) NOT NULL     COMMENT '标签',
    `remark`  VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `date`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '日期',
    `editor`  VARCHAR(255) NULL    DEFAULT NULL COMMENT '编辑人',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'set_craft_standard_card';

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_modify_record`;
CREATE TABLE `set_modify_record`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `craft_card_id`   VARCHAR(255) NOT NULL COMMENT '工艺卡编号',
    `product_craft_card_id`   VARCHAR(255) NOT NULL COMMENT '产品工艺卡ID',
    `modify_content`  VARCHAR(255) NOT NULL COMMENT '修改内容',
    `quality_key_point`   VARCHAR(255) NOT NULL COMMENT '质量要点',
    `modify_date` DATETIME(6)   NOT NULL COMMENT '编制日期',
    `editor` VARCHAR(255) NOT NULL COMMENT '编制人',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_modify_record';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_process_craft`;
CREATE TABLE `set_process_craft`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工艺工序ID',
    `product_craft_card_id`   VARCHAR(255) NOT NULL COMMENT '产品工艺卡ID',
    `process_class`   VARCHAR(255) NOT NULL COMMENT '工序类型',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `process_name`    VARCHAR(255) NOT NULL COMMENT '工序名称',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_process_craft';

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_curve`;
CREATE TABLE `set_craft_curve` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `curve_name`  VARCHAR(255) NOT NULL COMMENT '曲线名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `remark` VARCHAR(255) NULL    DEFAULT NULL COMMENT '备注',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_curve';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_curve_point`;
CREATE TABLE `set_craft_curve_point`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `curve_no`    VARCHAR(255) NOT NULL COMMENT '曲线ID',
    `temperature` DOUBLE(10,5)  NOT NULL COMMENT '温度',
    `time_interval`   DOUBLE(10,5)  NOT NULL COMMENT '时长',
    `rate` DOUBLE(10,5)  NOT NULL COMMENT '速率',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_curve_point';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_config_craft_fast_forging`;
CREATE TABLE `set_config_craft_fast_forging`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL COMMENT '工序',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `start_forge_temperature` DOUBLE(10,5)  NOT NULL COMMENT '开锻温度',
    `end_forge_temperature`   DOUBLE(10,5)  NOT NULL COMMENT '停锻温度',
    `forge_rate`  DOUBLE(10,5)  NOT NULL COMMENT '锻造比',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_config_craft_fast_forging';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_config_craft_fast_forging_fire_order`;
CREATE TABLE `set_config_craft_fast_forging_fire_order`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `fire_order`  VARCHAR(255) NOT NULL COMMENT '火次',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `deformation_process` VARCHAR(255) NOT NULL COMMENT '变形过程',
    `after_forging_size`  DOUBLE(10,5)  NOT NULL COMMENT '锻后尺寸',
    `reheating temperature`   DOUBLE(10,5)  NOT NULL COMMENT '回炉加温温度',
    `reheating_duration`  DOUBLE(10,5)  NOT NULL COMMENT '回炉加温时长',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_config_craft_fast_forging_fire_order';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_diameter_forging`;
CREATE TABLE `set_craft_diameter_forging`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `supplied_material_type`  VARCHAR(255) NOT NULL COMMENT '来料类型',
    `supplied_material_size`  DOUBLE(10,5)  NOT NULL COMMENT '来料尺寸',
    `complete_size`   VARCHAR(255) NOT NULL COMMENT '成材规格',
    `start_forge_temperature` DOUBLE(10,5)  NOT NULL COMMENT '开锻温度',
    `end_forge_temperature`   DOUBLE(10,5)  NOT NULL COMMENT '终锻温度',
    `heating_temperature` DOUBLE(10,5)  NOT NULL COMMENT '加热温度',
    `warm_stay_duration`  DOUBLE(10,5)  NOT NULL COMMENT '保温时间',
    `daoci_file_name` VARCHAR(255) NOT NULL COMMENT '道次文件',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_diameter_forging';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_finishing`;
CREATE TABLE `set_craft_finishing`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL COMMENT '工序',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `grinding_demand` VARCHAR(255) NOT NULL COMMENT '修磨要求',
    `tolerance_demand`    VARCHAR(255) NOT NULL COMMENT '公差要求',
    `is_polishing`    VARCHAR(255) NOT NULL COMMENT '是否车光',
    `roughness_demand`    VARCHAR(255) NOT NULL COMMENT '粗糙度要求',
    `curvature` DOUBLE(10,5)  NOT NULL COMMENT '弯曲度',
    `cut_slope`   DOUBLE(10,5)  NOT NULL COMMENT '切斜度',
    `polishing_method`    VARCHAR(255) NOT NULL COMMENT '定心/无心车光',
    `other` VARCHAR(255) NULL    DEFAULT NULL COMMENT '其他',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_finishing';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_tempering`;
CREATE TABLE `set_craft_tempering`  (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `tempering_craft_card_id` VARCHAR(255) NOT NULL COMMENT '调质工艺卡ID',
    `process` VARCHAR(255) NOT NULL COMMENT '工序',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)  NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)  NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_tempering';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for regulation_curve_point
-- ----------------------------
DROP TABLE IF EXISTS `set_craft_package_store`;
CREATE TABLE `set_craft_package_store` (
    `id` BIGINT      NOT NULL    AUTO_INCREMENT COMMENT '自增ID',
    `attribute_name`  VARCHAR(255) NOT NULL COMMENT '属性名称',
    `process_craft_id`    VARCHAR(255) NOT NULL COMMENT '工序工艺ID',
    `process` VARCHAR(255) NOT NULL COMMENT '工序',
    `device` VARCHAR(255) NOT NULL COMMENT '设备',
    `shape` VARCHAR(255) NOT NULL COMMENT '外形',
    `size_tolerance`  DOUBLE(10,5)  NOT NULL COMMENT '尺寸公差',
    `curvature` DOUBLE(10,5)  NOT NULL COMMENT '弯曲度',
    `cut_slope`   DOUBLE(10,5)  NOT NULL COMMENT '切斜度',
    `package_demand`  VARCHAR(255) NOT NULL COMMENT '包装要求',
    `mark_demand` VARCHAR(255) NOT NULL COMMENT '标识要求',
    `other`VARCHAR(255) NULL    DEFAULT NULL COMMENT '其他',
    `created_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '创建者',
    `updated_user`    VARCHAR(255) NULL    DEFAULT NULL COMMENT '更新者',
    `created_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '创建日期',
    `updated_datetime`    DATETIME(6)   NULL    DEFAULT NULL COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`field1`) REFERENCES `foreign_table`(`foreign_key`)
    -- INDEX (``)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic COMMENT = 'set_craft_package_store';

SET FOREIGN_KEY_CHECKS = 1;

