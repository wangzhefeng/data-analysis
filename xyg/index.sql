


# info_modify_record
ALTER TABLE `info_modify_record` ADD CONSTRAINT fk_info_craft
FOREIGN KEY(`standard_craft_card_id`) REFERENCES info_craft(`id`);

# card_modify_record
ALTER TABLE `card_modify_record` ADD CONSTRAINT fk_card_craft
FOREIGN KEY(`product_craft_card_id`) REFERENCES card_craft(`id`);
