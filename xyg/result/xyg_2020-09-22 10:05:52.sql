SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for basic_curve
-- =================================================================
DROP TABLE IF EXISTS `basic_curve`;
CREATE TABLE `basic_curve` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '基础曲线表ID',
    `craft_curve_name` VARCHAR(255) NOT NULL  COMMENT '曲线名称',
    `index` VARCHAR(255) NOT NULL  COMMENT '索引',
    `label` VARCHAR(255) NOT NULL  COMMENT '标签',
    `regulation` VARCHAR(255) NOT NULL  COMMENT '规格',
    `hot_cold_state` VARCHAR(255) NOT NULL  COMMENT '冷热态',
    `ingot_type` VARCHAR(255) NOT NULL  COMMENT '锭型',
    `remark` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'basic_curve';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for basic_finishing
-- =================================================================
DROP TABLE IF EXISTS `basic_finishing`;
CREATE TABLE `basic_finishing` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '基础表格ID',
    `grinding_demand` VARCHAR(255) NOT NULL  COMMENT '修磨要求',
    `tolerance_demand` VARCHAR(255) NOT NULL  COMMENT '公差要求',
    `is_polishing` VARCHAR(255) NOT NULL  COMMENT '是否车光',
    `roughness_demand` VARCHAR(255) NOT NULL  COMMENT '粗糙度要求',
    `curvature` DOUBLE(10,5) NOT NULL  COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NOT NULL  COMMENT '切斜度',
    `polishing_method` VARCHAR(255) NOT NULL  COMMENT '定心/无心车光',
    `other` VARCHAR(255) NULL DEFAULT NULL COMMENT '其他',
    `diameter_min` DOUBLE(10,5) NOT NULL  COMMENT '直径/厚/高/壁厚下限',
    `diameter_max` DOUBLE(10,5) NOT NULL  COMMENT '直径/厚/高/壁厚上限',
    `width_min` DOUBLE(10,5) NOT NULL  COMMENT '宽度下限',
    `width_max` DOUBLE(10,5) NOT NULL  COMMENT '宽度上限',
    `min_outer_diameter` DOUBLE(10,5) NOT NULL  COMMENT '外径下限',
    `max_outer_diameter` DOUBLE(10,5) NOT NULL  COMMENT '外径上限',
    `is_shot_blasting` INT  NOT NULL  COMMENT '是否抛丸',
    `is_peeling` INT  NOT NULL  COMMENT '是否扒皮',
    `is_straighten` INT  NOT NULL  COMMENT '是否矫直',
    `is_mechanism` INT  NOT NULL  COMMENT '是否机制',
    `surface_size` DOUBLE(10,5) NOT NULL  COMMENT '表面状态',
    `blunt_edge_size` DOUBLE(10,5) NOT NULL  COMMENT '钝边尺寸',
    `steel_type_identify_method` VARCHAR(255) NOT NULL  COMMENT '钢种鉴别方式',
    `remanence` DOUBLE(10,5) NOT NULL  COMMENT '剩磁量',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'basic_finishing';
SET FOREIGN_KEY_CHECKS = 1;


