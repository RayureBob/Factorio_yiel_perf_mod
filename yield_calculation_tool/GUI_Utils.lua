stretch_direction =
{
    horizontal = "horizontally_stretchable",
    vertical = "vertically_stretchable"
}

local function center_element_horizontally(parent, elem)
    local filler_one = parent.add { type = "empty-widget" }
    local created_element = parent.add(elem)
    local filler_two = parent.add { type = "empty-widget" }

    filler_one.style.horizontally_stretchable = true
    filler_two.style.horizontally_stretchable = true

    return created_element
end

function Add_element_to_vertical_group(parent, elem)
    local dir = parent.direction
    local new_flow = Add_flow_panel(parent, "horizontal")

    if dir ==  "vertical" then
        center_element_horizontally(new_flow, elem)
    end
end

function Center_element(parent, elem)
    local filler_one = parent.add { type = "empty-widget" }
    local created_element = parent.add(elem)
    local filler_two = parent.add { type = "empty-widget" }

    filler_one.style.horizontally_stretchable = true
    filler_one.style.vertically_stretchable = true
    filler_two.style.horizontally_stretchable = true
    filler_two.style.vertically_stretchable = true

    return created_element
end

function Center_element_horizontally_in_parent(parent, elem)
    local flow = Add_flow_panel(parent, "horizontal")
    local filler = { }
    local gui_elem = nil

    filler = flow.add { type = "empty-widget" }
    filler.style.horizontally_stretchable = true
    
    gui_elem = flow.add(elem)
    
    filler = flow.add { type = "empty-widget" }
    filler.style.horizontally_stretchable = true

    return gui_elem
end

function Add_inner_title(parent)
end

function Add_filler( parent )
    local filler = parent.add { type = "empty-widget" }
    return filler
end

function Add_inner_panel( parent, direction )
    local dir = "vertical"

    if direction ~= nil then
        dir = direction
    end

    local new_panel = parent.add {
        type = "frame",
        direction = dir,
        style = "inside_shallow_frame_with_padding" 
    }
    return new_panel
end

function Add_flow_panel( parent, direction )
    local dir = "vertical"

    if direction ~= nil then
        dir = direction
    end

    local new_panel = parent.add {
        type = "flow",
        direction = dir
    }
    return new_panel
end

function Add_section_title( parent, caption )
    local flow = Add_flow_panel(parent, "horizontal")

    center_element_horizontally(flow, {
        type = "label",
        caption = caption,
        style = "frame_title"
    })
end

function Add_space_in(parent, hor, vert)
    local filler =  parent.add {type = "empty-widget"}
    filler.style.horizontally_stretchable = hor
    filler.style.vertically_stretchable = vert
end

function Test_Panel(parent, direction)
    local dir = "vertical"

    if direction ~= nil then
        dir = direction
    end

    local new_panel = parent.add {
        type = "frame",
        direction = dir,
        style = "tip_notice_inner_panel" 
    }
    return new_panel
end

function Add_Label_With_Title( frame )
    
end
