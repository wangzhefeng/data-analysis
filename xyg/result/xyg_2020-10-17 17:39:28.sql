SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for basic_curve_steel_group_relation_card
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_steel_group_relation_card`;
CREATE TABLE `basic_curve_steel_group_relation_card` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '钢组关系ID',
    `basic_curve_id` INT NULL DEFAULT NULL COMMENT '基础曲线表ID',
    `steeel_group_id` INT NULL DEFAULT NULL COMMENT '钢组表ID',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-基础曲线-钢组关系表';
SET FOREIGN_KEY_CHECKS = 1;


