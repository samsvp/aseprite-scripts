-- https://github.com/aseprite/api/tree/main
-- https://behreajj.medium.com/how-to-script-aseprite-tools-in-lua-8f849b08733
-- Possible brush types:
-- BrushType.CIRCLE
-- BrushType.SQUARE
-- BrushType.LINE
-- BrushType.IMAGE

local dlg = Dialog {title = "Choose a color"}

dlg:number {
    id = "x",
    label = "X: ",
    text = string.format("%.1f", 32),
    decimals = 0
}

dlg:number {
    id = "y",
    label = "Y: ",
    text = string.format("%.1f", 32),
    decimals = 0
}

dlg:number {
    id = "angle",
    label = "Angle: ",
    text = string.format("%.1f", 32),
    decimals = 1
}

dlg:slider {
    id = "stroke",
    label = "Stroke: ",
    min = 1,
    max = 64,
    value = 24
}

dlg:combobox{
    id = "brush",
    label = "Brush",
    option= "circle",
    options = { "circle", "square", "line" },
}

dlg:color {
    id = "clr",
    label = "Color",
    color = Color(0xffff7f00)
}

dlg:button {
    id = "ok",
    text = "OK",
    onclick = function()
        local args = dlg.data

        local sprite = app.sprite
        if sprite == nil then
            print("No sprite.")
            return
        end

        local brushtypestr = args.brush
        local brushtype
        if brushtypestr == "circle" then
            brushtype = BrushType.CIRCLE
        elseif brushtypestr == "square" then
            brushtype = BrushType.SQUARE
        else
            brushtype = BrushType.LINE
        end

        local brush = Brush {
            type = brushtype,
            size = args.stroke,
            angle = args.angle,
        }

        app.useTool {
            tool = "pencil",
            color = args.clr,
            brush = brush,
            points = { Point(args.x, args.y) },
        }

        app.refresh()
    end
}

dlg:button {
    id = "cancel",
    text = "Cancel",
    onclick = function()
        dlg:close()
    end
}

dlg:show { wait = false }
