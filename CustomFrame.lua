require("GUI_utils")

local custom_frame
local module_slots_panel
Module_slots = { }

local selection = {
    building = nil,
    recipe = nil,
    available_modules = Modules_Profiles.intermediate_products
}

local recipe_selector

local function create_title_bar(target_frame)
    local titlebar = target_frame.add { type = "flow" }

    titlebar.drag_target = target_frame
    titlebar.add {
        type = "label",
        style = "frame_title",
        caption = "Performance calculator",
        ignored_by_interaction = true
    }

    local filler = titlebar.add {
        type = "empty-widget",
        style = "draggable_space",
        ignored_by_interaction = true
    }

    filler.style.height = 24
    filler.style.horizontally_stretchable = true

    titlebar.add {
        type = "sprite-button",
        name = Frame_Panels_Names.title_bar.close_button_name,
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        tooltip = { "gui.close-instruction" }
    }
end

local function create_building_configuration(target_frame)
    local craft_settings = Add_flow_panel(target_frame, "horizontal")
    local data_config = Add_inner_panel(craft_settings)

    data_config.add { type = "label", caption = "Crafting Machine Settings", style = "heading_1_label" }
    data_config.add { type = "line" }


    local config_hor_flow = Add_flow_panel(data_config, "horizontal")
    config_hor_flow.style.top_margin = 20
    
    Add_space_in(config_hor_flow, true, false)
    
    -- --BUILDING SELECTOR
    local machine_vert_flow = Add_flow_panel(config_hor_flow)
    local title  = Center_element_horizontally_in_parent(machine_vert_flow,  {  type = "label", caption = "Target Crafting Machine" })
    local building_selector = Center_element_horizontally_in_parent(machine_vert_flow, GUI_Element_Definition.Building_Selector_GUI_Element)
    building_selector.style.size = 100
    -- --------------------------------------
    
    Add_space_in(config_hor_flow, true, false)
    
    --Subtitle
    local subtitle_flow = Add_flow_panel(machine_vert_flow, "horizontal")
    subtitle_flow.style.top_margin = 20
    Add_space_in(subtitle_flow, true, false)
    local subtitle = subtitle_flow.add { type = "label", caption ="Module Settings"}
    Add_space_in(subtitle_flow, true, false)
    -- Add_space_in(subtitle_flow)
    
    local module_container_panel = Add_flow_panel(machine_vert_flow)
    local vert = Test_Panel(module_container_panel)
    -- Add_space_in(vert, false, true)
    -- module_container_panel.style.vertically_stretchable = true
    
    module_slots_panel = Add_flow_panel(vert, "horizontal")
    module_slots_panel.style.height = Frame_Settings.module_slot_size + 20
    module_slots_panel.style.horizontally_stretchable = true
    -- Add_space_in(vert, false, true)
    
    -- --RECIPE SELECTOR 
    local recipe_vert_flow = Add_flow_panel(config_hor_flow)
    title  = Center_element_horizontally_in_parent(recipe_vert_flow,  {  type = "label", caption = "Target Recipe" })
    recipe_selector = Center_element_horizontally_in_parent(recipe_vert_flow, GUI_Element_Definition.Recipe_Selector_GUI_Element)
    recipe_selector.style.size = 100
    -- --------------------------------------
    
    Add_space_in(config_hor_flow, true, false)
    -- filler = Add_filler(config_hor_flow)
    -- filler.style.horizontally_stretchable = true    
end
   



local function update_module_slots()
    local current_slot
    for i=1, #Module_slots do
        current_slot = Module_slots[i]
        current_slot.elem_filters = { {filter = "name", name = selection.available_modules } }

        local keep = false
        for j=1, #selection.available_modules do
            if current_slot.elem_value ~= nil and current_slot.elem_value == selection.available_modules[j] then
                keep = true
            end
        end

        if not keep then
            current_slot.elem_value = nil
        end
    end
end

function Update_Recipe_Selection(selected_recipe)

    if selected_recipe == nil then
        selection.recipe = nil
        return
    end

    selection.available_modules = Modules_Profiles.Basics
    if selected_recipe.subgroup.name == "intermediate-product" then
        selection.available_modules = Modules_Profiles.intermediate_products
    end
    
    if selection.building ~= nil then
        if selection.building.subgroup.name == "smelting-machine" then
            selection.available_modules = Modules_Profiles.intermediate_products
        end
    end

    selection.recipe = selected_recipe

    update_module_slots()
    Update_Performances()
end

function Update_Building_Selection(selected_building)

    if selected_building == nil then
        selection.building = nil
        module_slots_panel.clear()
        Module_slots = { }
        Update_Performances()
        return
    end

    local categories = selected_building.crafting_categories
    selection.building = selected_building

    local filter = {}
    local current_recipe_compat = false
    local current_recipe_category = nil

    if recipe_selector.elem_value ~= nil then
        current_recipe_category = game.recipe_prototypes[recipe_selector.elem_value].category
    end


    for current_category, v in pairs(categories) do
        table.insert(filter, { filter = "category", category = current_category })

        if current_recipe_category ~= nil and current_category == current_recipe_category then
            current_recipe_compat = true
        end
    end

    recipe_selector.elem_filters = filter

    if not current_recipe_compat then
        recipe_selector.elem_value = nil
    end

    
    module_slots_panel.clear()
    Module_slots = { }
    local module_hor_flow = Add_flow_panel(module_slots_panel, "horizontal")

    
    local new_slot
    module_hor_flow.style.top_margin = 10
    module_hor_flow.style.bottom_margin = 10
    local filler = Add_filler(module_hor_flow)
    filler.style.horizontally_stretchable = true

    for i=1, selected_building.module_inventory_size, 1 do
        new_slot = module_hor_flow.add(GUI_Element_Definition.Module_Element_Chooser)
        new_slot.style.size = Frame_Settings.module_slot_size
        new_slot.name = "module-slot-" .. i
        table.insert(Module_slots, new_slot)
        local filler = Add_filler(module_hor_flow)
        filler.style.horizontally_stretchable = true
    end

    update_module_slots()
    Update_Performances()
end

local function create_machine_performance(frame)

    local main_container = Add_flow_panel(frame)
    
    main_container.add { type = "label", caption = "Computed Performances", style = "heading_2_label" }
    main_container.add { type = "line" }

    
end

function Update_Performances()
    
end

function Build_interface(player)
    local screen = player.gui.screen
    custom_frame = screen.add { type = "frame", name = frame_name, direction = "vertical" }
    custom_frame.style.size = Frame_Settings.size
    custom_frame.auto_center = true
    create_title_bar(custom_frame)
    create_building_configuration(custom_frame)
    create_machine_performance(custom_frame)
    player.opened = custom_frame
end
