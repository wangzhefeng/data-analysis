(1)产品工艺表-card_craft
    - table1: card_ingredients
    - table2: info_craft
    - params: 
        - mark_no
        - technical_standard
        - material_norm_min
        - material_norm_max

    (2)修改记录-card_modify_record
        - table1: card_craft
        - table2: info_modify_record
        - params: 
            - card_craft.id = info_modify_record.standard_craft_card_id

    (2)工艺工序-card_craft_process
        - table1: card_craft
        - table2: info_craft_process
        - params:
            - card_craft.id = info_craft_process.standard_craft_card_id

        (3)快锻-card_craft_fast
            - table1: card_craft_process
            - table2: info_craft_fast
            - params:
                - card_craft_process.id = info_craft_fast.process_craft_id

            (4)快锻火次-card_craft_fast_order
                - table1: card_craft_process
                - table2: info_craft_fast
                - table3: info_craft_fast_order
                - params:
                    - card_craft_process.id = info_craft_fast.process_craft_id
                    - info_craft_fast.id = info_craft_fast_order.craft_fast_id

        (3)径锻-card_craft_diameter
            - table1: card_craft_process
            - table2: info_craft_diameter
            - params:
                - card_craft_process.id
                - info_craft_diameter.process_craft_id

        (3)card_craft_package
            - table1: card_craft_process
            - table2: info_craft_package
            - params:
                - card_craft_process.id
                - info_craft_package.process_craft_id

        (3)card_craft_tempering
            - table1: card_craft_process
            - table2: info_craft_tempering
            - params: 
                - card_craft_process.info_craft_tempering_id
                - info_craft_tempering.id

            (4)card_craft_tempering_modify_record
                - table1: card_craft_tempering
                - table2: info_craft_tempering_modify_record
                - params:
                    - card_craft_tempering.tempering_id
                    - info_craft_tempering_modify_record.id

            (4)card_tempering_keypoint
                - table1: card_craft_tempering
                - table2: info_tempering_keypoint
                - params:
                    - card_craft_tempering.id
                    - info_tempering_keypoint.tempering_id

                (5)card_tempering_keypoint_quenching
                    - table1: card_tempering_keypoint
                    - table2: info_tempering_keypoint_quenching
                    - params:
                        - card_tempering_keypoint.
                        - info_tempering_keypoint_quenching.

                (5)card_tempering_keypoint_straightening
                    - table1: card_tempering_keypoint
                    - table2: info_tempering_keypoint_straightening
                    - params:
                        - card_tempering_keypoint.id
                        - info_tempering_keypoint_straightening

                (5)card_tempering_keypoint_tempering
                    - table1: card_tempering_keypoint
                    - table2: info_tempering_keypoint_tempering
                    - params:
                        - card_tempering_keypoint
                        - info_tempering_keypoint_tempering

                    (6)card_tempering_multiregulation_period
                        - table1: card_tempering_keypoint_quenching
                        - table2: card_tempering_keypoint_tempering
                        - table2: info_tempering_multiregulation_period
                        - params: 
                            - card_tempering_keypoint_quenching.id
                            - card_tempering_keypoint_tempering.id
                            - info_tempering_multiregulation_period.quenching_pc_id
                            - info_tempering_multiregulation_period.tempering_pc_id

            (4)card_tempering_performance
                - table1: card_craft_tempering
                - table2: info_tempering_performance
                - params:
                    - card_craft_tempering.id
                    - info_tempering_performance.tempering

            (4)card_tempering_surface_hardness
                - table1: card_craft_tempering
                - table2: info_tempering_surface_hardness
                - params:
                    - card_craft_tempering.id
                    - info_tempering_surface_hardness.tempering_id

