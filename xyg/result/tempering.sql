SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- Table structure for info_craft_tempering_modify_record
-- =================================================================
DROP TABLE IF EXISTS `info_craft_tempering_modify_record`;
CREATE TABLE `info_craft_tempering_modify_record` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质卡修改记录ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质工艺卡ID',
    `tempering_no` INT NULL DEFAULT NULL COMMENT '编号',
    `quality_key_point` VARCHAR(255) NULL DEFAULT NULL COMMENT '质量要点',
    `modify_content` TEXT  NULL DEFAULT NULL COMMENT '更改内容',
    `created_user` VARCHAR(255) NOT NULL  COMMENT '创建者',
    `updated_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '更新者',
    `deleted_user` VARCHAR(255) NULL DEFAULT NULL COMMENT '删除者',
    `created_datetime` DATETIME(6) NOT NULL  COMMENT '创建日期',
    `updated_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '更新日期',
    `deleted_datetime` DATETIME(6) NULL DEFAULT NULL COMMENT '删除日期',
    `deleted` INT  NOT NULL  COMMENT '删除标记',
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `fk_tempering_` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`)
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-标准调质卡修改记录';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_surface_hardness
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_surface_hardness`;
CREATE TABLE `info_tempering_surface_hardness` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '表面硬度ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质卡ID',
    `hardness_control_max` DOUBLE(10,5) NOT NULL  COMMENT '硬度内控上限',
    `hardness_control_min` DOUBLE(10,5) NOT NULL  COMMENT '硬度内控下限',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-表面硬度';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_performance
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_performance`;
CREATE TABLE `info_tempering_performance` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '力学性能要求ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质卡ID',
    `yield_strength` DOUBLE(10,5) NOT NULL  COMMENT '屈服强度',
    `tensile_strength` DOUBLE(10,5) NOT NULL  COMMENT '抗拉强度',
    `elongation` DOUBLE(10,5) NOT NULL  COMMENT '延伸率',
    `surface_shrinkage` DOUBLE(10,5) NOT NULL  COMMENT '面缩率',
    `celsius_20_vert_lash` DOUBLE(10,5) NOT NULL  COMMENT '20℃纵向冲击',
    `hardness` DOUBLE(10,5) NOT NULL  COMMENT '硬度',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-力学性能要求';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_keypoint
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_keypoint`;
CREATE TABLE `info_tempering_keypoint` (
    `id` BIGINT    COMMENT 'ID',
    `tempering_id` BIGINT    COMMENT '调质卡ID',
    `quenching_num` INT    COMMENT '淬火支数',
    `quench_water_type` VARCHAR(255)   COMMENT '淬水方式',
    `quench_water_period` INT    COMMENT '淬水时间',
    `inflow_water_temp` DOUBLE(10,5)   COMMENT '入水水温',
    `effluent_water_temp` DOUBLE(10,5)   COMMENT '出水水温',
    `effluent_steel_temp` DOUBLE(10,5)   COMMENT '出水钢温',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-工艺要点表';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_keypoint_quenching
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_keypoint_quenching`;
CREATE TABLE `info_tempering_keypoint_quenching` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
    `before_quenching_water_temp_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火前水温下限',
    `after_quenching_water_temp_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火完毕后水温下限',
    `after_quenching_water_temp_max` DOUBLE(10,5) NOT NULL  COMMENT '淬火完毕后水温上限',
    `after_quenching_rewarming_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火后最高回温下限',
    `after_quenching_rewarming_max` DOUBLE(10,5) NOT NULL  COMMENT '淬火后最高回温上限',
    `single_quenching_regulation_min` DOUBLE(10,5) NOT NULL  COMMENT '单支淬火规格下限',
    `single_quenching_regulation_max` DOUBLE(10,5) NOT NULL  COMMENT '单支淬火规格上限',
    `temp_min` DOUBLE(10,5) NOT NULL  COMMENT '最低温度',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-淬火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_multiregulation_period
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_multiregulation_period`;
CREATE TABLE `info_tempering_multiregulation_period` (
    `id` BIGINT  NOT NULL  COMMENT 'ID',
    `quenching_pc_id` BIGINT  NOT NULL  COMMENT '淬火过程控制表ID',
    `tempering_pc_id` BIGINT  NOT NULL  COMMENT '回火过程控制ID',
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
-- Table structure for info_tempering_keypoint_tempering
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_keypoint_tempering`;
CREATE TABLE `info_tempering_keypoint_tempering` (
    `id` BIGINT  NOT NULL  COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
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
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-回火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for info_tempering_keypoint_straightening
-- =================================================================
DROP TABLE IF EXISTS `info_tempering_keypoint_straightening`;
CREATE TABLE `info_tempering_keypoint_straightening` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
    `destress_tempdiff_min` DOUBLE(10,5) NOT NULL  COMMENT '去应力与回火温差下限',
    `destress_tempdiff_max` DOUBLE(10,5) NOT NULL  COMMENT '去应力与回火温差上限',
    `temp_min` DOUBLE(10,5) NOT NULL  COMMENT '去应力温度下限',
    `temp_max` DOUBLE(10,5) NOT NULL  COMMENT '去应力温度上限',
    `warm_stay_molecular` DOUBLE(10,5) NOT NULL  COMMENT '保温时间分子',
    `warm_stay_denominator` DOUBLE(10,5) NOT NULL  COMMENT '保温时间分母',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'info-矫直过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_craft_tempering_modify_record
-- =================================================================
DROP TABLE IF EXISTS `card_craft_tempering_modify_record`;
CREATE TABLE `card_craft_tempering_modify_record` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '调质卡修改记录ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质工艺卡ID',
    `tempering_no` INT NULL DEFAULT NULL COMMENT '编号',
    `quality_key_point` VARCHAR(255) NULL DEFAULT NULL COMMENT '质量要点',
    `modify_content` TEXT  NULL DEFAULT NULL COMMENT '更改内容',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-产品调质卡修改记录';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_surface_hardness
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_surface_hardness`;
CREATE TABLE `card_tempering_surface_hardness` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '表面硬度ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质卡ID',
    `hardness_control_max` DOUBLE(10,5) NOT NULL  COMMENT '硬度内控上限',
    `hardness_control_min` DOUBLE(10,5) NOT NULL  COMMENT '硬度内控下限',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-表面硬度';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_performance
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_performance`;
CREATE TABLE `card_tempering_performance` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT '力学性能要求ID',
    `tempering_id` BIGINT  NOT NULL  COMMENT '调质卡ID',
    `yield_strength` DOUBLE(10,5) NOT NULL  COMMENT '屈服强度',
    `tensile_strength` DOUBLE(10,5) NOT NULL  COMMENT '抗拉强度',
    `elongation` DOUBLE(10,5) NOT NULL  COMMENT '延伸率',
    `surface_shrinkage` DOUBLE(10,5) NOT NULL  COMMENT '面缩率',
    `celsius_20_vert_lash` DOUBLE(10,5) NOT NULL  COMMENT '20℃纵向冲击',
    `hardness` DOUBLE(10,5) NOT NULL  COMMENT '硬度',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-力学性能要求';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_keypoint
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_keypoint`;
CREATE TABLE `card_tempering_keypoint` (
    `id` BIGINT    COMMENT 'ID',
    `tempering_id` BIGINT    COMMENT '调质卡ID',
    `quenching_num` INT    COMMENT '淬火支数',
    `quench_water_type` VARCHAR(255)   COMMENT '淬水方式',
    `quench_water_period` INT    COMMENT '淬水时间',
    `inflow_water_temp` DOUBLE(10,5)   COMMENT '入水水温',
    `effluent_water_temp` DOUBLE(10,5)   COMMENT '出水水温',
    `effluent_steel_temp` DOUBLE(10,5)   COMMENT '出水钢温',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-工艺要点表';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_keypoint_quenching
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_keypoint_quenching`;
CREATE TABLE `card_tempering_keypoint_quenching` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
    `before_quenching_water_temp_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火前水温下限',
    `after_quenching_water_temp_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火完毕后水温下限',
    `after_quenching_water_temp_max` DOUBLE(10,5) NOT NULL  COMMENT '淬火完毕后水温上限',
    `after_quenching_rewarming_min` DOUBLE(10,5) NOT NULL  COMMENT '淬火后最高回温下限',
    `after_quenching_rewarming_max` DOUBLE(10,5) NOT NULL  COMMENT '淬火后最高回温上限',
    `single_quenching_regulation_min` DOUBLE(10,5) NOT NULL  COMMENT '单支淬火规格下限',
    `single_quenching_regulation_max` DOUBLE(10,5) NOT NULL  COMMENT '单支淬火规格上限',
    `temp_min` DOUBLE(10,5) NOT NULL  COMMENT '最低温度',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-淬火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_multiregulation_period
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_multiregulation_period`;
CREATE TABLE `card_tempering_multiregulation_period` (
    `id` BIGINT  NOT NULL  COMMENT 'ID',
    `quenching_pc_id` BIGINT  NOT NULL  COMMENT '淬火过程控制表ID',
    `tempering_pc_id` BIGINT  NOT NULL  COMMENT '回火过程控制ID',
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


-- =================================================================
-- Table structure for card_tempering_keypoint_tempering
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_keypoint_tempering`;
CREATE TABLE `card_tempering_keypoint_tempering` (
    `id` BIGINT  NOT NULL  COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
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
    PRIMARY KEY (`id`) USING BTREE
    -- CONSTRAINT `foreign_key_name` FOREIGN KEY (`foreign_key`) REFERENCES `master_table`(`master_table_primary_key`),
    -- INDEX (`index`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-回火过程控制';
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================
-- Table structure for card_tempering_keypoint_straightening
-- =================================================================
DROP TABLE IF EXISTS `card_tempering_keypoint_straightening`;
CREATE TABLE `card_tempering_keypoint_straightening` (
    `id` BIGINT  NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `tempering_keypoint_id` BIGINT  NOT NULL  COMMENT '工艺要点ID',
    `destress_tempdiff_min` DOUBLE(10,5) NOT NULL  COMMENT '去应力与回火温差下限',
    `destress_tempdiff_max` DOUBLE(10,5) NOT NULL  COMMENT '去应力与回火温差上限',
    `temp_min` DOUBLE(10,5) NOT NULL  COMMENT '去应力温度下限',
    `temp_max` DOUBLE(10,5) NOT NULL  COMMENT '去应力温度上限',
    `warm_stay_molecular` DOUBLE(10,5) NOT NULL  COMMENT '保温时间分子',
    `warm_stay_denominator` DOUBLE(10,5) NOT NULL  COMMENT '保温时间分母',
    `remark` TEXT  NULL DEFAULT NULL COMMENT '备注',
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = 'card-矫直过程控制';
SET FOREIGN_KEY_CHECKS = 1;


