require("constants")
require("CustomFrame")

script.on_event(defines.events.on_lua_shortcut,
    function(event)
        if event.prototype_name == event_UI_Toggle then
            player = game.get_player(event.player_index);
            local custom_Frame = player.gui.screen[frame_name];

            if custom_Frame == nil then
                Build_interface(player)
            else
                custom_Frame.destroy()
            end
        end
    end
)

script.on_event(defines.events.on_gui_closed,
    function(event)
        if event.element == nil then return end

        if event.element.name == frame_name then
            print("closing custom frame")
            event.element.destroy()
        end
    end
)

script.on_event(defines.events.on_gui_click,
    function(event)
        if event.element.name == Frame_Panels_Names.title_bar.close_button_name then
            if player == nil then
                player = game.get_player(event.player_index)
            end

            player.gui.screen[frame_name].destroy()
            return
        end
    end
)

script.on_event(defines.events.on_gui_elem_changed,
    function(event)
        if event.element.name == Frame_Panels_Names.recipe_configuration.recipe_selector_name then
            Update_Recipe_Selection(game.recipe_prototypes[event.element.elem_value])
            return
        end

        if event.element.name == Frame_Panels_Names.building_configuration.building_selector_name then
            Update_Building_Selection(game.entity_prototypes[event.element.elem_value])
            return
        end



        for i = 1, #Module_slots, 1 do
            if event.element.name == Module_slots[i].name then
                -- game.print("Interacted with " .. Module_slots[i].name)
                Update_Performances()
            end
        end
    end
)

script.on_event(defines.events.on_gui_text_changed,
    function(event)
        if (event.element.name == Frame_Panels_Names.machine_performance.machine_to_yield.input_field) then
            Update_machine_to_yield(event.element.text)
            return
        end

        if (event.element.name == Frame_Panels_Names.machine_performance.yield_to_machine.input_field) then
            Update_yield_to_machine(event.element.text)
            return
        end
    end
)
