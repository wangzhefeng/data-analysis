SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for info_tempering_demand
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_demand`;
CREATE TABLE `info_tempering_demand` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '调质工艺要求ID',
    `category_id` INT unsigned NULL DEFAULT NULL COMMENT '工艺要求模块ID(基础数据ID)',
    `tempering_id` INT unsigned NULL DEFAULT NULL COMMENT '调质工艺标准信息ID',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE,
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-调质工艺要求表';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_demand
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_demand`;
CREATE TABLE `card_tempering_demand` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT '调质工艺要求ID',
    `category_id` INT unsigned NULL DEFAULT NULL COMMENT '工艺要求模块ID(基础数据ID)',
    `tempering_id` INT unsigned NULL DEFAULT NULL COMMENT '调质卡ID',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE,
    CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-调质工艺要求表';
SET FOREIGN_KEY_CHECKS = 1;


