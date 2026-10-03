

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
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
local ESPActive = false
local TrackingInitialized = false

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

        Enabled = false,

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

            Enabled = false,

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

    DistanceLimit = {

        Enabled = false,

        MaxDistance = 500,
    },

    ESP = {

        Enabled = false,

        Box = {

            Enabled = true,

            Type = "Full",

            Thickness = 1.5,

            GradientSegments = 4,

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

            Enabled = false,

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

            Enabled = false,

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

            Enabled = false,

            Width = 2,

            Offset = 6,

            Segments = 4,

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

local ChamGui = nil
local Glow3 = nil
local Glow2 = nil
local Glow1 = nil
local Main = nil

local function CreateChamGui()
    if ChamGui and ChamGui.Parent then
        return
    end

    ChamGui = Instance.new("ScreenGui")
    ChamGui.Name = "ViewportESP"
    ChamGui.IgnoreGuiInset = true
    ChamGui.ResetOnSpawn = false
    ChamGui.DisplayOrder = 999998
    ChamGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ChamGui.Parent = CoreGui
end

local function CreateViewport(Name, ZIndex)
    CreateChamGui()

    local Viewport = Instance.new("ViewportFrame")
    Viewport.Name = Name
    Viewport.Size = UDim2.fromScale(1, 1)
    Viewport.BackgroundTransparency = 1
    Viewport.BorderSizePixel = 0
    Viewport.Ambient = Color3.new(1, 1, 1)
    Viewport.LightColor = Color3.new(1, 1, 1)
    Viewport.ZIndex = ZIndex
    Viewport.Parent = ChamGui

    local Camera = Instance.new("Camera")
    Camera.Parent = Viewport
    Viewport.CurrentCamera = Camera

    local World = Instance.new("WorldModel")
    World.Parent = Viewport

    return {
        Viewport = Viewport,
        Camera = Camera,
        World = World,
    }
end

local function EnsureChamLayers()
    if not Main then
        Main = CreateViewport("Main", 4)
    end

    if CONFIG.Chams.Glow.Enabled then
        if not Glow1 then Glow1 = CreateViewport("Glow1", 3) end
        if not Glow2 then Glow2 = CreateViewport("Glow2", 2) end
        if not Glow3 then Glow3 = CreateViewport("Glow3", 1) end
    end
end

local function DestroyChamLayers()
    if ChamGui then
        pcall(function() ChamGui:Destroy() end)
    end
    ChamGui = nil
    Glow3 = nil
    Glow2 = nil
    Glow1 = nil
    Main = nil
end

local function GetChamLayers()
    EnsureChamLayers()

    if not CONFIG.Chams.Glow.Enabled then
        return {
            {
                Data = Main,
                Scale = CONFIG.Chams.MainScale,
                Transparency = CONFIG.Chams.MainTransparency,
                Glow = false,
            },
        }
    end

    return {
        {
            Data = Glow3,
            Scale = CONFIG.Chams.Glow.Scale3,
            Transparency = CONFIG.Chams.Glow.Transparency3,
            Glow = true,
        },
        {
            Data = Glow2,
            Scale = CONFIG.Chams.Glow.Scale2,
            Transparency = CONFIG.Chams.Glow.Transparency2,
            Glow = true,
        },
        {
            Data = Glow1,
            Scale = CONFIG.Chams.Glow.Scale1,
            Transparency = CONFIG.Chams.Glow.Transparency1,
            Glow = true,
        },
        {
            Data = Main,
            Scale = CONFIG.Chams.MainScale,
            Transparency = CONFIG.Chams.MainTransparency,
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
local DeathConnections = {}

local function DisconnectCharacterConnections(
    Player
)

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

    if DeathConnections[Player] then

        pcall(
            function()
                DeathConnections[Player]:
                    Disconnect()
            end
        )

        DeathConnections[Player] =
            nil
    end
end

local function RemoveCharacter(
    Player
)

    if DeathConnections[Player] then

        pcall(
            function()
                DeathConnections[Player]:
                    Disconnect()
            end
        )

        DeathConnections[Player] =
            nil
    end

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

local function RemovePlayer(
    Player
)

    -- Player is actually leaving, so remove both
    -- the current character and the Player connections.
    RemoveCharacter(
        Player
    )

    DisconnectCharacterConnections(
        Player
    )
end

local function TrackCharacter(
    Player,
    Character
)

    if Player == LocalPlayer then
        return
    end

    -- Remove only the old character. Keep CharacterAdded
    -- connected so ESP/chams return after respawn.
    RemoveCharacter(
        Player
    )

    if Destroyed
        or not Character
        or not Character.Parent then

        return
    end

    local Data = {

        Character =
            Character,

        Parts = {},

        ESP = nil,

        NextPartScan = 0,
    }

    Tracked[Player] =
        Data

    -- Chams and Drawing objects are allocated lazily by the renderer.
    -- This avoids a large synchronous allocation burst when the library loads.
    Data.NextPartScan = 0

    -- Remove ESP/chams immediately when this character dies,
    -- while keeping CharacterAdded alive for the next respawn.
    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if Humanoid then

        DeathConnections[Player] =
            Connect(
                Humanoid.Died,

                function()

                    local Current =
                        Tracked[Player]

                    -- An old character must never remove
                    -- ESP belonging to a newer character.
                    if Current
                        and Current.Character == Character then

                        RemoveCharacter(
                            Player
                        )
                    end
                end
            )
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

                if Destroyed then
                    return
                end

                Character:WaitForChild(
                    "HumanoidRootPart",
                    10
                )

                task.wait(0.1)

                if not Destroyed
                    and Player.Parent == Players
                    and Character.Parent then

                    TrackCharacter(
                        Player,
                        Character
                    )
                end
            end
        )
end

local function IsWithinDistance(Character)

    local Setting = CONFIG.DistanceLimit

    if not Setting.Enabled then
        return true
    end

    local LocalCharacter = LocalPlayer.Character
    local LocalRoot = LocalCharacter
        and LocalCharacter:FindFirstChild("HumanoidRootPart")

    local TargetRoot = Character
        and Character:FindFirstChild("HumanoidRootPart")

    if not LocalRoot or not TargetRoot then
        return false
    end

    local MaxDistance = tonumber(Setting.MaxDistance) or 0

    if MaxDistance <= 0 then
        return false
    end

    return (TargetRoot.Position - LocalRoot.Position).Magnitude <= MaxDistance
end

local function GetScreenBounds(
    Character,
    Camera
)
    if not Character or not Character.Parent then
        return nil
    end

    -- Project the eight corners of the model bounding box instead of every
    -- corner of every limb. This reduces a typical R15 character from roughly
    -- 120+ WorldToViewportPoint calls to 8.
    local CF, Size = Character:GetBoundingBox()
    local Half = Size * 0.5

    local MinX, MinY = math.huge, math.huge
    local MaxX, MaxY = -math.huge, -math.huge
    local Found = false

    for X = -1, 1, 2 do
        for Y = -1, 1, 2 do
            for Z = -1, 1, 2 do
                local WorldCorner = CF:PointToWorldSpace(
                    Vector3.new(Half.X * X, Half.Y * Y, Half.Z * Z)
                )
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

    if not Found then
        return nil
    end

    local Width = MaxX - MinX
    local Height = MaxY - MinY
    if Width <= 0 or Height <= 0 then
        return nil
    end

    return {
        Left = MinX,
        Right = MaxX,
        Top = MinY,
        Bottom = MaxY,
        Width = Width,
        Height = Height,
        CenterX = (MinX + MaxX) * 0.5,
        CenterY = (MinY + MaxY) * 0.5,
    }
end

local VisibilityParams = RaycastParams.new()
VisibilityParams.FilterType = Enum.RaycastFilterType.Exclude
VisibilityParams.IgnoreWater = true

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

    local Parameters = VisibilityParams

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

local function EnsureTracking()
    if Destroyed then
        return
    end

    if not ESPActive and not CONFIG.Chams.Enabled then
        return
    end

    if TrackingInitialized then
        return
    end

    TrackingInitialized = true

    -- Only connect players that are not already tracked. This matters after
    -- both features are disabled and a new player joins while tracking is off.
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and not CharacterConnections[Player] then
            TrackPlayer(Player)
        end
    end
end

Connect(
    Players.PlayerAdded,
    function(Player)
        if ESPActive or CONFIG.Chams.Enabled then
            TrackPlayer(Player)
        end
    end
)

Connect(
    Players.PlayerRemoving,

    function(Player)

        RemovePlayer(
            Player
        )
    end
)

local UPDATE_INTERVAL = 1 / 30
local lastUpdate = 0

Connect(
    RunService.RenderStepped,

    function()
        if Destroyed then
            return
        end

        local Now = os.clock()
        if Now - lastUpdate < UPDATE_INTERVAL then
            return
        end
        lastUpdate = Now

        local Camera = workspace.CurrentCamera
        if not Camera then
            return
        end

        local ChamsEnabled = CONFIG.Chams.Enabled == true
        local ESPEnabled = ESPActive == true

        if ESPEnabled or ChamsEnabled then
            EnsureTracking()
        end

        if not ChamsEnabled and not ESPEnabled then
            if ChamGui then
                ChamGui.Enabled = false
            end
            return
        end

        local Layers = nil
        if ChamsEnabled then
            EnsureChamLayers()
            Layers = GetChamLayers()
            if ChamGui then
                ChamGui.Enabled = true
                for _, Layer in ipairs(Layers) do
                    if Layer.Data and Layer.Data.Camera then
                        Layer.Data.Camera.CFrame = Camera.CFrame
                        Layer.Data.Camera.FieldOfView = Camera.FieldOfView
                    end
                end
            end
        elseif ChamGui then
            ChamGui.Enabled = false
        end

        -- Spread object allocation over several 30 Hz updates instead of
        -- constructing every player's ESP/chams in one scheduler slice.
        local espCreateBudget = 3
        local chamCreateBudget = 8

        for Player, Data in pairs(Tracked) do
            local Character = Player.Character

            if not Character or not Character.Parent then
                RemoveCharacter(Player)
                continue
            end

            if Character ~= Data.Character then
                TrackCharacter(Player, Character)
                continue
            end

            if not IsWithinDistance(Character) then
                if Data.ESP then
                    HideESP(Data.ESP)
                end

                if ChamsEnabled then
                    for _, Cham in pairs(Data.Parts) do
                        for _, Entry in ipairs(Cham) do
                            if Entry.Part then
                                Entry.Part.Transparency = 1
                            end
                        end
                    end
                end
                continue
            end

            if ESPEnabled and not Data.ESP then
                if espCreateBudget > 0 then
                    Data.ESP = CreateESP()
                    espCreateBudget -= 1
                else
                    continue
                end
            elseif not ESPEnabled and Data.ESP then
                HideESP(Data.ESP)
            end

            if ChamsEnabled then
                if Now >= (Data.NextPartScan or 0) then
                    Data.NextPartScan = Now + 0.5
                    for _, Object in ipairs(Character:GetChildren()) do
                        if IsBodyPart(Object) and not Data.Parts[Object] then
                            if chamCreateBudget <= 0 then
                                break
                            end
                            Data.Parts[Object] = CreateCham(Object)
                            chamCreateBudget -= 1
                        end
                    end
                end

                for RealPart, Cham in pairs(Data.Parts) do
                    if not RealPart.Parent then
                        DestroyCham(Cham)
                        Data.Parts[RealPart] = nil
                        continue
                    end

                    if Layers and #Cham ~= #Layers and chamCreateBudget > 0 then
                        DestroyCham(Cham)
                        Data.Parts[RealPart] = CreateCham(RealPart)
                        Cham = Data.Parts[RealPart]
                        chamCreateBudget -= 1
                    end

                    if Layers and #Cham == #Layers then
                        local GradientT = GetChamGradientT(Character, RealPart)
                        for Index, Entry in ipairs(Cham) do
                            local Part = Entry.Part
                            local Layer = Layers[Index]
                            if Part and Layer then
                                Part.CFrame = RealPart.CFrame
                                Part.Size = RealPart.Size * Layer.Scale

                                if Layer.Glow then
                                    Part.Color = ResolveColor(CONFIG.Chams.Glow.Color, GradientT)
                                    Part.Transparency = Layer.Transparency
                                else
                                    Part.Color = ResolveColor(CONFIG.Chams.Color, GradientT)
                                    Part.Transparency = CONFIG.Chams.MainTransparency
                                end
                            end
                        end
                    end
                end
            end

            if not ESPEnabled or not Data.ESP then
                continue
            end

            local ESP = Data.ESP
            local Bounds = GetScreenBounds(Character, Camera)
            if not Bounds then
                HideESP(ESP)
                continue
            end

            HideBoxes(ESP)
            if CONFIG.ESP.Box.Enabled then
                if CONFIG.ESP.Box.Type == "Full" then
                    DrawFullBox(ESP, Bounds)
                else
                    DrawCornerBox(ESP, Bounds)
                end
            end

            if CONFIG.ESP.Name.Enabled then
                ConfigureText(ESP.Name, Player.DisplayName, CONFIG.ESP.Name.Size, CONFIG.ESP.Name.Color, CONFIG.ESP.Name.Outline, Bounds)
                ApplyTextPlacement(ESP.Name, Bounds, CONFIG.ESP.Name.Placement)
            else
                ESP.Name.Visible = false
            end

            if CONFIG.ESP.Visibility.Enabled then
                local Visible = IsVisible(Character, Camera)
                ConfigureText(
                    ESP.Visibility,
                    Visible and CONFIG.ESP.Visibility.VisibleText or CONFIG.ESP.Visibility.HiddenText,
                    CONFIG.ESP.Visibility.Size,
                    Visible and CONFIG.ESP.Visibility.VisibleColor or CONFIG.ESP.Visibility.HiddenColor,
                    CONFIG.ESP.Visibility.Outline,
                    Bounds
                )
                ApplyTextPlacement(ESP.Visibility, Bounds, CONFIG.ESP.Visibility.Placement)
            else
                ESP.Visibility.Visible = false
            end

            DrawDistance(ESP, Character, Bounds)
            DrawHolding(ESP, Character, Bounds)

            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            DrawHealth(ESP, Bounds, Humanoid)
        end
    end
)

ENV.__ESP_LIBRARY_CLEANUP =
    function()

        if Destroyed then
            return
        end

        Destroyed = true
        ESPActive = false
        TrackingInitialized = false

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

        DestroyChamLayers()

    end

local Library = {}
Library.Config = CONFIG
Library.Version = "1.2.1-performance"

function Library:SetEnabled(Value)
    ESPActive = Value == true
    CONFIG.ESP.Enabled = ESPActive

    if ESPActive then
        EnsureTracking()
        return
    end

    for _, Data in pairs(Tracked) do
        if Data.ESP then
            HideESP(Data.ESP)
        end
    end

    if not CONFIG.Chams.Enabled then
        TrackingInitialized = false
    end
end

function Library:SetChamsEnabled(Value)
    CONFIG.Chams.Enabled = Value == true

    if not CONFIG.Chams.Enabled then
        for _, Data in pairs(Tracked) do
            for _, Cham in pairs(Data.Parts) do
                DestroyCham(Cham)
            end
            table.clear(Data.Parts)
        end
        DestroyChamLayers()
        if not ESPActive then
            TrackingInitialized = false
        end
        return
    end

    EnsureTracking()
    EnsureChamLayers()
    for _, Data in pairs(Tracked) do
        Data.NextPartScan = 0
    end
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
