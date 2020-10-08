-- ============================================================
-- 基础表格
-- ============================================================
-- 基础数据下拉菜单
ALTER TABLE `config_menu` ADD CONSTRAINT fk_config_menu
FOREIGN KEY(`category_id`) REFERENCES config_category(`id`);

-- 基础曲线点
ALTER TABLE `basic_curve_point` ADD CONSTRAINT fk_basic_curve_point
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

-- 基础曲线-钢组关系表
ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_basic_curve_steel_group_relation_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_basic_curve_steel_group_relation_steel_group_id
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);

-- 基础曲线-树形菜单
ALTER TABLE `basic_curve_menu` ADD CONSTRAINT fk_basic_curve_menu_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

ALTER TABLE `basic_curve_menu` ADD CONSTRAINT fk_basic_curve_menu_category_id
FOREIGN KEY(`category_id`) REFERENCES config_category(`id`);

-- 钢号表
ALTER TABLE `basic_steel_no` ADD CONSTRAINT fk_basic_steel_no
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);

-- 调质工艺曲线树形菜单
ALTER TABLE `craft_curve` ADD CONSTRAINT fk_craft_curve_info_tempering_id
FOREIGN KEY(`info_tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `craft_curve` ADD CONSTRAINT fk_craft_curve_card_tempering_id
FOREIGN KEY(`card_tempering_id`) REFERENCES card_craft_tempering(`id`);

ALTER TABLE `craft_curve` ADD CONSTRAINT fk_craft_curve_category_id
FOREIGN KEY(`category_id`) REFERENCES config_category(`id`);

ALTER TABLE `craft_curve` ADD CONSTRAINT fk_craft_curve_steel_group_id
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);

-- ============================================================
-- 工艺工序
-- ===========================================================
-- 生产配料卡
ALTER TABLE `card_ingredients` ADD CONSTRAINT fk_card_ingredients
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);

-- 工艺工序
-- ------------ info
ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_steel_group_id
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_standard_craft_card_id
FOREIGN KEY(`standard_craft_card_id`) REFERENCES info_craft(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES basic_form(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES info_craft_fast(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES info_craft_diameter(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_process_info_craft_tempering_id
FOREIGN KEY(`info_craft_tempering_id`) REFERENCES info_craft_tempering(`id`);
-- ----------- card 
ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_steel_group_id
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_product_craft_card_id
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES basic_form(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES card_craft_fast(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_basic_from_id
FOREIGN KEY(`basic_form_id`) REFERENCES card_craft_diameter(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_card_craft_process_card_craft_tempering_id
FOREIGN KEY(`card_craft_tempering_id`) REFERENCES card_craft_tempering(`id`);

-- 修改记录
ALTER TABLE `info_modify_record` ADD CONSTRAINT fk_info_modify_record_standard_craft_card_id
FOREIGN KEY(`standard_craft_card_id`) REFERENCES info_craft(`id`);

ALTER TABLE `card_modify_record` ADD CONSTRAINT fk_card_modify_record_product_craft_card_id
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);

-- 快断火次
ALTER TABLE `info_craft_fast_order` ADD CONSTRAINT fk_info_craft_fast_order_craft_fast_id
FOREIGN KEY(`craft_fast_id`) REFERENCES info_craft_fast(`id`);

ALTER TABLE `card_craft_fast_order` ADD CONSTRAINT fk_card_craft_fast_order_craft_fast_id
FOREIGN KEY(`craft_fast_id`) REFERENCES card_craft_fast(`id`);

-- 径锻道次文件配置
ALTER TABLE `info_craft_diameter_passfile` ADD CONSTRAINT fk_info_craft_diameter_passfile_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES info_craft_diameter(`id`);

ALTER TABLE `card_craft_diameter_passfile` ADD CONSTRAINT fk_card_craft_diameter_passfile_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES card_craft_diameter(`id`);

-- 包装入库
ALTER TABLE `info_craft_package` ADD CONSTRAINT fk_process_craft_idinfo_craft_package_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES info_craft_process(`id`);

ALTER TABLE `card_craft_package` ADD CONSTRAINT fk_process_craft_idcard_craft_package_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES card_craft_process(`id`);


-- ============================================================
-- 调质工艺
-- ============================================================
-- 调质工艺卡修改记录
ALTER TABLE `info_craft_tempering_modify_record` ADD CONSTRAINT fk_info_craft_tempering_modify_record_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_craft_tempering_modify_record` ADD CONSTRAINT fk_card_craft_tempering_modify_record_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES card_craft_tempering(`id`);

-- 表面硬度
ALTER TABLE `info_tempering_surface_hardness` ADD CONSTRAINT fk_info_tempering_surface_hardness_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_surface_hardness` ADD CONSTRAINT fk_card_tempering_surface_hardness_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES card_craft_tempering(`id`);

-- 力学性能要求
ALTER TABLE `info_tempering_performance` ADD CONSTRAINT fk_info_tempering_performance_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_performance` ADD CONSTRAINT fk_card_tempering_performance_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES card_craft_tempering(`id`);

-- 工艺要点表
ALTER TABLE `info_tempering_keypoint` ADD CONSTRAINT fk_info_tempering_keypoint_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_keypoint` ADD CONSTRAINT fk_card_tempering_keypoint_tempering_id
FOREIGN KEY(`tempering_id`) REFERENCES card_craft_tempering(`id`);

-- 工艺要点-淬火
ALTER TABLE `info_tempering_keypoint_quenching` ADD CONSTRAINT fk_info_tempering_keypoint_quenching_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);

ALTER TABLE `card_tempering_keypoint_quenching` ADD CONSTRAINT fk_card_tempering_keypoint_quenching_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES card_tempering_keypoint(`id`);

-- 工艺要点-回火
ALTER TABLE `info_tempering_keypoint_tempering` ADD CONSTRAINT fk_info_tempering_keypoint_tempering_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);

ALTER TABLE `card_tempering_keypoint_tempering` ADD CONSTRAINT fk_card_tempering_keypoint_tempering_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES card_tempering_keypoint(`id`);


-- 工艺要点-矫直
ALTER TABLE `info_tempering_keypoint_straightening` ADD CONSTRAINT fk_info_tempering_keypoint_straightening_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);

ALTER TABLE `card_tempering_keypoint_straightening` ADD CONSTRAINT fk_card_tempering_keypoint_straightening_tempering_keypoint_id
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES card_tempering_keypoint(`id`);


-- 多规格
-------------
ALTER TABLE `info_tempering_multiregulation_period` ADD CONSTRAINT fk_info_tempering_multiregulation_period_quenching_pc_id
FOREIGN KEY(`quenching_pc_id`) REFERENCES info_tempering_keypoint_quenching(`id`);

ALTER TABLE `info_tempering_multiregulation_period` ADD CONSTRAINT fk_info_tempering_multiregulation_period_tempering_pc_id
FOREIGN KEY(`tempering_pc_id`) REFERENCES info_tempering_keypoint_tempering(`id`);

ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_card_tempering_multiregulation_period_quenching_pc_id
FOREIGN KEY(`quenching_pc_id`) REFERENCES card_tempering_keypoint_quenching(`id`);

ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_card_tempering_multiregulation_period_tempering_pc_id
FOREIGN KEY(`tempering_pc_id`) REFERENCES card_tempering_keypoint_tempering(`id`);

