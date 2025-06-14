Data.Instances['NameTag'] = Data.Instances['NameTag'] or NewDrawing'Text'{
    Size    = Options.TextSize.Value;
    Center  = true;
    Outline = Options.TextOutline.Value;
    Visible = true;
}
local NameTag = Data.Instances['NameTag']

if ScreenPosition.Z > 0 then
    if Options.ShowName.Value then
        LocalPlayer.NameDisplayDistance = 0

        NameTag.Visible   = true
        NameTag.Text      = v.Text
        NameTag.Size      = Options.TextSize.Value
        NameTag.Outline   = Options.TextOutline.Value
        NameTag.Position  = V2New(ScreenPosition.X, ScreenPosition.Y)
        NameTag.Color     = Color

        if Drawing.Fonts and shared.am_ic3 then
            NameTag.Font = Drawing.Fonts.Monospace
        end
    else
        LocalPlayer.NameDisplayDistance = 100
        NameTag.Visible = false
    end
else
    NameTag.Visible = false
end

Data.Instances['NameTag'] = NameTag
