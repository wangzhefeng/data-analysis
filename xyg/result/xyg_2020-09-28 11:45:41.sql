SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for info_tempering_multiregulation_period
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_multiregulation_period`;
CREATE TABLE `info_tempering_multiregulation_period` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `quenching_pc_id` BIGINT  NULL DEFAULT NULL COMMENT '淬火过程控制表ID',
    `tempering_pc_id` BIGINT  NULL DEFAULT NULL COMMENT '回火过程控制ID',
    `regulation_max` DOUBLE(10,5) NOT NULL  COMMENT '规格上限',
    `regulation_min` DOUBLE(10,5) NOT NULL  COMMENT '规格下限',
    `period_max` DOUBLE(10,5) NOT NULL  COMMENT '时长上限',
    `period_min` DOUBLE(10,5) NOT NULL  COMMENT '时长下限',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-多规格时长表';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_multiregulation_period
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_multiregulation_period`;
CREATE TABLE `card_tempering_multiregulation_period` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `quenching_pc_id` BIGINT  NULL DEFAULT NULL COMMENT '淬火过程控制表ID',
    `tempering_pc_id` BIGINT  NULL DEFAULT NULL COMMENT '回火过程控制ID',
    `regulation_max` DOUBLE(10,5) NOT NULL  COMMENT '规格上限',
    `regulation_min` DOUBLE(10,5) NOT NULL  COMMENT '规格下限',
    `period_max` DOUBLE(10,5) NOT NULL  COMMENT '时长上限',
    `period_min` DOUBLE(10,5) NOT NULL  COMMENT '时长下限',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-多规格时长表';
SET FOREIGN_KEY_CHECKS = 1;


