SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for TABLE_NAME
-- ----------------------------
DROP TABLE IF EXISTS `production_plan_detail`;
CREATE TABLE `production_plan_detail` (
    `SEQ_NO` bigint NOT NULL COMMENT `记录顺序号`,
    PRIMARY KEY (`SEQ_NO`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;