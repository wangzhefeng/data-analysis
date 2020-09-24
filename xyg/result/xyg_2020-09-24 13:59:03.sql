SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for craft_curve
-- =================================================================
DROP TABLE IF EXISTS `craft_curve`;
CREATE TABLE `craft_curve` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '工艺曲线ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质卡ID',
    `basic_curve_quenching_id` BIGINT  NOT NULL  COMMENT '淬火基础曲线ID',
    `basic_curve_tempering_id` BIGINT  NOT NULL  COMMENT '回火基础曲线ID',
    `basic_curve_normalizing_id` BIGINT  NOT NULL  COMMENT '正火基础曲线ID',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '工艺曲线表';
SET FOREIGN_KEY_CHECKS = 1;


