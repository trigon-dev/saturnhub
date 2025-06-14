local TracerPosition = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 135)

Data.Instances['OutlineTracer'] = Data.Instances['OutlineTracer'] or NewDrawing'Line'{
    Transparency    = 0.75;
    Thickness       = 5;
    Color           = Color3.new(0.1, 0.1, 0.1);
}
Data.Instances['Tracer'] = Data.Instances['Tracer'] or NewDrawing'Line'{
    Transparency    = 1;
    Thickness       = 2;
}

local Tracer        = Data.Instances['Tracer']
local OutlineTracer = Data.Instances['OutlineTracer']

if Options.ShowTracers.Value then
    Tracer.Transparency = math.clamp(Distance / 200, 0.45, 0.8)
    Tracer.Visible      = true
    Tracer.From         = TracerPosition
    Tracer.To           = V2New(Position.X, Position.Y)
    Tracer.Color        = Color

    OutlineTracer.Visible       = true
    OutlineTracer.Transparency  = Tracer.Transparency - 0.1
    OutlineTracer.From          = Tracer.From
    OutlineTracer.To            = Tracer.To
    OutlineTracer.Color         = Color3.new(0.1, 0.1, 0.1)
else
    Tracer.Visible        = false
    OutlineTracer.Visible = false
end
