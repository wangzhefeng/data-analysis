SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for basic_curve_popup_card
-- =================================================================
DROP TABLE IF EXISTS `basic_curve_popup_card`;
CREATE TABLE `basic_curve_popup_card` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '基础曲线树形菜单ID',
    `parent_id` INT NULL DEFAULT NULL COMMENT '父ID',
    `node_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '节点名称',
    `upper_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '上限',
    `lower_limit` DOUBLE(10,5) NULL DEFAULT NULL COMMENT '下限',
    `steel_group_id` INT NULL DEFAULT NULL COMMENT '钢组ID',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-基础曲线弹窗树形菜单';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for basic_steel_group_card
-- =================================================================
DROP TABLE IF EXISTS `basic_steel_group_card`;
CREATE TABLE `basic_steel_group_card` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '钢组ID',
    `steel_group_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '钢组名',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-钢组表';
SET FOREIGN_KEY_CHECKS = 1;


