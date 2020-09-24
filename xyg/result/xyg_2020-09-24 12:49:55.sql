SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for info_craft_tempering
-- =================================================================
DROP TABLE IF EXISTS `info_craft_tempering`;
CREATE TABLE `info_craft_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质工艺ID',
    `craft_no` VARCHAR(255) NOT NULL  COMMENT '工艺编号',
    `craft_name` VARCHAR(255) NOT NULL  COMMENT '工艺名称',
    `mark_no_class` BIGINT  NOT NULL  COMMENT '牌号大类',
    `mark_no` BIGINT  NOT NULL  COMMENT '牌号',
    `technical_standard` VARCHAR(255) NOT NULL  COMMENT '技术标准',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `material_norm` TEXT  NOT NULL  COMMENT '成材规格',
    `delivery_state` VARCHAR(255) NOT NULL  COMMENT '交货状态',
    `craft_path` VARCHAR(255) NOT NULL  COMMENT '工艺流程',
    `materials_accept` VARCHAR(255) NOT NULL  COMMENT '来料验收',
    `has_performance` INT  NOT NULL  COMMENT '是否有力学性能要求表',
    `has_surface_hardness` INT  NOT NULL  COMMENT '是否有表面硬度表',
    `has_materials_accept` INT  NOT NULL  COMMENT '是否有来料验收表',
    `has_craft_curve` INT  NOT NULL  COMMENT '是否有工艺曲线表',
    `has_keypoint` INT  NOT NULL  COMMENT '是否有工艺要点表',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-标准调质工艺卡';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_craft_tempering
-- =================================================================
DROP TABLE IF EXISTS `card_craft_tempering`;
CREATE TABLE `card_craft_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质工艺ID',
    `craft_no` VARCHAR(255) NOT NULL  COMMENT '工艺编号',
    `craft_name` VARCHAR(255) NOT NULL  COMMENT '工艺名称',
    `mark_no_class` BIGINT  NOT NULL  COMMENT '牌号大类',
    `mark_no` BIGINT  NOT NULL  COMMENT '牌号',
    `technical_standard` VARCHAR(255) NOT NULL  COMMENT '技术标准',
    `quality_key_point` VARCHAR(255) NOT NULL  COMMENT '质量要点',
    `material_norm` TEXT  NOT NULL  COMMENT '成材规格',
    `delivery_state` VARCHAR(255) NOT NULL  COMMENT '交货状态',
    `craft_path` VARCHAR(255) NOT NULL  COMMENT '工艺流程',
    `materials_accept` VARCHAR(255) NOT NULL  COMMENT '来料验收',
    `has_performance` INT  NOT NULL  COMMENT '是否有力学性能要求表',
    `has_surface_hardness` INT  NOT NULL  COMMENT '是否有表面硬度表',
    `has_materials_accept` INT  NOT NULL  COMMENT '是否有来料验收表',
    `has_craft_curve` INT  NOT NULL  COMMENT '是否有工艺曲线表',
    `has_keypoint` INT  NOT NULL  COMMENT '是否有工艺要点表',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-产品调质工艺卡';
SET FOREIGN_KEY_CHECKS = 1;


