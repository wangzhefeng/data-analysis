

-- info_modify_record
ALTER TABLE `info_modify_record` ADD CONSTRAINT fk_info_craft
FOREIGN KEY(`standard_craft_card_id`) REFERENCES info_craft(`id`);

-- card_modify_record
ALTER TABLE `card_modify_record` ADD CONSTRAINT fk_card_craft
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);



-- info_modify_record
ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

-- card_modify_record
ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_steel_group_id
FOREIGN KEY(`steel_group_id`) REFERENCES basic_steel_group(`id`);




-- ============================================================
-- 工艺工序

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_standard_craft_card_id
FOREIGN KEY(`standard_craft_card_id`) REFERENCES info_craft(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_basic_form_id
FOREIGN KEY(`basic_form_id`) REFERENCES basic_form(`id`);

ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

-- ALTER TABLE `info_craft_process` ADD CONSTRAINT fk_info_craft_tempering_id
-- FOREIGN KEY(`info_craft_tempering_id`) REFERENCES info_craft_tempering(`id`);



ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_product_craft_card_id
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_basic_form_id
FOREIGN KEY(`basic_form_id`) REFERENCES basic_form(`id`);

ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

-- ALTER TABLE `card_craft_process` ADD CONSTRAINT fk_info_craft_tempering_id
-- FOREIGN KEY(`info_craft_tempering_id`) REFERENCES card_craft_tempering(`id`);





-- 快锻
ALTER TABLE `info_craft_fast` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES info_craft_process(`id`);

ALTER TABLE `card_craft_fast` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES card_craft_process(`id`);

-- 快断火次
ALTER TABLE `info_craft_fast_order` ADD CONSTRAINT fk_craft_fast_id
FOREIGN KEY(`craft_fast_id`) REFERENCES info_craft_fast(`id`);

ALTER TABLE `card_craft_fast_order` ADD CONSTRAINT fk_craft_fast_id
FOREIGN KEY(`craft_fast_id`) REFERENCES card_craft_fast(`id`);




-- 径锻
ALTER TABLE `info_craft_diameter` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES info_craft_process(`id`);

ALTER TABLE `card_craft_diameter` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES card_craft_process(`id`);




-- 包装入库
ALTER TABLE `info_craft_package` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES info_craft_process(`id`);

ALTER TABLE `card_craft_package` ADD CONSTRAINT fk_process_craft_id
FOREIGN KEY(`process_craft_id`) REFERENCES card_craft_process(`id`);



ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_basic_curve_id
FOREIGN KEY(`basic_curve_id`) REFERENCES basic_curve(`id`);

ALTER TABLE `basic_curve_steel_group_relation` ADD CONSTRAINT fk_steeel_group_id
FOREIGN KEY(`steeel_group_id`) REFERENCES basic_steel_group(`id`);


ALTER TABLE `card_craft` ADD CONSTRAINT fk_product_ingredients_card_id
FOREIGN KEY(`product_ingredients_card_id`) REFERENCES card_ingredients(`id`);



-- ===============================================================================
ALTER TABLE `card_craft_tempering_modify_record` ADD CONSTRAINT fk_tempering_id_1
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_surface_hardness` ADD CONSTRAINT fk_tempering_id_2
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_performance` ADD CONSTRAINT fk_tempering_id_3
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_keypoint` ADD CONSTRAINT fk_tempering_id_4
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);

ALTER TABLE `card_tempering_keypoint_quenching` ADD CONSTRAINT tempering_keypoint_id_1
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);

ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_quenching_pc_id
FOREIGN KEY(`quenching_pc_id`) REFERENCES info_tempering_keypoint_quenching(`id`);

ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_tempering_pc_id
FOREIGN KEY(`tempering_pc_id`) REFERENCES info_tempering_keypoint_tempering(`id`);

ALTER TABLE `card_tempering_keypoint_tempering` ADD CONSTRAINT tempering_keypoint_id_2
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);

ALTER TABLE `card_tempering_keypoint_straightening` ADD CONSTRAINT tempering_keypoint_id_3
FOREIGN KEY(`tempering_keypoint_id`) REFERENCES info_tempering_keypoint(`id`);





ALTER TABLE `craft_curve` ADD CONSTRAINT fk_tempering_id_card
FOREIGN KEY(`tempering_id`) REFERENCES card_craft_tempering(`id`);


ALTER TABLE `craft_curve` ADD CONSTRAINT fk_tempering_id_info
FOREIGN KEY(`tempering_id`) REFERENCES info_craft_tempering(`id`);



ALTER TABLE `craft_curve` ADD CONSTRAINT fk_basic_curve_quenching_id
FOREIGN KEY(`basic_curve_quenching_id`) REFERENCES basic_curve(`id`);


ALTER TABLE `craft_curve` ADD CONSTRAINT fk_basic_curve_tempering_id
FOREIGN KEY(`basic_curve_tempering_id`) REFERENCES basic_curve(`id`);


ALTER TABLE `craft_curve` ADD CONSTRAINT fk_basic_curve_normalizing_id
FOREIGN KEY(`basic_curve_normalizing_id`) REFERENCES basic_curve(`id`);




ALTER TABLE `info_tempering_multiregulation_period` ADD CONSTRAINT fk_quenching_pc_id_info
FOREIGN KEY(`quenching_pc_id`) REFERENCES info_tempering_keypoint_quenching(`id`);



ALTER TABLE `info_tempering_multiregulation_period` ADD CONSTRAINT fk_tempering_pc_id_info
FOREIGN KEY(`tempering_pc_id`) REFERENCES info_tempering_keypoint_tempering(`id`);




ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_quenching_pc_id_card
FOREIGN KEY(`quenching_pc_id`) REFERENCES card_tempering_keypoint_quenching(`id`);


ALTER TABLE `card_tempering_multiregulation_period` ADD CONSTRAINT fk_tempering_pc_id_card
FOREIGN KEY(`tempering_pc_id`) REFERENCES card_tempering_keypoint_tempering(`id`);

