SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for config_category
-- =================================================================
DROP TABLE IF EXISTS `config_category`;
CREATE TABLE `config_category` (
    `id` INT  NOT NULL  COMMENT '基础分类ID',
    `parent_id` INT  NULL DEFAULT NULL COMMENT '父ID',
    `name` VARCHAR(255) NULL DEFAULT NULL COMMENT '名称',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '基础分类';
SET FOREIGN_KEY_CHECKS = 1;


