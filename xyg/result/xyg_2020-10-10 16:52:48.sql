SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for basic_curve_popup
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_popup`;
CREATE TABLE `basic_curve_popup` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '基础曲线树形菜单ID',
    `parent_id` INT NULL DEFAULT NULL COMMENT '父ID',
    `node_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '节点名称',
    `upper_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '上限',
    `lower_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '下限',
    `category_id` INT NULL DEFAULT NULL COMMENT '基础分类ID',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '基础曲线-弹窗树形菜单';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_curve_menu
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_curve_menu`;
CREATE TABLE `card_tempering_curve_menu` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '工艺曲线ID',
    `card_tempering_id` INT NULL DEFAULT NULL COMMENT '调质卡ID',
    `parent_id` INT NULL DEFAULT NULL COMMENT '父ID',
    `node_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '节点名称',
    `category_id` INT NULL DEFAULT NULL COMMENT '基础分类ID(节点类型)',
    `basic_curve_id` INT NULL DEFAULT NULL COMMENT '基础曲线ID',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-调质工艺曲线-树形菜单';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for basic_curve_card
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_card`;
CREATE TABLE `basic_curve_card` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '基础曲线表ID',
    `config_popup_id` INT NULL DEFAULT NULL COMMENT '基础曲线弹窗树形菜单ID',
    `config_menu_id` INT NULL DEFAULT NULL COMMENT '基础曲线树形分类菜单ID',
    `craft_curve_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '曲线名称',
    `indexing` VARCHAR(255) NULL DEFAULT NULL COMMENT '索引',
    `category` VARCHAR(255) NULL DEFAULT NULL COMMENT '类型',
    `remark` TEXT NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-基础曲线表';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for basic_curve_point_card
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_point_card`;
CREATE TABLE `basic_curve_point_card` (
    `id` INT  NOT NULL AUTO_INCREMENT COMMENT '基础曲线点ID',
    `basic_curve_id` INT  NULL DEFAULT NULL COMMENT '基础曲线表ID',
    `step_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '阶段名',
    `temperature_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '温度上限',
    `temperature_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '温度下限',
    `time_period_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '时长上限',
    `time_period_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '时长下限',
    `speed_rate_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '速率上限',
    `speed_rate_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '速率下限',
    `order_no` VARCHAR(255) NULL DEFAULT NULL COMMENT '顺序号',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT  NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-基础曲线点';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for basic_form_card
-- =================================================================
DROP TABLE IF EXISTS `basic_form_card`;
CREATE TABLE `basic_form_card` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '基础表格ID',
    `craft_form_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '表格名称',
    `indexing` VARCHAR(255) NULL DEFAULT NULL COMMENT '索引',
    `grinding_demand` VARCHAR(255) NULL DEFAULT NULL COMMENT '修磨要求',
    `tolerance_demand` VARCHAR(255) NULL DEFAULT NULL COMMENT '公差要求',
    `is_polishing` TINYINT NULL DEFAULT NULL COMMENT '是否车光',
    `roughness_demand` VARCHAR(255) NULL DEFAULT NULL COMMENT '粗糙度要求',
    `curvature` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '弯曲度',
    `cut_slope` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '切斜度',
    `polishing_method` VARCHAR(255) NULL DEFAULT NULL COMMENT '定心/无心车光',
    `other` TEXT  NULL DEFAULT NULL COMMENT '其他',
    `diameter_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '直径/厚/高/壁厚下限',
    `diameter_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '直径/厚/高/壁厚上限',
    `width_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '宽度下限',
    `width_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '宽度上限',
    `outer_diameter_min` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '外径下限',
    `outer_diameter_max` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '外径上限',
    `is_shot_blasting` TINYINT NULL DEFAULT NULL COMMENT '是否抛丸',
    `is_peeling` TINYINT NULL DEFAULT NULL COMMENT '是否扒皮',
    `is_straighten` TINYINT NULL DEFAULT NULL COMMENT '是否矫直',
    `is_mechanism` TINYINT NULL DEFAULT NULL COMMENT '是否机制',
    `surface_size` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '表面状态',
    `blunt_edge_size` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '钝边尺寸',
    `steel_type_identify_method` VARCHAR(255) NULL DEFAULT NULL COMMENT '钢种鉴别方式',
    `remanence` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '剩磁量',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT  NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-基础表格-精整';
SET FOREIGN_KEY_CHECKS = 1;


