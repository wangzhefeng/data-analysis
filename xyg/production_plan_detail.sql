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
-- Table structure for production_plan_detail
-- ----------------------------
DROP TABLE IF EXISTS `production_plan_detail`;
CREATE TABLE `production_plan_detail`  (
  `SEQ_NO`                     bigint                                                       NOT NULL                                             COMMENT '记录顺序号',
  `CHK_FLAG`                   int                                                          NULL     DEFAULT NULL                                COMMENT '核对状态---0: 未核对, 1: 已核对 ',
  `PLAN_NO`                    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL                                             COMMENT '计划号',
  `PLAN_SEQ`                   int                                                          NULL     DEFAULT 0                                   COMMENT '计划执行顺序号',
  `GROUP_ID`                   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '计划内批次号',
  `GROUP_SEQ`                  int                                                          NULL     DEFAULT 0                                   COMMENT '计划内批次执行顺序号',
  `HEAT_NO`                    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '炼钢炉次号',
  `SLAB_NO`                    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL                                             COMMENT '物料号',
  `PRODUCT_ID`                 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '产品号(钢卷号)',
  `ROLLING_SEQ`                int                                                          NULL     DEFAULT 0                                   COMMENT '物料在计划内的计划轧制顺序号',
  `SLAB_THICKNESS`             int                                                          NULL     DEFAULT 0                                   COMMENT '物料厚度(mm)',
  `SLAB_WIDTH`                 int                                                          NULL     DEFAULT 0                                   COMMENT '物料宽度(mm)',
  `SLAB_LENGTH`                int                                                          NULL     DEFAULT 0                                   COMMENT '物料长度(mm)',
  `SLAB_WEIGHT`                int                                                          NULL     DEFAULT 0                                   COMMENT '物料重量(kg)',
  `STEEL_GRADE`                varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '物料所属钢种',
  `CUSTOMER_GRADE`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '客户钢种',
  `MODEL_GRADE`                varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '模型钢种',
  `PRODUCT_GRADE`              varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '产品钢种',
  `CHARGE_TYPE`                int                                                          NULL     DEFAULT 0                                   COMMENT '来料类型---0: 冷装, 1: 热装, 2: 直接热装',
  `FUR_NO`                     int                                                          NULL     DEFAULT 0                                   COMMENT '计划入炉炉号',
  `Gap`                        int                                                          NULL     DEFAULT 0                                   COMMENT '计划物料间距(mm)',
  `SOAKING_TEMPERATURE`        int                                                          NULL     DEFAULT 0                                   COMMENT '均热温度',
  `TARGET_DIS_TEMP`            int                                                          NULL     DEFAULT 0                                   COMMENT '目标出炉温度',
  `TARGET_DIS_TEMP_UNIFORMITY` int                                                          NULL     DEFAULT 0                                   COMMENT '目标出炉均匀度',
  `MAX_DIS_TEMP`               int                                                          NULL     DEFAULT 0                                   COMMENT '出炉温度上限',
  `MIN_DIS_TEMP`               int                                                          NULL     DEFAULT 0                                   COMMENT '出炉温度下限',
  `HEATING_TIME`               int                                                          NULL     DEFAULT 0                                   COMMENT '加热时间(min)',
  `MAX_HEATING_TIME`           int                                                          NULL     DEFAULT 0                                   COMMENT '加热时间上限(min)',
  `MIN_HEATING_TIME`           int                                                          NULL     DEFAULT 0                                   COMMENT '加热时间下限(min)',
  `SOAKING_TIME`               int                                                          NULL     DEFAULT 0                                   COMMENT '均热时间(min)',
  `MAX_SOAKING_TIME`           int                                                          NULL     DEFAULT 0                                   COMMENT '均热时间上限(min)',
  `MIN_SOAKING_TIME`           int                                                          NULL     DEFAULT 0                                   COMMENT '均热时间下限(min)',
  `TARGET_RM_TEMP`             int                                                          NULL     DEFAULT NULL                                COMMENT '目标粗轧出口温度',
  `MAX_RM_EXIT_TEMP`           int                                                          NULL     DEFAULT 0                                   COMMENT '粗轧末道次出口温度上限',
  `MIN_RM_EXIT_TEMP`           int                                                          NULL     DEFAULT 0                                   COMMENT '粗轧末道次出口温精轧入口度下限',
  `TARGET_CM_ENTRY_TEMP`       int                                                          NULL     DEFAULT 0                                   COMMENT '精轧入口目标温度',
  `MAX_CM_ENTRY_TEMP`          int                                                          NULL     DEFAULT 0                                   COMMENT '精轧入口温度上限',
  `MIN_CM_ENTRY_TEMP`          int                                                          NULL     DEFAULT 0                                   COMMENT '精轧入口温度下限',
  `TARGET_CM_EXIT_TEMP`        int                                                          NULL     DEFAULT 0                                   COMMENT '精轧出口目标温度',
  `MAX_CM_EXIT_TEMP`           int                                                          NULL     DEFAULT 0                                   COMMENT '精轧出口温度上限',
  `MIN_CM_EXIT_TEMP`           int                                                          NULL     DEFAULT 0                                   COMMENT '精轧出口温度下限',
  `TARGET_THICKNESS`           double(5, 2)                                                 NULL     DEFAULT 0.00                                COMMENT '精轧目标厚度(mm)',
  `TARGET_WIDTH`               int                                                          NULL     DEFAULT 0                                   COMMENT '精轧目标宽度(mm)',
  `LAB_FLAG`                   int                                                          NULL     DEFAULT 0                                   COMMENT '化验标志',
  `ELM_AL`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_ALS`                    double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_ALT`                    double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_AS`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_B`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_BA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_BE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_BI`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_BSOL`                   double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_C`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CD`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CO`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CR`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_CU`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_FE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_GA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_GE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_H`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_LA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_LI`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_MG`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_MN`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_MO`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_N`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_NA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_NB`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_ND`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_NI`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_NL`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_O`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_P`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_PB`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_PD`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_R`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_S`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_SB`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_SE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_SI`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_SN`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_SR`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_TA`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_TE`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_TI`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_V`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_W`                      double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_ZN`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ELM_ZR`                     double(10, 5)                                                NULL     DEFAULT 0.00000                             COMMENT '化学元素成分 (10的负五次方)',
  `ORDER_NO`                   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '订单号',
  `FINAL_USE`                  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '最终用途',
  `DESTINATION`                varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '生产目的地(双高线类型的生产线可用)',
  `SLAB_CUTTING_TIME`          varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '板坯连铸切割时间(yyyy-mm-dd hh24:mi:ss)',
  `SEND_TIME`                  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL     DEFAULT NULL                                COMMENT '记录发送时间(yyyy-mm-dd hh24:mi:ss)',
  `TIME_STAMP`                 datetime(0)                                                  NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录接收时间',
  PRIMARY KEY (`SLAB_NO`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
