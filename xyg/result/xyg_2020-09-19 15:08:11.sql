SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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


