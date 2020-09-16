/*
 Navicat Premium Data Transfer

 Source Server         : xyg
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : 47.98.51.109:3306
 Source Schema         : xyg-qm

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 16/09/2020 10:04:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for TABLE_NAME
-- ----------------------------
DROP TABLE IF EXISTS `TABLE_NAME`;
CREATE TABLE `TABLE_NAME` (
    `FIELD` TYPE NOT NULL COMMENT `COMMENT`,
    PRIMARY KEY (`PRIMARY_KEY_NAME`) USING FIELD
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;