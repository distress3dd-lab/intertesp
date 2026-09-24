

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local ENV =
    getgenv and getgenv()
    or _G

if ENV.__ESP_LIBRARY_CLEANUP then
    pcall(ENV.__ESP_LIBRARY_CLEANUP)
end

local Connections = {}
local Drawings = {}
local Destroyed = false

local function Connect(Signal, Callback)
    local Connection =
        Signal:Connect(Callback)

    table.insert(
        Connections,
        Connection
    )

    return Connection
end

local function RegisterDrawing(Object)
    table.insert(
        Drawings,
        Object
    )

    return Object
end

local CONFIG = {

    Chams = {

        Enabled = true,

        Color = {

            Mode = "Gradient",

            Solid =
                Color3.fromRGB(
                    255,
                    60,
                    90
                ),

            From =
                Color3.fromRGB(
                    255,
                    60,
                    90
                ),

            To =
                Color3.fromRGB(
                    120,
                    70,
                    255
                ),
        },

        MainTransparency = 0.02,

        MainScale = 1,

        Glow = {

            Enabled = true,

            Color = {

                Mode = "Gradient",

                Solid =
                    Color3.fromRGB(
                        255,
                        60,
                        90
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        60,
                        90
                    ),

                To =
                    Color3.fromRGB(
                        120,
                        70,
                        255
                    ),
            },

            Scale1 = 1.035,
            Scale2 = 1.075,
            Scale3 = 1.13,

            Transparency1 = 0.72,
            Transparency2 = 0.86,
            Transparency3 = 0.93,
        },
    },

    ESP = {

        Enabled = true,

        Box = {

            Enabled = true,

            Type = "Corner",

            Thickness = 1.5,

            GradientSegments = 14,

            CornerWidth = 0.28,
            CornerHeight = 0.22,

            Color = {

                Mode = "Gradient",

                Solid =
                    Color3.fromRGB(
                        255,
                        70,
                        90
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        70,
                        90
                    ),

                To =
                    Color3.fromRGB(
                        170,
                        70,
                        255
                    ),
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),

                Thickness = 2,

                Transparency = 0,
            },
        },

        Name = {

            Enabled = true,

            Size = 13,

            Color = {

                Mode = "Solid",

                Solid =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    ),

                To =
                    Color3.fromRGB(
                        180,
                        150,
                        255
                    ),
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),
            },

            Placement = {

                Side = "Top",

                X = 0,

                Y = -17,
            },
        },

        Visibility = {

            Enabled = true,

            Size = 12,

            VisibleText =
                "[VISIBLE]",

            HiddenText =
                "[HIDDEN]",

            VisibleColor = {

                Mode = "Solid",

                Solid =
                    Color3.fromRGB(
                        70,
                        255,
                        120
                    ),

                From =
                    Color3.fromRGB(
                        70,
                        255,
                        120
                    ),

                To =
                    Color3.fromRGB(
                        70,
                        190,
                        255
                    ),
            },

            HiddenColor = {

                Mode = "Solid",

                Solid =
                    Color3.fromRGB(
                        255,
                        70,
                        90
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        70,
                        90
                    ),

                To =
                    Color3.fromRGB(
                        255,
                        170,
                        60
                    ),
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),
            },

            Placement = {

                Side = "Bottom",

                X = 0,

                Y = 5,
            },
        },

        Distance = {

            Enabled = true,

            Size = 12,

            Unit = "Studs",

            DecimalPlaces = 0,

            Color = {

                Mode = "Solid",

                Solid =
                    Color3.fromRGB(
                        220,
                        220,
                        225
                    ),

                From =
                    Color3.fromRGB(
                        80,
                        200,
                        255
                    ),

                To =
                    Color3.fromRGB(
                        190,
                        90,
                        255
                    ),
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),
            },

            Placement = {

                Side = "Bottom",

                X = 0,

                Y = 19,
            },
        },

        Holding = {

            Enabled = true,

            Size = 12,

            EmptyText = "",

            Color = {

                Mode = "Solid",

                Solid =
                    Color3.fromRGB(
                        255,
                        220,
                        100
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        220,
                        100
                    ),

                To =
                    Color3.fromRGB(
                        255,
                        100,
                        130
                    ),
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),
            },

            Placement = {

                Side = "Bottom",

                X = 0,

                Y = 33,
            },
        },

        Health = {

            Enabled = true,

            Width = 2,

            Offset = 6,

            Segments = 32,

            Color = {

                Mode = "Gradient",

                Solid =
                    Color3.fromRGB(
                        60,
                        255,
                        100
                    ),

                From =
                    Color3.fromRGB(
                        255,
                        60,
                        60
                    ),

                To =
                    Color3.fromRGB(
                        60,
                        255,
                        100
                    ),
            },

            Background = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        15,
                        15,
                        15
                    ),

                Width = 4,
            },

            Outline = {

                Enabled = true,

                Color =
                    Color3.fromRGB(
                        0,
                        0,
                        0
                    ),

                Thickness = 2,
            },

            Placement = {

                Side = "Left",

                X = 0,

                Y = 0,
            },
        },
    },
}

local function Clamp(
    Value,
    Minimum,
    Maximum
)

    return math.max(
        Minimum,
        math.min(
            Maximum,
            Value
        )
    )
end

local function ResolveColor(
    Setting,
    T
)

    if Setting.Mode == "Gradient" then

        return Setting.From:Lerp(
            Setting.To,
            Clamp(
                T or 0.5,
                0,
                1
            )
        )
    end

    return Setting.Solid
end

local function RGBText(Color)

    return string.format(
        "%d, %d, %d",

        math.floor(
            Color.R * 255 + 0.5
        ),

        math.floor(
            Color.G * 255 + 0.5
        ),

        math.floor(
            Color.B * 255 + 0.5
        )
    )
end

local BODY_PARTS = {

    Head = true,

    UpperTorso = true,
    LowerTorso = true,

    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,

    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true,

    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,

    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,

    Torso = true,

    ["Left Arm"] = true,
    ["Right Arm"] = true,

    ["Left Leg"] = true,
    ["Right Leg"] = true,
}

local function IsBodyPart(Object)

    return Object:IsA("BasePart")
        and BODY_PARTS[Object.Name] == true
end

for _, Name in ipairs({

    "ViewportESP",
    "ESPConfiguration",

}) do

    local Existing =
        CoreGui:FindFirstChild(Name)

    if Existing then
        Existing:Destroy()
    end
end

local function NewLine()

    local Line =
        RegisterDrawing(
            Drawing.new("Line")
        )

    Line.Visible = false
    Line.Transparency = 1
    Line.Thickness = 1

    return Line
end

local function NewText()

    local Text = RegisterDrawing(Drawing.new("Text"))
    Text.Visible = false
    Text.Center = true
    Text.Outline = false
    Text.Transparency = 1
    Text.Size = 13
    Text.Font = 2
    return Text
end

local ChamGui =
    Instance.new("ScreenGui")

ChamGui.Name =
    "ViewportESP"

ChamGui.IgnoreGuiInset = true

ChamGui.ResetOnSpawn = false

ChamGui.DisplayOrder = 999998

ChamGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Global

ChamGui.Parent =
    CoreGui

local function CreateViewport(
    Name,
    ZIndex
)

    local Viewport =
        Instance.new(
            "ViewportFrame"
        )

    Viewport.Name =
        Name

    Viewport.Size =
        UDim2.fromScale(
            1,
            1
        )

    Viewport.BackgroundTransparency = 1

    Viewport.BorderSizePixel = 0

    Viewport.Ambient =
        Color3.new(
            1,
            1,
            1
        )

    Viewport.LightColor =
        Color3.new(
            1,
            1,
            1
        )

    Viewport.ZIndex =
        ZIndex

    Viewport.Parent =
        ChamGui

    local Camera =
        Instance.new("Camera")

    Camera.Parent =
        Viewport

    Viewport.CurrentCamera =
        Camera

    local World =
        Instance.new(
            "WorldModel"
        )

    World.Parent =
        Viewport

    return {

        Viewport = Viewport,

        Camera = Camera,

        World = World,
    }
end

local Glow3 =
    CreateViewport(
        "Glow3",
        1
    )

local Glow2 =
    CreateViewport(
        "Glow2",
        2
    )

local Glow1 =
    CreateViewport(
        "Glow1",
        3
    )

local Main =
    CreateViewport(
        "Main",
        4
    )

local function GetChamLayers()

    return {

        {
            Data = Glow3,

            Scale =
                CONFIG.Chams.Glow.Scale3,

            Transparency =
                CONFIG.Chams.Glow.Enabled
                and CONFIG.Chams.Glow.Transparency3
                or 1,

            Glow = true,
        },

        {
            Data = Glow2,

            Scale =
                CONFIG.Chams.Glow.Scale2,

            Transparency =
                CONFIG.Chams.Glow.Enabled
                and CONFIG.Chams.Glow.Transparency2
                or 1,

            Glow = true,
        },

        {
            Data = Glow1,

            Scale =
                CONFIG.Chams.Glow.Scale1,

            Transparency =
                CONFIG.Chams.Glow.Enabled
                and CONFIG.Chams.Glow.Transparency1
                or 1,

            Glow = true,
        },

        {
            Data = Main,

            Scale =
                CONFIG.Chams.MainScale,

            Transparency =
                CONFIG.Chams.MainTransparency,

            Glow = false,
        },
    }
end

local function GetChamGradientT(
    Character,
    RealPart
)

    local CF, Size =
        Character:GetBoundingBox()

    if Size.Y <= 0 then
        return 0.5
    end

    local LocalPosition =
        CF:PointToObjectSpace(
            RealPart.Position
        )

    return Clamp(
        0.5
        - (
            LocalPosition.Y
            / Size.Y
        ),

        0,
        1
    )
end

local function CreateCham(
    RealPart
)

    local Result = {}

    for Index, Layer in ipairs(
        GetChamLayers()
    ) do

        local Part =
            Instance.new("Part")

        Part.Name =
            "Cham_"
            .. RealPart.Name

        Part.Shape =
            Enum.PartType.Block

        Part.Anchored = true

        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = false

        Part.CastShadow = false

        Part.Material =
            Enum.Material.Neon

        Part.Size =
            RealPart.Size
            * Layer.Scale

        Part.CFrame =
            RealPart.CFrame

        Part.Parent =
            Layer.Data.World

        Result[Index] = {
            Part = Part,
        }
    end

    return Result
end

local function DestroyCham(
    Cham
)

    for _, Entry in ipairs(
        Cham or {}
    ) do

        if Entry.Part then
            Entry.Part:Destroy()
        end
    end
end

local function NewSegmentedLine()

    local Result = {}

    for Index = 1,
        CONFIG.ESP.Box.GradientSegments do

        Result[Index] =
            NewLine()
    end

    return Result
end

local function HideSegments(
    Lines
)

    for _, Line in ipairs(
        Lines
    ) do

        Line.Visible = false
    end
end

local function UpdateSegments(
    Lines,
    From,
    To,
    ColorSetting,
    Thickness,
    Visible
)

    local Count =
        #Lines

    for Index, Line in ipairs(
        Lines
    ) do

        local A =
            (Index - 1)
            / Count

        local B =
            Index
            / Count

        Line.From =
            From:Lerp(
                To,
                A
            )

        Line.To =
            From:Lerp(
                To,
                B
            )

        Line.Color =
            ResolveColor(
                ColorSetting,
                (A + B) / 2
            )

        Line.Thickness =
            Thickness

        Line.Transparency = 1

        Line.Visible =
            Visible
    end
end

local function NewOutlinedEdge()

    return {

        Outline =
            NewSegmentedLine(),

        Main =
            NewSegmentedLine(),
    }
end

local function HideEdge(
    Edge
)

    HideSegments(
        Edge.Outline
    )

    HideSegments(
        Edge.Main
    )
end

local function UpdateEdge(
    Edge,
    From,
    To,
    Setting,
    Visible
)

    if Setting.Outline.Enabled then

        local OutlineSetting = {

            Mode = "Solid",

            Solid =
                Setting.Outline.Color,
        }

        UpdateSegments(
            Edge.Outline,

            From,
            To,

            OutlineSetting,

            Setting.Thickness
            + Setting.Outline.Thickness,

            Visible
        )

        for _, Line in ipairs(
            Edge.Outline
        ) do

            Line.Transparency =
                1
                - Setting.Outline.Transparency
        end

    else

        HideSegments(
            Edge.Outline
        )
    end

    UpdateSegments(
        Edge.Main,

        From,
        To,

        Setting.Color,

        Setting.Thickness,

        Visible
    )
end

local function CreateESP()

    local ESP = {

        Box = {

            Top =
                NewOutlinedEdge(),

            Bottom =
                NewOutlinedEdge(),

            Left =
                NewOutlinedEdge(),

            Right =
                NewOutlinedEdge(),
        },

        Corners = {

            TLH =
                NewOutlinedEdge(),

            TLV =
                NewOutlinedEdge(),

            TRH =
                NewOutlinedEdge(),

            TRV =
                NewOutlinedEdge(),

            BLH =
                NewOutlinedEdge(),

            BLV =
                NewOutlinedEdge(),

            BRH =
                NewOutlinedEdge(),

            BRV =
                NewOutlinedEdge(),
        },

        Name =
            NewText(),

        Visibility =
            NewText(),

        Distance =
            NewText(),

        Holding =
            NewText(),

        HealthOutline =
            NewLine(),

        HealthBackground =
            NewLine(),

        Health = {
            Segments = {},
        },
    }

    for Index = 1,
        CONFIG.ESP.Health.Segments do

        ESP.Health.Segments[Index] =
            NewLine()
    end

    return ESP
end

local function HideESP(
    ESP
)

    for _, Edge in pairs(
        ESP.Box
    ) do

        HideEdge(Edge)
    end

    for _, Edge in pairs(
        ESP.Corners
    ) do

        HideEdge(Edge)
    end

    ESP.Name.Visible = false

    ESP.Visibility.Visible = false

    ESP.Distance.Visible = false

    ESP.Holding.Visible = false

    ESP.HealthOutline.Visible = false

    ESP.HealthBackground.Visible = false

    for _, Line in ipairs(
        ESP.Health.Segments
    ) do

        Line.Visible = false
    end
end

local Tracked = {}

local CharacterConnections = {}

local function RemovePlayer(
    Player
)

    local Data =
        Tracked[Player]

    if Data then

        for _, Cham in pairs(
            Data.Parts
        ) do

            DestroyCham(
                Cham
            )
        end

        if Data.ESP then
            HideESP(
                Data.ESP
            )
        end

        Tracked[Player] =
            nil
    end
end

local function TrackCharacter(
    Player,
    Character
)

    if Player == LocalPlayer then
        return
    end

    RemovePlayer(
        Player
    )

    local Data = {

        Character =
            Character,

        Parts = {},

        ESP =
            CreateESP(),
    }

    Tracked[Player] =
        Data

    for _, Object in ipairs(
        Character:GetChildren()
    ) do

        if IsBodyPart(Object) then

            Data.Parts[Object] =
                CreateCham(
                    Object
                )
        end
    end
end

local function TrackPlayer(
    Player
)

    if Player == LocalPlayer then
        return
    end

    if Player.Character then

        TrackCharacter(
            Player,
            Player.Character
        )
    end

    CharacterConnections[Player] =
        Connect(
            Player.CharacterAdded,

            function(Character)

                Character:WaitForChild(
                    "HumanoidRootPart",
                    10
                )

                task.wait(0.1)

                if not Destroyed then

                    TrackCharacter(
                        Player,
                        Character
                    )
                end
            end
        )
end

local function GetScreenBounds(
    Character,
    Camera
)
    local MinX, MinY = math.huge, math.huge
    local MaxX, MaxY = -math.huge, -math.huge
    local Found = false

    for _, Part in ipairs(Character:GetChildren()) do
        if IsBodyPart(Part) then
            local Half = Part.Size * 0.5
            for X = -1, 1, 2 do
                for Y = -1, 1, 2 do
                    for Z = -1, 1, 2 do
                        local WorldCorner = Part.CFrame:PointToWorldSpace(Vector3.new(Half.X * X, Half.Y * Y, Half.Z * Z))
                        local Point = Camera:WorldToViewportPoint(WorldCorner)
                        if Point.Z > 0 then
                            Found = true
                            MinX = math.min(MinX, Point.X)
                            MinY = math.min(MinY, Point.Y)
                            MaxX = math.max(MaxX, Point.X)
                            MaxY = math.max(MaxY, Point.Y)
                        end
                    end
                end
            end
        end
    end

    if not Found then return nil end
    local Width, Height = MaxX - MinX, MaxY - MinY
    if Width <= 0 or Height <= 0 then return nil end
    return {Left=MinX, Right=MaxX, Top=MinY, Bottom=MaxY, Width=Width, Height=Height, CenterX=(MinX+MaxX)*0.5, CenterY=(MinY+MaxY)*0.5}
end

local function IsVisible(
    Character,
    Camera
)

    local Target =
        Character:
        FindFirstChild("Head")

        or Character:
        FindFirstChild(
            "HumanoidRootPart"
        )

    if not Target then
        return false
    end

    local Parameters =
        RaycastParams.new()

    Parameters.FilterType =
        Enum.RaycastFilterType.Exclude

    local Ignore = {
        Character,
    }

    if LocalPlayer.Character then

        table.insert(
            Ignore,
            LocalPlayer.Character
        )
    end

    Parameters.FilterDescendantsInstances =
        Ignore

    local Origin =
        Camera.CFrame.Position

    local Result =
        workspace:Raycast(

            Origin,

            Target.Position
            - Origin,

            Parameters
        )

    return Result == nil
end

local function HideBoxes(
    ESP
)

    for _, Edge in pairs(
        ESP.Box
    ) do

        HideEdge(Edge)
    end

    for _, Edge in pairs(
        ESP.Corners
    ) do

        HideEdge(Edge)
    end
end

local function DrawFullBox(
    ESP,
    B
)

    local TL =
        Vector2.new(
            B.Left,
            B.Top
        )

    local TR =
        Vector2.new(
            B.Right,
            B.Top
        )

    local BL =
        Vector2.new(
            B.Left,
            B.Bottom
        )

    local BR =
        Vector2.new(
            B.Right,
            B.Bottom
        )

    local Setting =
        CONFIG.ESP.Box

    UpdateEdge(
        ESP.Box.Top,
        TL,
        TR,
        Setting,
        true
    )

    UpdateEdge(
        ESP.Box.Bottom,
        BL,
        BR,
        Setting,
        true
    )

    UpdateEdge(
        ESP.Box.Left,
        TL,
        BL,
        Setting,
        true
    )

    UpdateEdge(
        ESP.Box.Right,
        TR,
        BR,
        Setting,
        true
    )
end

local function DrawCornerBox(
    ESP,
    B
)

    local L =
        B.Left

    local R =
        B.Right

    local T =
        B.Top

    local Bottom =
        B.Bottom

    local CW =
        B.Width
        * CONFIG.ESP.Box.CornerWidth

    local CH =
        B.Height
        * CONFIG.ESP.Box.CornerHeight

    local S =
        CONFIG.ESP.Box

    UpdateEdge(
        ESP.Corners.TLH,

        Vector2.new(
            L,
            T
        ),

        Vector2.new(
            L + CW,
            T
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.TLV,

        Vector2.new(
            L,
            T
        ),

        Vector2.new(
            L,
            T + CH
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.TRH,

        Vector2.new(
            R,
            T
        ),

        Vector2.new(
            R - CW,
            T
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.TRV,

        Vector2.new(
            R,
            T
        ),

        Vector2.new(
            R,
            T + CH
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.BLH,

        Vector2.new(
            L,
            Bottom
        ),

        Vector2.new(
            L + CW,
            Bottom
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.BLV,

        Vector2.new(
            L,
            Bottom
        ),

        Vector2.new(
            L,
            Bottom - CH
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.BRH,

        Vector2.new(
            R,
            Bottom
        ),

        Vector2.new(
            R - CW,
            Bottom
        ),

        S,
        true
    )

    UpdateEdge(
        ESP.Corners.BRV,

        Vector2.new(
            R,
            Bottom
        ),

        Vector2.new(
            R,
            Bottom - CH
        ),

        S,
        true
    )
end

local function GetESPScale(Bounds)

    return 1
end

local function GetPlacementPosition(
    Bounds,
    Placement
)
    local Side = Placement.Side or "Bottom"

    local X = tonumber(Placement.X) or 0
    local Y = tonumber(Placement.Y) or 0

    local CenterX = Bounds.CenterX or ((Bounds.Left + Bounds.Right) * 0.5)
    local CenterY = Bounds.CenterY or ((Bounds.Top + Bounds.Bottom) * 0.5)

    if Side == "Top" then
        return Vector2.new(CenterX + X, Bounds.Top + Y)
    elseif Side == "Bottom" then
        return Vector2.new(CenterX + X, Bounds.Bottom + Y)
    elseif Side == "Left" then
        return Vector2.new(Bounds.Left + X, CenterY + Y)
    elseif Side == "Right" then
        return Vector2.new(Bounds.Right + X, CenterY + Y)
    else
        return Vector2.new(CenterX + X, CenterY + Y)
    end
end

local function SnapPixel(Value)
    return math.floor(Value + 0.5)
end

local function ApplyTextPlacement(
    Text,
    Bounds,
    Placement
)
    local Position = GetPlacementPosition(Bounds, Placement)

    Text.Center = true
    Text.Position = Vector2.new(
        SnapPixel(Position.X),
        SnapPixel(Position.Y)
    )
end

local function HideHealth(
    ESP
)

    ESP.HealthOutline.Visible =
        false

    ESP.HealthBackground.Visible =
        false

    for _, Line in ipairs(
        ESP.Health.Segments
    ) do

        Line.Visible =
            false
    end
end

local function GetHealthGeometry(
    Bounds
)
    local H = CONFIG.ESP.Health
    local P = H.Placement
    local Side = P.Side or "Left"

    local XOff = tonumber(P.X) or 0
    local YOff = tonumber(P.Y) or 0
    local Distance = tonumber(H.Offset) or 0
    if Side == "Left" then
        local X = Bounds.Left - Distance + XOff
        return {Vertical=true, Start=Vector2.new(X, Bounds.Bottom + YOff), Finish=Vector2.new(X, Bounds.Top + YOff)}
    elseif Side == "Right" then
        local X = Bounds.Right + Distance + XOff
        return {Vertical=true, Start=Vector2.new(X, Bounds.Bottom + YOff), Finish=Vector2.new(X, Bounds.Top + YOff)}
    elseif Side == "Top" then
        local Y = Bounds.Top - Distance + YOff
        return {Vertical=false, Start=Vector2.new(Bounds.Left + XOff, Y), Finish=Vector2.new(Bounds.Right + XOff, Y)}
    else
        local Y = Bounds.Bottom + Distance + YOff
        return {Vertical=false, Start=Vector2.new(Bounds.Left + XOff, Y), Finish=Vector2.new(Bounds.Right + XOff, Y)}
    end
end

local function DrawHealth(
    ESP,
    Bounds,
    Humanoid
)

    local H =
        CONFIG.ESP.Health

    if not H.Enabled
        or not Humanoid
        or Humanoid.MaxHealth <= 0 then

        HideHealth(
            ESP
        )

        return
    end

    local Percent =
        Clamp(
            Humanoid.Health
            / Humanoid.MaxHealth,

            0,
            1
        )

    local Geometry =
        GetHealthGeometry(
            Bounds
        )

    local FullStart =
        Geometry.Start

    local FullEnd =
        Geometry.Finish

    if H.Outline.Enabled then

        ESP.HealthOutline.From =
            FullStart

        ESP.HealthOutline.To =
            FullEnd

        ESP.HealthOutline.Color =
            H.Outline.Color

        ESP.HealthOutline.Thickness =
            H.Width
            + H.Outline.Thickness

        ESP.HealthOutline.Transparency =
            1

        ESP.HealthOutline.Visible =
            true

    else

        ESP.HealthOutline.Visible =
            false
    end

    if H.Background.Enabled then

        ESP.HealthBackground.From =
            FullStart

        ESP.HealthBackground.To =
            FullEnd

        ESP.HealthBackground.Color =
            H.Background.Color

        ESP.HealthBackground.Thickness =
            H.Background.Width

        ESP.HealthBackground.Transparency =
            1

        ESP.HealthBackground.Visible =
            true

    else

        ESP.HealthBackground.Visible =
            false
    end

    local FilledEnd =
        FullStart:Lerp(
            FullEnd,
            Percent
        )

    local Segments =
        ESP.Health.Segments

    local Count =
        #Segments

    for Index, Line in ipairs(
        Segments
    ) do

        local A =
            (Index - 1)
            / Count

        local B =
            Index
            / Count

        Line.From =
            FullStart:Lerp(
                FilledEnd,
                A
            )

        Line.To =
            FullStart:Lerp(
                FilledEnd,
                B
            )

        Line.Color =
            ResolveColor(
                H.Color,
                (A + B) / 2
            )

        Line.Thickness =
            H.Width

        Line.Transparency = 1

        Line.Visible =
            Percent > 0
    end
end

local function ConfigureText(
    Object,
    Text,
    Size,
    ColorSetting,
    Outline,
    Bounds
)
    Object.Text = tostring(Text or "")

    Object.Size = math.floor((tonumber(Size) or 13) + 0.5)

    Object.Center = true
    Object.Color = ResolveColor(ColorSetting, 0.5)
    Object.Outline = Outline.Enabled == true
    Object.OutlineColor = Outline.Color
    Object.Transparency = 1
    Object.Visible = true
end

local function DrawDistance(
    ESP,
    Character,
    Bounds
)

    local Setting =
        CONFIG.ESP.Distance

    if not Setting.Enabled then

        ESP.Distance.Visible =
            false

        return
    end

    local TargetRoot =
        Character:
        FindFirstChild(
            "HumanoidRootPart"
        )

    local LocalCharacter =
        LocalPlayer.Character

    local LocalRoot =
        LocalCharacter
        and LocalCharacter:
        FindFirstChild(
            "HumanoidRootPart"
        )

    if not TargetRoot
        or not LocalRoot then

        ESP.Distance.Visible =
            false

        return
    end

    local Distance =
        (
            TargetRoot.Position
            - LocalRoot.Position
        ).Magnitude

    local Suffix =
        " studs"

    if Setting.Unit == "Meters" then

        Distance =
            Distance * 0.28

        Suffix =
            "m"
    end

    local Places =
        Setting.DecimalPlaces

    local Power =
        10 ^ Places

    Distance =
        math.floor(
            Distance
            * Power
            + 0.5
        ) / Power

    ConfigureText(

        ESP.Distance,

        string.format(
            "%."
            .. tostring(Places)
            .. "f%s",

            Distance,
            Suffix
        ),

        Setting.Size,

        Setting.Color,

        Setting.Outline,

        Bounds
    )

    ApplyTextPlacement(
        ESP.Distance,
        Bounds,
        Setting.Placement
    )
end

local function DrawHolding(
    ESP,
    Character,
    Bounds
)

    local Setting =
        CONFIG.ESP.Holding

    if not Setting.Enabled then

        ESP.Holding.Visible =
            false

        return
    end

    local Tool =
        Character:
        FindFirstChildOfClass(
            "Tool"
        )

    local Text =
        Tool
        and Tool.Name
        or Setting.EmptyText

    if not Text
        or Text == "" then

        ESP.Holding.Visible =
            false

        return
    end

    ConfigureText(

        ESP.Holding,

        Text,

        Setting.Size,

        Setting.Color,

        Setting.Outline,

        Bounds
    )

    ApplyTextPlacement(
        ESP.Holding,
        Bounds,
        Setting.Placement
    )
end

local SettingsGui =
    Instance.new("ScreenGui")

SettingsGui.Name =
    "ESPConfiguration"

SettingsGui.IgnoreGuiInset = true

SettingsGui.ResetOnSpawn = false

SettingsGui.DisplayOrder =
    1000000

SettingsGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Global

SettingsGui.Parent =
    CoreGui

local Window =
    Instance.new("Frame")

Window.Name =
    "Window"

Window.Size =
    UDim2.fromOffset(
        660,
        510
    )

Window.Position =
    UDim2.new(
        0.5,
        -330,
        0.5,
        -255
    )

Window.BackgroundColor3 =
    Color3.fromRGB(
        18,
        18,
        22
    )

Window.BorderSizePixel = 0

Window.Parent =
    SettingsGui

local WindowCorner =
    Instance.new("UICorner")

WindowCorner.CornerRadius =
    UDim.new(
        0,
        8
    )

WindowCorner.Parent =
    Window

local TitleBar =
    Instance.new("Frame")

TitleBar.Size =
    UDim2.new(
        1,
        0,
        0,
        42
    )

TitleBar.BackgroundColor3 =
    Color3.fromRGB(
        24,
        24,
        30
    )

TitleBar.BorderSizePixel = 0

TitleBar.Parent =
    Window

local Title =
    Instance.new("TextLabel")

Title.Size =
    UDim2.new(
        1,
        -20,
        1,
        0
    )

Title.Position =
    UDim2.fromOffset(
        12,
        0
    )

Title.BackgroundTransparency = 1

Title.Text =
    "ESP Configuration"

Title.TextColor3 =
    Color3.fromRGB(
        240,
        240,
        245
    )

Title.TextSize = 16

Title.Font =
    Enum.Font.GothamSemibold

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Parent =
    TitleBar

local Dragging = false

local DragStart

local StartPosition

Connect(
    TitleBar.InputBegan,

    function(Input)

        if Input.UserInputType
            == Enum.UserInputType.MouseButton1 then

            Dragging = true

            DragStart =
                Input.Position

            StartPosition =
                Window.Position
        end
    end
)

Connect(
    UserInputService.InputEnded,

    function(Input)

        if Input.UserInputType
            == Enum.UserInputType.MouseButton1 then

            Dragging = false
        end
    end
)

Connect(
    UserInputService.InputChanged,

    function(Input)

        if Dragging
            and Input.UserInputType
            == Enum.UserInputType.MouseMovement then

            local Delta =
                Input.Position
                - DragStart

            Window.Position =
                UDim2.new(

                    StartPosition.X.Scale,

                    StartPosition.X.Offset
                    + Delta.X,

                    StartPosition.Y.Scale,

                    StartPosition.Y.Offset
                    + Delta.Y
                )
        end
    end
)

local Sidebar =
    Instance.new("Frame")

Sidebar.Position =
    UDim2.fromOffset(
        0,
        42
    )

Sidebar.Size =
    UDim2.new(
        0,
        130,
        1,
        -42
    )

Sidebar.BackgroundColor3 =
    Color3.fromRGB(
        21,
        21,
        26
    )

Sidebar.BorderSizePixel = 0

Sidebar.Parent =
    Window

local SidebarPadding =
    Instance.new("UIPadding")

SidebarPadding.PaddingTop =
    UDim.new(
        0,
        8
    )

SidebarPadding.PaddingLeft =
    UDim.new(
        0,
        8
    )

SidebarPadding.PaddingRight =
    UDim.new(
        0,
        8
    )

SidebarPadding.Parent =
    Sidebar

local SidebarLayout =
    Instance.new("UIListLayout")

SidebarLayout.Padding =
    UDim.new(
        0,
        4
    )

SidebarLayout.Parent =
    Sidebar

local Content =
    Instance.new("Frame")

Content.Position =
    UDim2.fromOffset(
        130,
        42
    )

Content.Size =
    UDim2.new(
        1,
        -130,
        1,
        -42
    )

Content.BackgroundTransparency = 1

Content.Parent =
    Window

local Pages = {}

local TabButtons = {}

local function CreatePage(
    Name
)

    local Page =
        Instance.new(
            "ScrollingFrame"
        )

    Page.Name =
        Name

    Page.Size =
        UDim2.fromScale(
            1,
            1
        )

    Page.BackgroundTransparency = 1

    Page.BorderSizePixel = 0

    Page.ScrollBarThickness = 4

    Page.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Page.CanvasSize =
        UDim2.new()

    Page.Visible = false

    Page.Parent =
        Content

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingTop =
        UDim.new(
            0,
            12
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            14
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            14
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            14
        )

    Padding.Parent =
        Page

    local Layout =
        Instance.new(
            "UIListLayout"
        )

    Layout.Padding =
        UDim.new(
            0,
            7
        )

    Layout.Parent =
        Page

    Pages[Name] =
        Page

    return Page
end

local function ShowPage(
    Name
)

    for PageName, Page in pairs(
        Pages
    ) do

        Page.Visible =
            PageName == Name
    end

    for ButtonName, Button in pairs(
        TabButtons
    ) do

        Button.BackgroundColor3 =
            ButtonName == Name

            and Color3.fromRGB(
                90,
                65,
                180
            )

            or Color3.fromRGB(
                30,
                30,
                37
            )
    end
end

local function NewRow(
    Page,
    Height
)

    local Row =
        Instance.new("Frame")

    Row.Size =
        UDim2.new(
            1,
            0,
            0,
            Height or 34
        )

    Row.BackgroundColor3 =
        Color3.fromRGB(
            27,
            27,
            33
        )

    Row.BorderSizePixel = 0

    Row.Parent =
        Page

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            5
        )

    Corner.Parent =
        Row

    return Row
end

local function NewLabel(
    Parent,
    Text
)

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            0.55,
            0,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(
            10,
            0
        )

    Label.BackgroundTransparency = 1

    Label.Text =
        Text

    Label.TextColor3 =
        Color3.fromRGB(
            225,
            225,
            230
        )

    Label.TextSize = 13

    Label.Font =
        Enum.Font.Gotham

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Parent =
        Parent

    return Label
end

local function AddSection(
    Page,
    Text
)

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            0,
            0,
            26
        )

    Label.BackgroundTransparency = 1

    Label.Text =
        Text

    Label.TextColor3 =
        Color3.fromRGB(
            165,
            165,
            180
        )

    Label.TextSize = 12

    Label.Font =
        Enum.Font.GothamSemibold

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Parent =
        Page
end

local function AddToggle(
    Page,
    Name,
    Getter,
    Setter
)

    local Row =
        NewRow(Page)

    NewLabel(
        Row,
        Name
    )

    local Button =
        Instance.new("TextButton")

    Button.Size =
        UDim2.fromOffset(
            64,
            24
        )

    Button.AnchorPoint =
        Vector2.new(
            1,
            0.5
        )

    Button.Position =
        UDim2.new(
            1,
            -7,
            0.5,
            0
        )

    Button.BorderSizePixel = 0

    Button.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    Button.TextSize = 12

    Button.Font =
        Enum.Font.GothamSemibold

    Button.Parent =
        Row

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            5
        )

    Corner.Parent =
        Button

    local function Refresh()

        local Enabled =
            Getter()

        Button.Text =
            Enabled
            and "ON"
            or "OFF"

        Button.BackgroundColor3 =
            Enabled

            and Color3.fromRGB(
                95,
                70,
                190
            )

            or Color3.fromRGB(
                45,
                45,
                52
            )
    end

    Connect(
        Button.MouseButton1Click,

        function()

            Setter(
                not Getter()
            )

            Refresh()
        end
    )

    Refresh()
end

local function AddDropdown(
    Page,
    Name,
    Options,
    Getter,
    Setter
)

    local Row =
        NewRow(Page)

    NewLabel(
        Row,
        Name
    )

    local Button =
        Instance.new("TextButton")

    Button.Size =
        UDim2.fromOffset(
            140,
            24
        )

    Button.AnchorPoint =
        Vector2.new(
            1,
            0.5
        )

    Button.Position =
        UDim2.new(
            1,
            -7,
            0.5,
            0
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            40,
            40,
            48
        )

    Button.BorderSizePixel = 0

    Button.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    Button.TextSize = 12

    Button.Font =
        Enum.Font.Gotham

    Button.Parent =
        Row

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            5
        )

    Corner.Parent =
        Button

    local function Refresh()

        Button.Text =
            tostring(
                Getter()
            )
    end

    Connect(
        Button.MouseButton1Click,

        function()

            local Current =
                Getter()

            local Index =
                table.find(
                    Options,
                    Current
                ) or 1

            Index =
                Index + 1

            if Index > #Options then
                Index = 1
            end

            Setter(
                Options[Index]
            )

            Refresh()
        end
    )

    Refresh()
end

local function AddSlider(
    Page,
    Name,
    Minimum,
    Maximum,
    Getter,
    Setter,
    Decimals
)

    local Row =
        NewRow(
            Page,
            44
        )

    local Label =
        NewLabel(
            Row,
            Name
        )

    Label.Size =
        UDim2.new(
            0.5,
            0,
            0,
            24
        )

    local ValueLabel =
        Instance.new("TextLabel")

    ValueLabel.Size =
        UDim2.fromOffset(
            80,
            24
        )

    ValueLabel.AnchorPoint =
        Vector2.new(
            1,
            0
        )

    ValueLabel.Position =
        UDim2.new(
            1,
            -8,
            0,
            0
        )

    ValueLabel.BackgroundTransparency = 1

    ValueLabel.TextColor3 =
        Color3.fromRGB(
            190,
            190,
            200
        )

    ValueLabel.TextSize = 12

    ValueLabel.Font =
        Enum.Font.Gotham

    ValueLabel.TextXAlignment =
        Enum.TextXAlignment.Right

    ValueLabel.Parent =
        Row

    local Track =
        Instance.new("Frame")

    Track.Position =
        UDim2.new(
            0,
            10,
            0,
            29
        )

    Track.Size =
        UDim2.new(
            1,
            -20,
            0,
            6
        )

    Track.BackgroundColor3 =
        Color3.fromRGB(
            45,
            45,
            53
        )

    Track.BorderSizePixel = 0

    Track.Parent =
        Row

    local TrackCorner =
        Instance.new("UICorner")

    TrackCorner.CornerRadius =
        UDim.new(
            1,
            0
        )

    TrackCorner.Parent =
        Track

    local Fill =
        Instance.new("Frame")

    Fill.Size =
        UDim2.fromScale(
            0,
            1
        )

    Fill.BackgroundColor3 =
        Color3.fromRGB(
            115,
            80,
            220
        )

    Fill.BorderSizePixel = 0

    Fill.Parent =
        Track

    local FillCorner =
        Instance.new("UICorner")

    FillCorner.CornerRadius =
        UDim.new(
            1,
            0
        )

    FillCorner.Parent =
        Fill

    local Sliding = false

    local function Round(Value)

        local Power =
            10 ^ (Decimals or 0)

        return math.floor(
            Value
            * Power
            + 0.5
        ) / Power
    end

    local function Refresh()

        local Value =
            Getter()

        local Alpha =
            Clamp(
                (
                    Value
                    - Minimum
                )
                / (
                    Maximum
                    - Minimum
                ),

                0,
                1
            )

        Fill.Size =
            UDim2.fromScale(
                Alpha,
                1
            )

        ValueLabel.Text =
            tostring(
                Round(Value)
            )
    end

    local function SetFromX(
        X
    )

        local Alpha =
            Clamp(
                (
                    X
                    - Track.AbsolutePosition.X
                )
                / Track.AbsoluteSize.X,

                0,
                1
            )

        Setter(
            Round(
                Minimum
                + (
                    Maximum
                    - Minimum
                )
                * Alpha
            )
        )

        Refresh()
    end

    Connect(
        Track.InputBegan,

        function(Input)

            if Input.UserInputType
                == Enum.UserInputType.MouseButton1 then

                Sliding = true

                SetFromX(
                    Input.Position.X
                )
            end
        end
    )

    Connect(
        UserInputService.InputChanged,

        function(Input)

            if Sliding
                and Input.UserInputType
                == Enum.UserInputType.MouseMovement then

                SetFromX(
                    Input.Position.X
                )
            end
        end
    )

    Connect(
        UserInputService.InputEnded,

        function(Input)

            if Input.UserInputType
                == Enum.UserInputType.MouseButton1 then

                Sliding = false
            end
        end
    )

    Refresh()
end

local function AddColorEditor(
    Page,
    Name,
    Setting
)

    AddSection(
        Page,
        Name
    )

    AddDropdown(
        Page,

        "Color Mode",

        {
            "Solid",
            "Gradient",
        },

        function()
            return Setting.Mode
        end,

        function(Value)
            Setting.Mode = Value
        end
    )

    local PreviewRow =
        NewRow(
            Page,
            40
        )

    NewLabel(
        PreviewRow,
        "Preview"
    )

    local Preview =
        Instance.new("Frame")

    Preview.Size =
        UDim2.fromOffset(
            150,
            24
        )

    Preview.AnchorPoint =
        Vector2.new(
            1,
            0.5
        )

    Preview.Position =
        UDim2.new(
            1,
            -7,
            0.5,
            0
        )

    Preview.BorderSizePixel = 0

    Preview.Parent =
        PreviewRow

    local PreviewGradient =
        Instance.new("UIGradient")

    PreviewGradient.Parent =
        Preview

    local Picker =
        NewRow(
            Page,
            190
        )

    local Target =
        "Solid"

    local TargetButton =
        Instance.new("TextButton")

    TargetButton.Size =
        UDim2.fromOffset(
            190,
            24
        )

    TargetButton.Position =
        UDim2.fromOffset(
            10,
            10
        )

    TargetButton.BackgroundColor3 =
        Color3.fromRGB(
            42,
            42,
            50
        )

    TargetButton.BorderSizePixel = 0

    TargetButton.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    TargetButton.TextSize = 11

    TargetButton.Font =
        Enum.Font.Gotham

    TargetButton.Parent =
        Picker

    local SV =
        Instance.new("ImageButton")

    SV.Position =
        UDim2.fromOffset(
            10,
            44
        )

    SV.Size =
        UDim2.new(
            1,
            -55,
            0,
            130
        )

    SV.BorderSizePixel = 0

    SV.AutoButtonColor = false

    SV.Parent =
        Picker

    local White =
        Instance.new("Frame")

    White.Size =
        UDim2.fromScale(
            1,
            1
        )

    White.BackgroundColor3 =
        Color3.new(
            1,
            1,
            1
        )

    White.BorderSizePixel = 0

    White.Parent =
        SV

    local WhiteGradient =
        Instance.new("UIGradient")

    WhiteGradient.Transparency =
        NumberSequence.new({

            NumberSequenceKeypoint.new(
                0,
                0
            ),

            NumberSequenceKeypoint.new(
                1,
                1
            ),
        })

    WhiteGradient.Parent =
        White

    local Black =
        Instance.new("Frame")

    Black.Size =
        UDim2.fromScale(
            1,
            1
        )

    Black.BackgroundColor3 =
        Color3.new(
            0,
            0,
            0
        )

    Black.BorderSizePixel = 0

    Black.Parent =
        SV

    local BlackGradient =
        Instance.new("UIGradient")

    BlackGradient.Rotation =
        90

    BlackGradient.Transparency =
        NumberSequence.new({

            NumberSequenceKeypoint.new(
                0,
                1
            ),

            NumberSequenceKeypoint.new(
                1,
                0
            ),
        })

    BlackGradient.Parent =
        Black

    local Hue =
        Instance.new("ImageButton")

    Hue.Position =
        UDim2.new(
            1,
            -35,
            0,
            44
        )

    Hue.Size =
        UDim2.fromOffset(
            22,
            130
        )

    Hue.BorderSizePixel = 0

    Hue.AutoButtonColor = false

    Hue.Parent =
        Picker

    local HueGradient =
        Instance.new("UIGradient")

    HueGradient.Rotation =
        90

    HueGradient.Color =
        ColorSequence.new({

            ColorSequenceKeypoint.new(
                0,
                Color3.fromHSV(
                    0,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                0.166,
                Color3.fromHSV(
                    0.166,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                0.333,
                Color3.fromHSV(
                    0.333,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                0.5,
                Color3.fromHSV(
                    0.5,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                0.666,
                Color3.fromHSV(
                    0.666,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                0.833,
                Color3.fromHSV(
                    0.833,
                    1,
                    1
                )
            ),

            ColorSequenceKeypoint.new(
                1,
                Color3.fromHSV(
                    1,
                    1,
                    1
                )
            ),
        })

    HueGradient.Parent =
        Hue

    local H = 0
    local S = 1
    local V = 1

    local HueDragging = false
    local SVDragging = false

    local function GetTargetColor()

        if Target == "Solid" then
            return Setting.Solid

        elseif Target == "From" then
            return Setting.From
        end

        return Setting.To
    end

    local function SetTargetColor(
        Color
    )

        if Target == "Solid" then

            Setting.Solid =
                Color

        elseif Target == "From" then

            Setting.From =
                Color

        else

            Setting.To =
                Color
        end
    end

    local function Refresh()

        TargetButton.Text =
            "Editing "
            .. Target
            .. "  •  "
            .. RGBText(
                GetTargetColor()
            )

        if Setting.Mode == "Gradient" then

            PreviewGradient.Enabled =
                true

            Preview.BackgroundColor3 =
                Color3.new(
                    1,
                    1,
                    1
                )

            PreviewGradient.Color =
                ColorSequence.new(
                    Setting.From,
                    Setting.To
                )

        else

            PreviewGradient.Enabled =
                false

            Preview.BackgroundColor3 =
                Setting.Solid
        end
    end

    local function LoadTarget()

        H, S, V =
            GetTargetColor():
            ToHSV()

        SV.BackgroundColor3 =
            Color3.fromHSV(
                H,
                1,
                1
            )

        Refresh()
    end

    local function Apply()

        SV.BackgroundColor3 =
            Color3.fromHSV(
                H,
                1,
                1
            )

        SetTargetColor(
            Color3.fromHSV(
                H,
                S,
                V
            )
        )

        Refresh()
    end

    Connect(
        TargetButton.MouseButton1Click,

        function()

            if Target == "Solid" then

                Target = "From"

            elseif Target == "From" then

                Target = "To"

            else

                Target = "Solid"
            end

            LoadTarget()
        end
    )

    local function SetHue(
        MouseY
    )

        H =
            Clamp(
                (
                    MouseY
                    - Hue.AbsolutePosition.Y
                )
                / Hue.AbsoluteSize.Y,

                0,
                1
            )

        Apply()
    end

    local function SetSV(
        Position
    )

        S =
            Clamp(
                (
                    Position.X
                    - SV.AbsolutePosition.X
                )
                / SV.AbsoluteSize.X,

                0,
                1
            )

        V =
            1
            - Clamp(
                (
                    Position.Y
                    - SV.AbsolutePosition.Y
                )
                / SV.AbsoluteSize.Y,

                0,
                1
            )

        Apply()
    end

    Connect(
        Hue.InputBegan,

        function(Input)

            if Input.UserInputType
                == Enum.UserInputType.MouseButton1 then

                HueDragging = true

                SetHue(
                    Input.Position.Y
                )
            end
        end
    )

    Connect(
        SV.InputBegan,

        function(Input)

            if Input.UserInputType
                == Enum.UserInputType.MouseButton1 then

                SVDragging = true

                SetSV(
                    Input.Position
                )
            end
        end
    )

    Connect(
        UserInputService.InputChanged,

        function(Input)

            if Input.UserInputType
                ~= Enum.UserInputType.MouseMovement then

                return
            end

            if HueDragging then

                SetHue(
                    Input.Position.Y
                )
            end

            if SVDragging then

                SetSV(
                    Input.Position
                )
            end
        end
    )

    Connect(
        UserInputService.InputEnded,

        function(Input)

            if Input.UserInputType
                == Enum.UserInputType.MouseButton1 then

                HueDragging = false

                SVDragging = false
            end
        end
    )

    LoadTarget()

    Connect(
        RunService.Heartbeat,

        Refresh
    )
end

local function AddSolidColorEditor(
    Page,
    Name,
    Getter,
    Setter
)

    local Proxy = {

        Mode = "Solid",

        Solid = Getter(),

        From = Getter(),

        To = Getter(),
    }

    AddColorEditor(
        Page,
        Name,
        Proxy
    )

    Connect(
        RunService.Heartbeat,

        function()

            Setter(
                Proxy.Solid
            )
        end
    )
end

local function AddPlacementControls(
    Page,
    Name,
    Placement,
    AllowCenter
)

    AddSection(
        Page,
        Name .. " Placement"
    )

    local Sides = {

        "Top",
        "Bottom",
        "Left",
        "Right",
    }

    if AllowCenter then

        table.insert(
            Sides,
            "Center"
        )
    end

    AddDropdown(
        Page,

        "Side",

        Sides,

        function()
            return Placement.Side
        end,

        function(Value)
            Placement.Side = Value
        end
    )

    AddSlider(
        Page,

        "X Offset",

        -100,
        100,

        function()
            return Placement.X
        end,

        function(Value)
            Placement.X = Value
        end,

        0
    )

    AddSlider(
        Page,

        "Y Offset",

        -100,
        100,

        function()
            return Placement.Y
        end,

        function(Value)
            Placement.Y = Value
        end,

        0
    )
end

local PageNames = {

    "General",
    "Chams",
    "Boxes",
    "Name",
    "Visibility",
    "Distance",
    "Holding",
    "Health",
}

for _, Name in ipairs(
    PageNames
) do

    CreatePage(
        Name
    )
end

local function AddTab(
    Name
)

    local Button =
        Instance.new("TextButton")

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            32
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            30,
            30,
            37
        )

    Button.BorderSizePixel = 0

    Button.Text =
        Name

    Button.TextColor3 =
        Color3.fromRGB(
            215,
            215,
            220
        )

    Button.TextSize = 12

    Button.Font =
        Enum.Font.GothamSemibold

    Button.Parent =
        Sidebar

    TabButtons[Name] =
        Button

    Connect(
        Button.MouseButton1Click,

        function()
            ShowPage(Name)
        end
    )
end

for _, Name in ipairs(
    PageNames
) do

    AddTab(
        Name
    )
end

local GeneralPage =
    Pages.General

local ChamsPage =
    Pages.Chams

local BoxPage =
    Pages.Boxes

local NamePage =
    Pages.Name

local VisibilityPage =
    Pages.Visibility

local DistancePage =
    Pages.Distance

local HoldingPage =
    Pages.Holding

local HealthPage =
    Pages.Health

AddSection(
    GeneralPage,
    "Master"
)

AddToggle(
    GeneralPage,

    "ESP Enabled",

    function()
        return CONFIG.ESP.Enabled
    end,

    function(Value)
        CONFIG.ESP.Enabled = Value
    end
)

AddToggle(
    GeneralPage,

    "Chams Enabled",

    function()
        return CONFIG.Chams.Enabled
    end,

    function(Value)
        CONFIG.Chams.Enabled = Value
    end
)

AddToggle(
    ChamsPage,

    "Enabled",

    function()
        return CONFIG.Chams.Enabled
    end,

    function(Value)
        CONFIG.Chams.Enabled = Value
    end
)

AddSlider(
    ChamsPage,

    "Transparency",

    0,
    1,

    function()
        return CONFIG.Chams.MainTransparency
    end,

    function(Value)
        CONFIG.Chams.MainTransparency = Value
    end,

    2
)

AddSlider(
    ChamsPage,

    "Main Scale",

    0.95,
    1.15,

    function()
        return CONFIG.Chams.MainScale
    end,

    function(Value)
        CONFIG.Chams.MainScale = Value
    end,

    3
)

AddColorEditor(
    ChamsPage,
    "Cham Color",
    CONFIG.Chams.Color
)

AddSection(
    ChamsPage,
    "Glow"
)

AddToggle(
    ChamsPage,

    "Glow Enabled",

    function()
        return CONFIG.Chams.Glow.Enabled
    end,

    function(Value)
        CONFIG.Chams.Glow.Enabled = Value
    end
)

AddColorEditor(
    ChamsPage,
    "Glow Color",
    CONFIG.Chams.Glow.Color
)

AddSlider(
    ChamsPage,

    "Inner Scale",

    1,
    1.2,

    function()
        return CONFIG.Chams.Glow.Scale1
    end,

    function(Value)
        CONFIG.Chams.Glow.Scale1 = Value
    end,

    3
)

AddSlider(
    ChamsPage,

    "Middle Scale",

    1,
    1.3,

    function()
        return CONFIG.Chams.Glow.Scale2
    end,

    function(Value)
        CONFIG.Chams.Glow.Scale2 = Value
    end,

    3
)

AddSlider(
    ChamsPage,

    "Outer Scale",

    1,
    1.4,

    function()
        return CONFIG.Chams.Glow.Scale3
    end,

    function(Value)
        CONFIG.Chams.Glow.Scale3 = Value
    end,

    3
)

AddToggle(
    BoxPage,

    "Enabled",

    function()
        return CONFIG.ESP.Box.Enabled
    end,

    function(Value)
        CONFIG.ESP.Box.Enabled = Value
    end
)

AddDropdown(
    BoxPage,

    "Style",

    {
        "Full",
        "Corner",
    },

    function()
        return CONFIG.ESP.Box.Type
    end,

    function(Value)
        CONFIG.ESP.Box.Type = Value
    end
)

AddSlider(
    BoxPage,

    "Thickness",

    1,
    5,

    function()
        return CONFIG.ESP.Box.Thickness
    end,

    function(Value)
        CONFIG.ESP.Box.Thickness = Value
    end,

    1
)

AddSlider(
    BoxPage,

    "Corner Width",

    0.1,
    0.5,

    function()
        return CONFIG.ESP.Box.CornerWidth
    end,

    function(Value)
        CONFIG.ESP.Box.CornerWidth = Value
    end,

    2
)

AddSlider(
    BoxPage,

    "Corner Height",

    0.1,
    0.5,

    function()
        return CONFIG.ESP.Box.CornerHeight
    end,

    function(Value)
        CONFIG.ESP.Box.CornerHeight = Value
    end,

    2
)

AddColorEditor(
    BoxPage,
    "Box Color",
    CONFIG.ESP.Box.Color
)

AddSection(
    BoxPage,
    "Outline"
)

AddToggle(
    BoxPage,

    "Outline Enabled",

    function()
        return CONFIG.ESP.Box.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Box.Outline.Enabled = Value
    end
)

AddSlider(
    BoxPage,

    "Outline Thickness",

    0,
    6,

    function()
        return CONFIG.ESP.Box.Outline.Thickness
    end,

    function(Value)
        CONFIG.ESP.Box.Outline.Thickness = Value
    end,

    1
)

AddSolidColorEditor(
    BoxPage,

    "Outline Color",

    function()
        return CONFIG.ESP.Box.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Box.Outline.Color = Value
    end
)

AddToggle(
    NamePage,

    "Enabled",

    function()
        return CONFIG.ESP.Name.Enabled
    end,

    function(Value)
        CONFIG.ESP.Name.Enabled = Value
    end
)

AddSlider(
    NamePage,

    "Text Size",

    8,
    30,

    function()
        return CONFIG.ESP.Name.Size
    end,

    function(Value)
        CONFIG.ESP.Name.Size = Value
    end,

    0
)

AddColorEditor(
    NamePage,
    "Name Color",
    CONFIG.ESP.Name.Color
)

AddToggle(
    NamePage,

    "Outline",

    function()
        return CONFIG.ESP.Name.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Name.Outline.Enabled = Value
    end
)

AddSolidColorEditor(
    NamePage,

    "Outline Color",

    function()
        return CONFIG.ESP.Name.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Name.Outline.Color = Value
    end
)

AddPlacementControls(
    NamePage,
    "Name",
    CONFIG.ESP.Name.Placement,
    true
)

AddToggle(
    VisibilityPage,

    "Enabled",

    function()
        return CONFIG.ESP.Visibility.Enabled
    end,

    function(Value)
        CONFIG.ESP.Visibility.Enabled = Value
    end
)

AddSlider(
    VisibilityPage,

    "Text Size",

    8,
    30,

    function()
        return CONFIG.ESP.Visibility.Size
    end,

    function(Value)
        CONFIG.ESP.Visibility.Size = Value
    end,

    0
)

AddColorEditor(
    VisibilityPage,
    "Visible Color",
    CONFIG.ESP.Visibility.VisibleColor
)

AddColorEditor(
    VisibilityPage,
    "Hidden Color",
    CONFIG.ESP.Visibility.HiddenColor
)

AddToggle(
    VisibilityPage,

    "Outline",

    function()
        return CONFIG.ESP.Visibility.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Visibility.Outline.Enabled = Value
    end
)

AddSolidColorEditor(
    VisibilityPage,

    "Outline Color",

    function()
        return CONFIG.ESP.Visibility.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Visibility.Outline.Color = Value
    end
)

AddPlacementControls(
    VisibilityPage,
    "Visibility",
    CONFIG.ESP.Visibility.Placement,
    true
)

AddToggle(
    DistancePage,

    "Enabled",

    function()
        return CONFIG.ESP.Distance.Enabled
    end,

    function(Value)
        CONFIG.ESP.Distance.Enabled = Value
    end
)

AddSlider(
    DistancePage,

    "Text Size",

    8,
    30,

    function()
        return CONFIG.ESP.Distance.Size
    end,

    function(Value)
        CONFIG.ESP.Distance.Size = Value
    end,

    0
)

AddDropdown(
    DistancePage,

    "Unit",

    {
        "Studs",
        "Meters",
    },

    function()
        return CONFIG.ESP.Distance.Unit
    end,

    function(Value)
        CONFIG.ESP.Distance.Unit = Value
    end
)

AddDropdown(
    DistancePage,

    "Decimals",

    {
        0,
        1,
        2,
    },

    function()
        return CONFIG.ESP.Distance.DecimalPlaces
    end,

    function(Value)
        CONFIG.ESP.Distance.DecimalPlaces = Value
    end
)

AddColorEditor(
    DistancePage,
    "Distance Color",
    CONFIG.ESP.Distance.Color
)

AddToggle(
    DistancePage,

    "Outline",

    function()
        return CONFIG.ESP.Distance.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Distance.Outline.Enabled = Value
    end
)

AddSolidColorEditor(
    DistancePage,

    "Outline Color",

    function()
        return CONFIG.ESP.Distance.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Distance.Outline.Color = Value
    end
)

AddPlacementControls(
    DistancePage,
    "Distance",
    CONFIG.ESP.Distance.Placement,
    true
)

AddToggle(
    HoldingPage,

    "Enabled",

    function()
        return CONFIG.ESP.Holding.Enabled
    end,

    function(Value)
        CONFIG.ESP.Holding.Enabled = Value
    end
)

AddSlider(
    HoldingPage,

    "Text Size",

    8,
    30,

    function()
        return CONFIG.ESP.Holding.Size
    end,

    function(Value)
        CONFIG.ESP.Holding.Size = Value
    end,

    0
)

AddColorEditor(
    HoldingPage,
    "Holding Color",
    CONFIG.ESP.Holding.Color
)

AddToggle(
    HoldingPage,

    "Outline",

    function()
        return CONFIG.ESP.Holding.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Holding.Outline.Enabled = Value
    end
)

AddSolidColorEditor(
    HoldingPage,

    "Outline Color",

    function()
        return CONFIG.ESP.Holding.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Holding.Outline.Color = Value
    end
)

AddPlacementControls(
    HoldingPage,
    "Holding",
    CONFIG.ESP.Holding.Placement,
    true
)

AddToggle(
    HealthPage,

    "Enabled",

    function()
        return CONFIG.ESP.Health.Enabled
    end,

    function(Value)
        CONFIG.ESP.Health.Enabled = Value
    end
)

AddSlider(
    HealthPage,

    "Width",

    1,
    8,

    function()
        return CONFIG.ESP.Health.Width
    end,

    function(Value)
        CONFIG.ESP.Health.Width = Value
    end,

    1
)

AddSlider(
    HealthPage,

    "Distance From Box",

    1,
    25,

    function()
        return CONFIG.ESP.Health.Offset
    end,

    function(Value)
        CONFIG.ESP.Health.Offset = Value
    end,

    0
)

AddColorEditor(
    HealthPage,
    "Health Color",
    CONFIG.ESP.Health.Color
)

AddToggle(
    HealthPage,

    "Background",

    function()
        return CONFIG.ESP.Health.Background.Enabled
    end,

    function(Value)
        CONFIG.ESP.Health.Background.Enabled = Value
    end
)

AddSlider(
    HealthPage,

    "Background Width",

    1,
    10,

    function()
        return CONFIG.ESP.Health.Background.Width
    end,

    function(Value)
        CONFIG.ESP.Health.Background.Width = Value
    end,

    1
)

AddSolidColorEditor(
    HealthPage,

    "Background Color",

    function()
        return CONFIG.ESP.Health.Background.Color
    end,

    function(Value)
        CONFIG.ESP.Health.Background.Color = Value
    end
)

AddToggle(
    HealthPage,

    "Outline",

    function()
        return CONFIG.ESP.Health.Outline.Enabled
    end,

    function(Value)
        CONFIG.ESP.Health.Outline.Enabled = Value
    end
)

AddSlider(
    HealthPage,

    "Outline Thickness",

    0,
    6,

    function()
        return CONFIG.ESP.Health.Outline.Thickness
    end,

    function(Value)
        CONFIG.ESP.Health.Outline.Thickness = Value
    end,

    1
)

AddSolidColorEditor(
    HealthPage,

    "Outline Color",

    function()
        return CONFIG.ESP.Health.Outline.Color
    end,

    function(Value)
        CONFIG.ESP.Health.Outline.Color = Value
    end
)

AddPlacementControls(
    HealthPage,
    "Health Bar",
    CONFIG.ESP.Health.Placement,
    false
)

ShowPage(
    "General"
)

Connect(
    UserInputService.InputBegan,

    function(
        Input,
        Processed
    )

        if Processed then
            return
        end

        if Input.KeyCode
            == Enum.KeyCode.RightShift then

            Window.Visible =
                not Window.Visible
        end
    end
)

for _, Player in ipairs(
    Players:GetPlayers()
) do

    TrackPlayer(
        Player
    )
end

Connect(
    Players.PlayerAdded,
    TrackPlayer
)

Connect(
    Players.PlayerRemoving,

    function(Player)

        if CharacterConnections[Player] then

            pcall(
                function()

                    CharacterConnections[Player]:
                    Disconnect()
                end
            )

            CharacterConnections[Player] =
                nil
        end

        RemovePlayer(
            Player
        )
    end
)

Connect(
    RunService.RenderStepped,

    function()

        if Destroyed then
            return
        end

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return
        end

        ChamGui.Enabled =
            CONFIG.Chams.Enabled

        local Layers =
            GetChamLayers()

        for _, Layer in ipairs(
            Layers
        ) do

            Layer.Data.Camera.CFrame =
                Camera.CFrame

            Layer.Data.Camera.FieldOfView =
                Camera.FieldOfView
        end

        for Player, Data in pairs(
            Tracked
        ) do

            local Character =
                Player.Character

            local ESP =
                Data.ESP

            if not Character
                or not Character.Parent then

                HideESP(
                    ESP
                )

                continue
            end

            if Character
                ~= Data.Character then

                TrackCharacter(
                    Player,
                    Character
                )

                continue
            end

            for _, Object in ipairs(
                Character:GetChildren()
            ) do

                if IsBodyPart(Object)
                    and not Data.Parts[Object] then

                    Data.Parts[Object] =
                        CreateCham(
                            Object
                        )
                end
            end

            if CONFIG.Chams.Enabled then

                for RealPart, Cham in pairs(
                    Data.Parts
                ) do

                    if not RealPart.Parent then

                        DestroyCham(
                            Cham
                        )

                        Data.Parts[RealPart] =
                            nil

                        continue
                    end

                    local GradientT =
                        GetChamGradientT(
                            Character,
                            RealPart
                        )

                    for Index, Entry in ipairs(
                        Cham
                    ) do

                        local Part =
                            Entry.Part

                        local Layer =
                            Layers[Index]

                        Part.CFrame =
                            RealPart.CFrame

                        Part.Size =
                            RealPart.Size
                            * Layer.Scale

                        if Layer.Glow then

                            Part.Color =
                                ResolveColor(
                                    CONFIG.Chams.Glow.Color,
                                    GradientT
                                )

                            Part.Transparency =
                                Layer.Transparency

                        else

                            Part.Color =
                                ResolveColor(
                                    CONFIG.Chams.Color,
                                    GradientT
                                )

                            Part.Transparency =
                                CONFIG.Chams.MainTransparency
                        end
                    end
                end
            end

            if not CONFIG.ESP.Enabled then

                HideESP(
                    ESP
                )

                continue
            end

            local Bounds =
                GetScreenBounds(
                    Character,
                    Camera
                )

            if not Bounds
                or Bounds.Width <= 0
                or Bounds.Height <= 0 then

                HideESP(
                    ESP
                )

                continue
            end

            HideBoxes(
                ESP
            )

            if CONFIG.ESP.Box.Enabled then

                if CONFIG.ESP.Box.Type
                    == "Full" then

                    DrawFullBox(
                        ESP,
                        Bounds
                    )

                else

                    DrawCornerBox(
                        ESP,
                        Bounds
                    )
                end
            end

            if CONFIG.ESP.Name.Enabled then

                ConfigureText(

                    ESP.Name,

                    Player.DisplayName,

                    CONFIG.ESP.Name.Size,

                    CONFIG.ESP.Name.Color,

                    CONFIG.ESP.Name.Outline,

                    Bounds
                )

                ApplyTextPlacement(
                    ESP.Name,
                    Bounds,
                    CONFIG.ESP.Name.Placement
                )

            else

                ESP.Name.Visible =
                    false
            end

            if CONFIG.ESP.Visibility.Enabled then

                local Visible =
                    IsVisible(
                        Character,
                        Camera
                    )

                ConfigureText(

                    ESP.Visibility,

                    Visible
                    and CONFIG.ESP.Visibility.VisibleText
                    or CONFIG.ESP.Visibility.HiddenText,

                    CONFIG.ESP.Visibility.Size,

                    Visible
                    and CONFIG.ESP.Visibility.VisibleColor
                    or CONFIG.ESP.Visibility.HiddenColor,

                    CONFIG.ESP.Visibility.Outline,

                    Bounds
                )

                ApplyTextPlacement(
                    ESP.Visibility,
                    Bounds,
                    CONFIG.ESP.Visibility.Placement
                )

            else

                ESP.Visibility.Visible =
                    false
            end

            DrawDistance(
                ESP,
                Character,
                Bounds
            )

            DrawHolding(
                ESP,
                Character,
                Bounds
            )

            local Humanoid =
                Character:
                FindFirstChildOfClass(
                    "Humanoid"
                )

            DrawHealth(
                ESP,
                Bounds,
                Humanoid
            )
        end
    end
)

ENV.__ESP_LIBRARY_CLEANUP =
    function()

        if Destroyed then
            return
        end

        Destroyed = true

        for _, Connection in ipairs(
            Connections
        ) do

            pcall(
                function()
                    Connection:Disconnect()
                end
            )
        end

        table.clear(
            Connections
        )

        for Player, Connection in pairs(
            CharacterConnections
        ) do

            pcall(
                function()
                    Connection:Disconnect()
                end
            )

            CharacterConnections[Player] =
                nil
        end

        for Player, Data in pairs(
            Tracked
        ) do

            for _, Cham in pairs(
                Data.Parts
            ) do

                DestroyCham(
                    Cham
                )
            end

            Tracked[Player] =
                nil
        end

        for _, Object in ipairs(
            Drawings
        ) do

            pcall(
                function()
                    Object:Remove()
                end
            )
        end

        table.clear(
            Drawings
        )

        pcall(
            function()
                ChamGui:Destroy()
            end
        )

        pcall(
            function()
                SettingsGui:Destroy()
            end
        )
    end

local Library = {}
Library.Config = CONFIG
Library.Version = "1.0.0"

function Library:SetEnabled(Value)
    CONFIG.ESP.Enabled = Value == true
end

function Library:SetChamsEnabled(Value)
    CONFIG.Chams.Enabled = Value == true
end

function Library:SetUIVisible(Value)
    Window.Visible = Value == true
end

function Library:ToggleUI()
    Window.Visible = not Window.Visible
    return Window.Visible
end

function Library:GetUIVisible()
    return Window.Visible
end

function Library:GetConfig()
    return CONFIG
end

function Library:GetPlayerData(Player)
    return Tracked[Player]
end

function Library:SetTextSize(Category, Size)
    local Entry = CONFIG.ESP[Category]
    if Entry and Entry.Size ~= nil then
        Entry.Size = math.max(1, math.floor((tonumber(Size) or Entry.Size) + 0.5))
        return true
    end
    return false
end

function Library:SetPlacement(Category, Side, X, Y)
    local Entry = CONFIG.ESP[Category]
    if not Entry or not Entry.Placement then
        return false
    end
    if Side ~= nil then Entry.Placement.Side = Side end
    if X ~= nil then Entry.Placement.X = tonumber(X) or Entry.Placement.X end
    if Y ~= nil then Entry.Placement.Y = tonumber(Y) or Entry.Placement.Y end
    return true
end

function Library:SetColor(Category, Mode, Solid, From, To)
    local Entry = CONFIG.ESP[Category]
    local Setting = Entry and Entry.Color
    if not Setting then
        return false
    end
    if Mode == "Solid" or Mode == "Gradient" then Setting.Mode = Mode end
    if typeof(Solid) == "Color3" then Setting.Solid = Solid end
    if typeof(From) == "Color3" then Setting.From = From end
    if typeof(To) == "Color3" then Setting.To = To end
    return true
end

function Library:Unload()
    if ENV.__ESP_LIBRARY_CLEANUP then
        ENV.__ESP_LIBRARY_CLEANUP()
    end
end

return Library
