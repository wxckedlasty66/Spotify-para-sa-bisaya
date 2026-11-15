local applyShapeScale

local function adjustScale(direction)
    local scale = tonumber(SKIN:GetVariable("Scale")) or 100
    local minimum = tonumber(SKIN:GetVariable("MinScale")) or 70
    local maximum = tonumber(SKIN:GetVariable("MaxScale")) or 150
    local step = tonumber(SKIN:GetVariable("ScaleStep")) or 10
    local nextScale = math.max(minimum, math.min(maximum, scale + direction * step))

    if nextScale == scale then
        return
    end

    SKIN:Bang("!SetVariable", "Scale", tostring(nextScale))
    applyShapeScale(nextScale)
    SKIN:Bang("!Update")
    SKIN:Bang("!Redraw")
end

local function scaled(value, scale)
    return math.floor(value * scale / 100 + 0.5)
end

applyShapeScale = function(scale)
    local cardWidth = tonumber(SKIN:GetVariable("CardWidth")) or 520
    local cardHeight = tonumber(SKIN:GetVariable("CardHeight")) or 210
    local cardRadius = tonumber(SKIN:GetVariable("CardRadius")) or 28
    local coverRadius = tonumber(SKIN:GetVariable("CoverRadius")) or 18
    local cardColor = SKIN:GetVariable("CardColor") or "48,43,48,255"

    SKIN:Bang("!SetOption", "MeterCard", "Shape", string.format(
        "Rectangle 0,0,%d,%d,%d | Fill Color %s | StrokeWidth 0",
        scaled(cardWidth, scale),
        scaled(cardHeight, scale),
        scaled(cardRadius, scale),
        cardColor
    ))
    SKIN:Bang("!SetOption", "MeterCoverFallback", "Shape", string.format(
        "Rectangle 0,0,%d,%d,%d | Fill Color 70,62,69,255 | StrokeWidth 0",
        scaled(160, scale),
        scaled(160, scale),
        scaled(coverRadius, scale)
    ))

    if SKIN:GetMeter("MeterSpotifyMark") then
        local function point(value)
            return scaled(value, scale)
        end

        SKIN:Bang("!SetOption", "MeterSpotifyMark", "Shape", string.format(
            "Ellipse %d,%d,%d | Fill Color 248,245,246,255 | StrokeWidth 0",
            point(22),
            point(22),
            point(22)
        ))
        SKIN:Bang("!SetOption", "MeterSpotifyMark", "Shape2", string.format(
            "Curve %d,%d,%d,%d,%d,%d,0 | StrokeWidth %d | Stroke Color %s",
            point(10),
            point(14),
            point(34),
            point(17),
            point(22),
            point(6),
            point(3),
            cardColor
        ))
        SKIN:Bang("!SetOption", "MeterSpotifyMark", "Shape3", string.format(
            "Curve %d,%d,%d,%d,%d,%d,0 | StrokeWidth %d | Stroke Color %s",
            point(12),
            point(22),
            point(32),
            point(25),
            point(22),
            point(15),
            point(3),
            cardColor
        ))
        SKIN:Bang("!SetOption", "MeterSpotifyMark", "Shape4", string.format(
            "Curve %d,%d,%d,%d,%d,%d,0 | StrokeWidth %d | Stroke Color %s",
            point(15),
            point(30),
            point(29),
            point(32),
            point(22),
            point(24),
            point(3),
            cardColor
        ))
    end
end

function Initialize()
    applyShapeScale(tonumber(SKIN:GetVariable("Scale")) or 100)
    return 0
end

function Update()
    return 0
end

function Grow()
    adjustScale(1)
end

function Shrink()
    adjustScale(-1)
end
