

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



