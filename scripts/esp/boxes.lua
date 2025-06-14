Data.Instances['Box'] = Data.Instances['Box'] or LineBox:Create{Thickness = 4} :contentReference[oaicite:0]{index=0}
local Box = Data.Instances['Box']

if Options.ShowBoxes.Value then
    if Visible1 then
        Box['TopLeft'].Visible = true
        Box['TopLeft'].Color   = Color
        Box['TopLeft'].From    = V2New(TLPos.X, TLPos.Y)
        Box['TopLeft'].To      = V2New(TRPos.X, TRPos.Y)
    else
        Box['TopLeft'].Visible = false
    end

    if Visible2 then
        Box['TopRight'].Visible = true
        Box['TopRight'].Color   = Color
        Box['TopRight'].From    = V2New(TRPos.X, TRPos.Y)
        Box['TopRight'].To      = V2New(BRPos.X, BRPos.Y)
    else
        Box['TopRight'].Visible = false
    end

    if Visible3 then
        Box['BottomLeft'].Visible = true
        Box['BottomLeft'].Color   = Color
        Box['BottomLeft'].From    = V2New(BLPos.X, BLPos.Y)
        Box['BottomLeft'].To      = V2New(TLPos.X, TLPos.Y)
    else
        Box['BottomLeft'].Visible = false
    end

    if Visible4 then
        Box['BottomRight'].Visible = true
        Box['BottomRight'].Color   = Color
        Box['BottomRight'].From    = V2New(BRPos.X, BRPos.Y)
        Box['BottomRight'].To      = V2New(BLPos.X, BLPos.Y)
    else
        Box['BottomRight'].Visible = false
    end

    if Properties and typeof(Properties) == 'table' then
        for prop, val in pairs(Properties) do
            pcall(Set, Box['TopLeft'],     prop, val)
            pcall(Set, Box['TopRight'],    prop, val)
            pcall(Set, Box['BottomLeft'],  prop, val)
            pcall(Set, Box['BottomRight'], prop, val)
        end
    end
else
    Box:SetVisible(false)
end
