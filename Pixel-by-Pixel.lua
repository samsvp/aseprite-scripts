-- https://github.com/aseprite/api/tree/main
-- https://behreajj.medium.com/how-to-script-aseprite-tools-in-lua-8f849b08733

function colorlerp(c1, c2, fraction)
    return Color {
        r = (c2.red - c1.red) * fraction + c1.red,
        g = (c2.green - c1.green) * fraction + c1.green,
        b = (c2.blue - c1.blue) * fraction + c1.blue,
    }
end

local dlg = Dialog {title = "Choose a color"}

dlg:color {
    id = "clr1",
    label = "Color 1",
    color = Color(0xffff7f00)
}

dlg:color {
    id = "clr2",
    label = "Color 2",
    color = Color(0xff7fff00)
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

        local layer = app.layer
        local cel = sprite:newCel(layer, 1)

        local image = cel.image
        local w = image.width
        local h = image.height

        for i in image:pixels() do
            local x = i.x
            local y = i.y

            local c1 = args.clr1
            local c2 = args.clr2

            local newcolor = colorlerp(c1, c2, (x + w * y) / (w + w * h))
            local color = app.pixelColor.rgba(
                newcolor.red,
                newcolor.green,
                newcolor.blue,
                255
            )
            i(color)
        end

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
