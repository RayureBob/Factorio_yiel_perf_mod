event_UI_Toggle = "Performance_gui_shortcut"
frame_name = "performance_gui"

Shortcut_Icon =
{
    filename = "__yield_calculation_tool__/icon.png",
    priority = "extra-high",
    width = 512,
    height = 512
}

Buttons = {
    close_button = "close button",
    building_selection = "building selection",
    recipe_selection = "recipe selection"
}

Frame_Settings = {
    frame_name = "performance_gui",
    size = { 800, 600 },
    module_slot_size = 50
}



Modules_Profiles = {
    Basics =  { "speed-module", "speed-module-2", "speed-module-3", "effectivity-module" , "effectivity-module-2", "effectivity-module-3"},
    intermediate_products = { "speed-module", "speed-module-2", "speed-module-3", "effectivity-module" , "effectivity-module-2", "effectivity-module-3", "productivity-module", "productivity-module-2", "productivity-module-3" }
}

Frame_Panels_Names = {
    title_bar = {
        close_button_name = "close button",
    },

    building_configuration = {
        building_selector_name = "building selection",
        module_panel_name = "module panel",
        temp_module_selector = "temp_module_selector"
    },

    recipe_configuration = {
        recipe_selector_name = "recipe selector"
    }
}

GUI_Element_Definition = {
    Building_Selector_GUI_Element = {
        type = "choose-elem-button",
        name = Frame_Panels_Names.building_configuration.building_selector_name,
        elem_type = "entity",
        elem_filters = { { filter = "crafting-category", crafting_category = "rocket-building", invert = true}}
    },

    Recipe_Selector_GUI_Element = {
        type = "choose-elem-button",
        name = Frame_Panels_Names.recipe_configuration.recipe_selector_name,
        elem_type = "recipe"
    },

    Module_Selector_GUI_Element = {
        type = "choose-elem-button",
    },

    Module_Element_Chooser = {
        type = "choose-elem-button",
        elem_type = "item",
        elem_filters = {{ filter = "name", name = Modules_Profiles.intermediate_products }}
    }
}



