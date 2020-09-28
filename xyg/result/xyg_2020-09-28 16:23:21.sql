SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for info_tempering_keypoint_tempering
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_keypoint_tempering`;
CREATE TABLE `info_tempering_keypoint_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NULL DEFAULT NULL COMMENT '工艺要点ID',
    `tempering_time_period_min` DOUBLE(10,5) NOT NULL  COMMENT '回火时长下限',
    `tempering_time_period_max` DOUBLE(10,5) NOT NULL  COMMENT '回火时长上限',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE,
    CONSTRAINT `foreign_tempering_keypoint_id_info` FOREIGN KEY (`tempering_keypoint_id`) REFERENCES `info_tempering_keypoint`(`id`)
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-回火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_keypoint_tempering
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_keypoint_tempering`;
CREATE TABLE `card_tempering_keypoint_tempering` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NULL DEFAULT NULL COMMENT '工艺要点ID',
    `tempering_time_period_min` DOUBLE(10,5) NOT NULL  COMMENT '回火时长下限',
    `tempering_time_period_max` DOUBLE(10,5) NOT NULL  COMMENT '回火时长上限',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE,
    CONSTRAINT `foreign_tempering_keypoint_id_card` FOREIGN KEY (`tempering_keypoint_id`) REFERENCES `card_tempering_keypoint`(`id`)
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-回火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


