-- example script by https://github.com/mstudio45/LinoriaLib/blob/main/Example.lua and modified by deivid
-- You can suggest changes with a pull request or something

local repo = "https://raw.githubusercontent.com/tanhoangviet/Obsidian-UI-Modded/main/"
local repoCacheKey = tostring(os.time())
local function RepoAsset(Path)
    return repo .. Path .. "?v=" .. repoCacheKey
end

local Library = loadstring(game:HttpGet(RepoAsset("Library.lua")))()
local ThemeManager = loadstring(game:HttpGet(RepoAsset("addons/ThemeManager.lua")))()
local SaveManager = loadstring(game:HttpGet(RepoAsset("addons/SaveManager.lua")))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false -- Forces AddToggle to AddCheckbox
Library.ShowToggleFrameInKeybinds = true -- Make toggle keybinds work inside the keybinds UI (aka adds a toggle to the UI). Good for mobile users (Default value = true)

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Set Resizable to true if you want to have in-game resizable Window
    -- Set MobileButtonsSide to "Left" or "Right" if you want the ui toggle & lock buttons to be on the left or right side of the window
    -- Set ShowCustomCursor to false if you don't want to use the Linoria cursor
    -- NotifySide = Changes the side of the notifications (Left, Right) (Default value = Left)
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = "mspaint",
    Footer = "version: example",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
    --MobileButtonsMode = "Normal",
    MethodToggle = "DynamicIsland",
    DynamicIsland = true,
    DynamicIslandAsset = 95816097006870,
    DynamicIslandText = "mspaint",
    DynamicIslandClosedText = "Tap to open UI",
    DynamicIslandOpenText = "UI is active",

    -- Modded visuals: background image, gradient overlay, and custom border stroke.
    BackgroundImage = RepoAsset("assets/Example.png"),
    BackgroundImageTransparency = 0.12,
    BackgroundImageContentTransparency = 0.2,
    BackgroundImagePanelTransparency = 0.08,
    Gradient = true,
    GradientColorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 118, 255)),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(42, 28, 92)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 8, 22)),
    }),
    GradientTransparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.76),
        NumberSequenceKeypoint.new(0.55, 0.9),
        NumberSequenceKeypoint.new(1, 0.98),
    }),
    GradientRotation = 35,
    BorderColor = Color3.fromRGB(125, 85, 255),
    BorderThickness = 1.5,
    --TabStyle = "Card",
    TabsMode = "Sidebar", -- can change between "Sidebar" And "Topbar"
    KeybindMenuWidth = 360,
    KeybindMenuMaxHeight = 240,
    FullscreenBackground = true,
    FullscreenBackgroundTransparency = 1,
})

-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
-- You can find more icons in https://lucide.dev/
Library:ApplyNewElements() -- Enables/advertises modded elements like glass panels, shiny buttons, and liquid toggles.

local Tabs = {
    -- Creates a special generated dashboard tab with overview cards and new liquid-glass controls
    Dashboard = Window:AddDashboardTab({
        HubName = "mspaint",
        Badge = "LIVE",
        HubTitle = "mspaint Hub",
        HubDescription = "Modern script hub UI powered by Obsidian Modded. Includes toasts, key-system, and polished components.",
        HubIcon = "sparkles",
        HubBanner = "rbxassetid://14909902842",
        DiscordInvite = "discord.gg/mspaint",
        Socials = {
            Telegram = "t.me/mspainthub",
            YouTube = "youtube.com/@mspaint",
        },
        Advanced = true,
        GraphValues = { 10, 16, 19, 24, 30, 34, 41, 47 },
        GraphHeight = 128,
        GraphArea = true,
        GraphSmooth = true,
        DetailCardHeight = 82,
        TopUsers = {
            { Name = "mspaint", DisplayName = "mspaint", UserId = 1, Score = 991 },
            { Name = "Obsidian", DisplayName = "Obsidian UI", UserId = 2, Score = 874 },
            {
                Name = "LocalPlayer",
                DisplayName = "Local Player",
                UserId = game.Players.LocalPlayer.UserId,
                Score = 720,
            },
            { Name = "Guest", DisplayName = "Guest Preview", UserId = 3, Score = 540 },
        },
        Text = "Welcome to the modded Obsidian dashboard. Use this tab as a landing page for script hubs. This text can be very long and the tab info section now scrolls when overflowing.",
    }),
    -- Creates a new tab titled Main
    Main = Window:AddTab("Main", "user"),
    Key = Window:AddKeyTab("Key System"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local ShowcaseCard = Tabs.Main:addcard({
    Title = "Starter card",
    Desc = "Card-style tab switcher. Click this card to jump to Dashboard tab.",
    Icon = "sparkles",
    Thumbnail = "rbxassetid://139785960036434",
    Side = 1,
    TargetTab = "Dashboard",
})

--[[
Example of how to add a warning box to a tab; the title AND text support rich text formatting.

local UISettingsTab = Tabs["UI Settings"]

UISettingsTab:UpdateWarningBox({
	Visible = true,
	Title = "Warning",
	Text = "This is a warning box!",
})

--]]

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(Name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Groupbox", "boxes")
local CustomFontBox = Tabs.Main:AddRightGroupbox("Custom Fonts", "type")
local FullMediaBox = Tabs.Main:AddFullGroupbox("Full Width Media", "sparkles")
local ArisuDanceSpriteUrl = RepoAsset("assets/sprites/ArisuDanceSheet.png")

FullMediaBox:AddLabel({
    Text = "Full-width groupboxes sit above the normal left/right columns. The animated sprite demo is floating above the UI near the search bar.",
    DoesWrap = true,
})

-- Direct MP4 URL example:
-- FullMediaBox:AddVideo("RemoteVideo", {
--     Video = "https://your-site.com/video.mp4",
--     FileName = "RemoteVideo.mp4",
--     Playing = true,
--     Looped = true,
-- })

local FloatingArisu = Library:AddFloatingSprite({
    Image = ArisuDanceSpriteUrl,
    FileName = "ArisuDanceSheet.png",
    FrameSize = Vector2.new(64, 64),
    FrameCount = 8,
    Columns = 8,
    Fps = 12,
    ParentMode = "Floating",
    Position = UDim2.new(0.72, 0, 0, 86),
    Size = UDim2.fromOffset(90, 90),
    Visible = true,
    ZIndex = 50000,
})

Library:AddKeybindMenuButton({
    Text = "Notify from menu",
    Callback = function()
        Library:NotifySuccess({ Title = "Keybind menu", Description = "Button callback fired.", Time = 2 })
    end,
})

Library:AddKeybindMenuToggle("FloatingArisuSprite", {
    Text = "Show Arisu sprite",
    Default = true,
    Callback = function(Value)
        FloatingArisu:SetVisible(Value)
    end,
})

-- Advanced custom font examples.
-- Font:Download expects a bitmap-font JSON manifest with atlas page image URLs and glyph metrics.
-- These test manifests live in this repo, but any internet URL with the same schema works.
local FontExamples = {
    {
        Name = "Pixel",
        Url = RepoAsset("assets/custom_fonts/ObsidianPixel.json"),
        Text = "PIXEL FONT TEST 123",
        Color = Color3.fromRGB(125, 235, 255),
    },
    {
        Name = "Block",
        Url = RepoAsset("assets/custom_fonts/ObsidianBlock.json"),
        Text = "BLOCK FONT TEST 456",
        Color = Color3.fromRGB(255, 212, 102),
    },
    {
        Name = "Slant",
        Url = RepoAsset("assets/custom_fonts/ObsidianSlant.json"),
        Text = "SLANT FONT TEST 789",
        Color = Color3.fromRGB(190, 160, 255),
    },
}

for _, FontExample in ipairs(FontExamples) do
    local Success, FontData = pcall(function()
        return Library:DownloadFont(FontExample.Url)
    end)

    if Success then
        CustomFontBox:AddCustomFontLabel({
            Text = FontExample.Text,
            Font = FontData,
            TextSize = 18,
            Height = 32,
            Color = FontExample.Color,
            TextXAlignment = Enum.TextXAlignment.Center,
        })
    else
        CustomFontBox:AddLabel({
            Text = "Failed to load " .. FontExample.Name .. " font: " .. tostring(FontData),
            DoesWrap = true,
        })
    end
end

LeftGroupBox:AddGlassPanel("ExampleGlassPanel", {
    Title = "Liquid glass preview",
    Description = "A reusable glass panel with gradient, icon, badge, and custom stroke styling.",
    Icon = "sparkles",
    Badge = "NEW",
    Height = 82,
})
LeftGroupBox:AddLiquidGlassToggle("ExampleLiquidToggle", {
    Text = "Liquid glass toggle",
    Default = true,
    Callback = function(Value)
        print("[cb] Liquid glass toggle changed:", Value)
    end,
})
LeftGroupBox:AddShinyButton({
    Text = "Shiny animated button",
    Callback = function()
        Library:NotifySuccess({ Title = "Shiny", Description = "The new shiny button was clicked!", Time = 3 })
    end,
})
LeftGroupBox:AddLiquidGlassButton({
    Text = "Preview premium loading",
    Icon = "loader-circle",
    Callback = function()
        local Loading = Library:CreateLoading({
            Title = "mspaint",
            Icon = 95816097006870,
            AutoResizeHeight = true,
            ShowSidebar = true,
            WindowWidth = 560,
            WindowHeight = 250,
            ContentWidth = 560,
            SidebarWidth = 230,
            BackdropTransparency = 0.28,
            SurfaceTransparency = 0,
            SurfaceFillTransparency = 0,
            ShowLoadingIcon = false,
            AppearAnimation = true,
            DisappearAnimation = true,
            DisableAppearAnimation = false,
            DisableDisappearAnimation = false,
            EntranceAnimationDuration = 0.62,
            ExitAnimationDuration = 0.38,
            AmbientGradient = false,
            DrawingDecorations = true,
            Decor = true,
            DecorImage = Library.ImageManager.GetAsset("LoadingPanelStaticTexture"),
            DecorFrames = {
                Library.ImageManager.GetAsset("LoadingPanelStaticTexture"),
            },
            DecorFrameRate = 30,
            DecorImageTransparency = 0.18,
            DecorPosition = "Full",
            ProgressTextureImage = Library.ImageManager.GetAsset("LoadingBarStaticTexture"),
            ProgressTextureFrames = {
                Library.ImageManager.GetAsset("LoadingBarStaticTexture"),
            },
            ProgressTextureFrameRate = 30,
            ProgressTextureTransparency = 0.04,
            ProgressTextureSpeed = 0,
            ProgressTextureTileSize = UDim2.fromOffset(192, 16),
            ProgressTrackTexture = true,
            ProgressTrackTextureTransparency = 0.56,
            ProgressBarSize = UDim2.new(0.62, 0, 0, 16),
            ProgressBarPadding = 2,
            ProgressBarTransparency = 0.18,
            ProgressBarStrokeColor = "AccentColor",
            ProgressBarStrokeTransparency = 0.2,
            ProgressBarShadowTransparency = 0.8,
            ProgressFillTransparency = 0.03,
            ProgressShine = true,
            ProgressShineTransparency = 0.58,
            ProgressShineWidth = 56,
            ProgressShineSpeed = 1.8,
            ProgressShineRotation = 12,
            SmoothProgress = true,
            SmoothProgressDefaultDuration = 0.58,
            SmoothProgressMinDuration = 0.26,
            SmoothProgressMaxDuration = 1.45,
            SmoothProgressCadenceScale = 0.86,
            GradientTransition = true,
            GradientTransitionDuration = 0.72,
            GradientTransitionRotation = 45,
            GradientTransitionStops = {
                { 125, 85, 255, 0 },
                { 125, 85, 255, 0.22 },
                { 255, 255, 255, 0.5 },
                { 65, 210, 255, 0.78 },
                { 65, 210, 255, 1 },
            },
            GradientTransitionTransparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.24, 0.08),
                NumberSequenceKeypoint.new(0.5, 0.16),
                NumberSequenceKeypoint.new(0.76, 0.1),
                NumberSequenceKeypoint.new(1, 1),
            }),
            GradientTransitionInOffset = Vector2.new(-1.2, -1.2),
            GradientTransitionOutOffset = Vector2.new(1.2, 1.2),
            GradientTransitionExitInOffset = Vector2.new(1.2, 1.2),
            GradientTransitionExitOutOffset = Vector2.new(-1.2, -1.2),
            ProgressCap = false,
            Drawings = {},
        })

        Loading:SetTotalSteps(6)
        Loading:SetMessage("Booting mspaint")
        Loading:SetDescription("Preparing clean static texture, clipped shine, and smooth loading surfaces...")
        Loading.Sidebar:AddLabel({
            Text = "Live preview: clean static panel texture, static progress texture, clipped fill-only shiny sweep, smooth progress, and 45 degree gradient enter/exit.",
            DoesWrap = true,
        })
        Loading.Sidebar:AddGlassPanel("LoadingAnimationPanel", {
            Title = "Drawing API",
            Description = "AddDrawingFrame/Image/Line/Gradient can paint clipped texture details inside the loading UI.",
            Icon = "sparkles",
            Height = 74,
        })

        task.spawn(function()
            local Steps = {
                { "Downloading assets", "Resolving icons and themed surfaces." },
                { "Building layout", "Preparing responsive content and sidebar." },
                { "Applying theme", "Syncing accent gradients and glow layers." },
                { "Animating particles", "Starting ambient dots and pulse rings." },
                { "Final polish", "Warming up progress shimmer and labels." },
                { "Ready", "Closing with a soft exit animation." },
            }

            for Index, Step in ipairs(Steps) do
                if Loading.Destroyed then
                    return
                end

                Loading:SetMessage(Step[1])
                Loading:SetDescription(Step[2])
                Loading:SetCurrentStep(Index)
                task.wait(0.55)
            end

            if not Loading.Destroyed then
                Loading:Destroy()
            end
        end)
    end,
})

LeftGroupBox:AddLiquidGlassButton({
    Text = "Show popup",
    Icon = "message-square",
    Callback = function()
        Library:ShowPopup({
            Type = "Success",
            Title = "Popup ready",
            Description = "This is a polished floating popup card with no dark overlay by default.",
            Time = 4,
            Actions = {
                {
                    Text = "Keep open",
                    Variant = "Ghost",
                    CloseOnClick = false,
                    Callback = function(Popup)
                        Popup:SetDescription("Popup is still alive; close it with the x button.")
                    end,
                },
                {
                    Text = "Close",
                    Variant = "Primary",
                },
            },
        })
    end,
})

LeftGroupBox:AddLiquidGlassButton({
    Text = "Show dialog",
    Icon = "panel-top-open",
    Callback = function()
        Window:ShowDialog({
            Title = "Confirm action",
            Description = "Dialog uses the existing Obsidian modal system, now with one-call API support and configurable overlay transparency.",
            Icon = "sparkles",
            OverlayTransparency = 0.62,
            FooterButtons = {
                Cancel = {
                    Title = "Cancel",
                    Variant = "Secondary",
                },
                Confirm = {
                    Title = "Confirm",
                    Variant = "Primary",
                    Callback = function()
                        Library:ShowPopup({
                            Type = "Info",
                            Title = "Dialog callback",
                            Description = "Confirm button callback fired.",
                            Time = 3,
                        })
                    end,
                },
            },
        })
    end,
})

local GroupboxTabBox = LeftGroupBox:AddTabbox({ Name = "Groupbox nested tabbox" })
-- Aliases after fork sync: AddTabBox, AddNestedTabbox, AddGroupboxTabbox.
local MiningTab = GroupboxTabBox:AddTab("Mining", "pickaxe")
MiningTab:AddToggle("GroupboxTabboxAutoMine", {
    Text = "Auto Mine",
    Default = false,
})
MiningTab:AddDropdown("GroupboxTabboxRockPriority", {
    Text = "Rock Priority",
    Values = { "Stone", "Copper", "Iron", "Gold" },
    Default = "Stone",
})

local GearTab = GroupboxTabBox:AddTab("Gear", "settings")
GearTab:AddToggle("GroupboxTabboxAutoEquip", {
    Text = "Auto Equip Pickaxe",
    Default = true,
})

-- We can also get our Main tab via the following code:
-- local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox("Groupbox", "boxes")

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[

local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side

local Tab1 = TabBox:AddTab("Tab 1")
local Tab2 = TabBox:AddTab("Tab 2")

-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options
LeftGroupBox:AddToggle("MyToggle", {
    Text = "This is a toggle",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the toggle
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the toggle while it's disabled

    Default = true, -- Default value (true / false)
    Disabled = false, -- Will disable the toggle (true / false)
    Visible = true, -- Will make the toggle invisible (true / false)
    Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

    Callback = function(Value)
        print("[cb] MyToggle changed to:", Value)
    end,
})
    :AddColorPicker("ColorPicker1", {
        Default = Color3.new(1, 0, 0),
        Title = "Some color1", -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

        Callback = function(Value)
            print("[cb] Color changed!", Value)
        end,
    })
    :AddColorPicker("ColorPicker2", {
        Default = Color3.new(0, 1, 0),
        Title = "Some color2",

        Callback = function(Value)
            print("[cb] Color changed!", Value)
        end,
    })

-- Fetching a toggle object for later use:
-- Toggles.MyToggle.Value

-- Toggles is a table added to getgenv() by the library
-- You index Toggles with the specified index, in this case it is 'MyToggle'
-- To get the state of the toggle you do toggle.Value

-- Calls the passed function when the toggle is updated
Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    print("MyToggle changed to:", Toggles.MyToggle.Value)
end)

-- This should print to the console: "My toggle state changed! New value: false"
Toggles.MyToggle:SetValue(false)

LeftGroupBox:AddCheckbox("MyCheckbox", {
    Text = "This is a checkbox",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the toggle
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the toggle while it's disabled

    Default = true, -- Default value (true / false)
    Disabled = false, -- Will disable the toggle (true / false)
    Visible = true, -- Will make the toggle invisible (true / false)
    Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

    Callback = function(Value)
        print("[cb] MyCheckbox changed to:", Value)
    end,
})

Toggles.MyCheckbox:OnChanged(function()
    print("MyCheckbox changed to:", Toggles.MyCheckbox.Value)
end)

-- 1/15/23
-- Deprecated old way of creating buttons in favor of using a table
-- Added DoubleClick button functionality

--[[
	Groupbox:AddButton
	Arguments: {
		Text = string,
		Func = function,
		DoubleClick = boolean
		Tooltip = string,
	}

	You can call :AddButton on a button to add a SubButton!
]]

local MyButton = LeftGroupBox:AddButton({
    Text = "Button",
    Func = function()
        print("You clicked a button!")
    end,
    DoubleClick = false,

    Tooltip = "This is the main button",
    DisabledTooltip = "I am disabled!",

    Disabled = false, -- Will disable the button (true / false)
    Visible = true, -- Will make the button invisible (true / false)
    Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)
})

local MyButton2 = MyButton:AddButton({
    Text = "Sub button",
    Func = function()
        print("You clicked a sub button!")
    end,
    DoubleClick = true, -- You will have to click this button twice to trigger the callback
    Tooltip = "This is the sub button",
    DisabledTooltip = "I am disabled!",
})

local MyDisabledButton = LeftGroupBox:AddButton({
    Text = "Disabled Button",
    Func = function()
        print("You somehow clicked a disabled button!")
    end,
    DoubleClick = false,
    Tooltip = "This is a disabled button",
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the button while it's disabled
    Disabled = true,
})

--[[
	NOTE: You can chain the button methods!
	EXAMPLE:

	LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
		:AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

local NotificationGroupBox = Tabs.Main:AddRightGroupbox("Notifications", "bell")

NotificationGroupBox:AddButton({
    Text = "Show success toast",
    Func = function()
        Library:NotifySuccess({
            Title = "Config saved",
            Description = "Your settings are safe and ready for the next session.",
            Time = 4,
            Actions = {
                {
                    Text = "Nice",
                    Callback = function(Notification)
                        print("Dismissed notification:", Notification.Title)
                    end,
                },
            },
        })
    end,
})

NotificationGroupBox:AddButton({
    Text = "Show progress toast",
    Func = function()
        local Notification = Library:NotifyInfo({
            Title = "Downloading assets",
            Description = "Preparing icons, images, and cached resources...",
            Persist = true,
            Progress = 0,
            Actions = {
                {
                    Text = "Cancel",
                    Risky = true,
                    Callback = function(Toast)
                        Toast:ChangeDescription("Download cancelled by the user.")
                    end,
                },
            },
        })

        for Step = 1, 10 do
            if Notification.Destroyed then
                return
            end

            task.wait(0.15)
            Notification:SetProgress(Step / 10)
        end

        Notification:ChangeTitle("Download complete")
        Notification:ChangeDescription("All assets were prepared successfully.")
        task.wait(0.5)
        Notification:Destroy()
    end,
})

NotificationGroupBox:AddButton({
    Text = "Show warning toast",
    Func = function()
        Library:NotifyWarning({
            Title = "Heads up",
            Description = "This demonstrates variant icons, accent colors, and action buttons.",
            Time = 6,
            Actions = {
                { Text = "Got it" },
                {
                    Text = "Keep open",
                    CloseOnClick = false,
                    Callback = function(Toast)
                        Toast:ChangeDescription("This toast will stay until its timer ends.")
                    end,
                },
            },
        })
    end,
})

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap, Idx
-- Arguments: Idx, Options
LeftGroupBox:AddLabel("This is a label")
LeftGroupBox:AddLabel("This is a label\n\nwhich wraps its text!", true)
LeftGroupBox:AddLabel("This is a label exposed to Labels", true, "TestLabel")
LeftGroupBox:AddLabel("SecondTestLabel", {
    Text = "This is a label made with table options and an index",
    DoesWrap = true, -- Defaults to false
})

LeftGroupBox:AddLabel("SecondTestLabel", {
    Text = "This is a label that doesn't wrap it's own text",
    DoesWrap = false, -- Defaults to false
})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'SecondTestLabel' & 'TestLabel'
-- To set the text of the label you do label:SetText

-- Options.TestLabel:SetText("first changed!")
-- Options.SecondTestLabel:SetText("second changed!")

-- Groupbox:AddDivider
-- Arguments: None
LeftGroupBox:AddDivider()

--[[
	Groupbox:AddSlider
	Arguments: Idx, SliderOptions

	SliderOptions: {
		Text = string,
		Default = number,
		Min = number,
		Max = number,
		Suffix = string,
		Rounding = number,
		Compact = boolean,
		HideMax = boolean,
	}

	Text, Default, Min, Max, Rounding must be specified.
	Suffix is optional.
	Rounding is the number of decimal places for precision.

	Compact will hide the title label of the Slider

	HideMax will only display the value instead of the value & max value of the slider
	Compact will do the same thing
]]
LeftGroupBox:AddSlider("MySlider", {
    Text = "This is my slider!",
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print("[cb] MySlider was changed! New value:", Value)
    end,

    Tooltip = "I am a slider!", -- Information shown when you hover over the slider
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the slider while it's disabled

    Disabled = false, -- Will disable the slider (true / false)
    Visible = true, -- Will make the slider invisible (true / false)
})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print("MySlider was changed! New value:", Options.MySlider.Value)
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.MySlider:SetValue(3)

LeftGroupBox:AddSlider("MySlider2", {
    Text = "This is my custom display slider!",
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Compact = false,

    FormatDisplayValue = function(slider, value)
        if value == slider.Max then
            return "Everything"
        end
        if value == slider.Min then
            return "Nothing"
        end
        -- If you return nil, the default formatting will be applied
    end,

    Tooltip = "I am a slider!", -- Information shown when you hover over the slider
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the slider while it's disabled

    Disabled = false, -- Will disable the slider (true / false)
    Visible = true, -- Will make the slider invisible (true / false)
})

-- Groupbox:AddInput
-- Arguments: Idx, Info
LeftGroupBox:AddInput("MyTextbox", {
    Default = "My textbox!",
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter
    ClearTextOnFocus = true, -- true / false, if false the text will not clear when textbox focused

    Text = "This is a textbox",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the textbox

    Placeholder = "Placeholder text", -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print("[cb] Text updated. New text:", Value)
    end,
})

Options.MyTextbox:OnChanged(function()
    print("Text updated. New text:", Options.MyTextbox.Value)
end)

-- Groupbox:AddDropdown
-- Arguments: Idx, Info

local DropdownGroupBox = Tabs.Main:AddRightGroupbox("Dropdowns")

DropdownGroupBox:AddDropdown("MyDropdown", {
    Values = { "This", "is", "a", "dropdown" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = "A dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    Searchable = false, -- true / false, makes the dropdown searchable (great for a long list of values)

    Callback = function(Value)
        print("[cb] Dropdown got changed. New value:", Value)
    end,

    Disabled = false, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

Options.MyDropdown:OnChanged(function()
    print("Dropdown got changed. New value:", Options.MyDropdown.Value)
end)

Options.MyDropdown:SetValue("This")

DropdownGroupBox:AddDropdown("MySearchableDropdown", {
    Values = { "This", "is", "a", "searchable", "dropdown" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = "A searchable dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    Searchable = true, -- true / false, makes the dropdown searchable (great for a long list of values)

    Callback = function(Value)
        print("[cb] Dropdown got changed. New value:", Value)
    end,

    Disabled = false, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

DropdownGroupBox:AddDropdown("MyCardDropdown", {
    Values = { "Nebula", "Aurora", "Obsidian" },
    Default = "Nebula",
    Text = "Advanced card dropdown",
    Searchable = true,
    CardDropdown = true,
    CardHeight = 82,
    MaxVisibleDropdownItems = 3,
    ValueImages = {
        Nebula = "sparkles",
        Aurora = "zap",
        Obsidian = "gem",
    },
    Cards = {
        Nebula = {
            Text = "Nebula Theme",
            Description = "Purple space cards with glowing accent strokes.",
            Thumbnail = "rbxassetid://14909902842",
            Icon = "sparkles",
            BottomBarTransparency = 0.15,
            StrokeColor = Color3.fromRGB(125, 85, 255),
        },
        Aurora = {
            Text = "Aurora Theme",
            Description = "Bright green and blue card with transparent bottom bar.",
            Thumbnail = "rbxassetid://14909902842",
            Icon = "zap",
            BottomBarTransparency = 0.25,
            StrokeColor = Color3.fromRGB(34, 197, 94),
        },
        Obsidian = {
            Text = "Obsidian Theme",
            Description = "Dark glass card for premium script hub menus.",
            Thumbnail = "rbxassetid://14909902842",
            Icon = "gem",
            BottomBarTransparency = 0.1,
            StrokeColor = Color3.fromRGB(255, 255, 255),
            StrokeTransparency = 0.65,
        },
    },
    Callback = function(Value)
        print("[cb] Card dropdown selected:", Value)
    end,
})

DropdownGroupBox:AddDropdown("MyDisplayFormattedDropdown", {
    Values = { "This", "is", "a", "formatted", "dropdown" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = "A display formatted dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    FormatDisplayValue = function(Value) -- You can change the display value for any values. The value will be still same, only the UI changes.
        if Value == "formatted" then
            return "display formatted" -- formatted -> display formatted but in Options.MyDisplayFormattedDropdown.Value it will still return formatted if its selected.
        end

        return Value
    end,

    Searchable = false, -- true / false, makes the dropdown searchable (great for a long list of values)

    Callback = function(Value)
        print("[cb] Display formatted dropdown got changed. New value:", Value)
    end,

    Disabled = false, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

-- Multi dropdowns
DropdownGroupBox:AddDropdown("MyMultiDropdown", {
    -- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
    -- Default also accepts a string as well

    -- Currently you can not set multiple values with a dropdown

    Values = { "This", "is", "a", "dropdown" },
    Default = 1,
    Multi = true, -- true / false, allows multiple choices to be selected

    Text = "A multi dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print("[cb] Multi dropdown got changed:")
        for key, value in next, Options.MyMultiDropdown.Value do
            print(key, value) -- should print something like This, true
        end
    end,
})

Options.MyMultiDropdown:SetValue({
    This = true,
    is = true,
})

DropdownGroupBox:AddDropdown("MyDisabledDropdown", {
    Values = { "This", "is", "a", "dropdown" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = "A disabled dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    Callback = function(Value)
        print("[cb] Disabled dropdown got changed. New value:", Value)
    end,

    Disabled = true, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

DropdownGroupBox:AddDropdown("MyDisabledValueDropdown", {
    Values = { "This", "is", "a", "dropdown", "with", "disabled", "value" },
    DisabledValues = { "disabled" }, -- Disabled Values that are unclickable
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = "A dropdown with disabled value",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    Callback = function(Value)
        print("[cb] Dropdown with disabled value got changed. New value:", Value)
    end,

    Disabled = false, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

DropdownGroupBox:AddDropdown("MyVeryLongDropdown", {
    Values = {
        "This",
        "is",
        "a",
        "very",
        "long",
        "dropdown",
        "with",
        "a",
        "lot",
        "of",
        "values",
        "but",
        "you",
        "can",
        "see",
        "more",
        "than",
        "8",
        "values",
    },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    MaxVisibleDropdownItems = 12, -- Default: 8, allows you to change the size of the dropdown list

    Text = "A very long dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown
    DisabledTooltip = "I am disabled!", -- Information shown when you hover over the dropdown while it's disabled

    Searchable = false, -- true / false, makes the dropdown searchable (great for a long list of values)

    Callback = function(Value)
        print("[cb] Very long dropdown got changed. New value:", Value)
    end,

    Disabled = false, -- Will disable the dropdown (true / false)
    Visible = true, -- Will make the dropdown invisible (true / false)
})

DropdownGroupBox:AddDropdown("MyPlayerDropdown", {
    SpecialType = "Player",
    ExcludeLocalPlayer = true, -- true / false, excludes the localplayer from the Player type
    Text = "A player dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print("[cb] Player dropdown got changed:", Value)
    end,
})

DropdownGroupBox:AddDropdown("MyTeamDropdown", {
    SpecialType = "Team",
    Text = "A team dropdown",
    Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print("[cb] Team dropdown got changed:", Value)
    end,
})

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

LeftGroupBox:AddLabel("Color"):AddColorPicker("ColorPicker", {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = "Some color", -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print("[cb] Color changed!", Value)
    end,
})

Options.ColorPicker:OnChanged(function()
    print("Color changed!", Options.ColorPicker.Value)
    print("Transparency changed!", Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info

LeftGroupBox:AddLabel("Keybind"):AddKeyPicker("KeyPicker", {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = "MB2", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,

    -- You can define custom Modes but I have never had a use for it.
    Mode = "Toggle", -- Modes: Always, Toggle, Hold, Press (example down below)

    Text = "Auto lockpick safes", -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print("[cb] Keybind clicked!", Value)
    end,

    -- Occurs when the keybind itself is changed, `NewKey` is a KeyCode Enum OR a UserInputType Enum, `NewModifiers` is a table with KeyCode Enum(s) or nil
    ChangedCallback = function(NewKey, NewModifiers)
        print("[cb] Keybind changed!", NewKey, table.unpack(NewModifiers or {}))
    end,
})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
    print("Keybind clicked!", Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print("Keybind changed!", Options.KeyPicker.Value, table.unpack(Options.KeyPicker.Modifiers or {}))
end)

task.spawn(function()
    while task.wait(1) do
        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            print("KeyPicker is being held down")
        end

        if Library.Unloaded then
            break
        end
    end
end)

Options.KeyPicker:SetValue({ "MB2", "Hold" }) -- Sets keybind to MB2, mode to Hold

-- Label:KeyPicker (Press Mode)

local KeybindNumber = 0

LeftGroupBox:AddLabel("Press Keybind"):AddKeyPicker("KeyPicker2", {
    -- Example: Press Keybind which you use to run a callback when the key was pressed.

    Default = "X", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

    Mode = "Press",
    WaitForCallback = false, -- Locks the keybind during the execution of Callback and OnChanged.

    Text = "Increase Number", -- Text to display in the keybind menu

    -- Occurs when the keybind is clicked, Value is always `true` for Press keybind.
    Callback = function()
        KeybindNumber = KeybindNumber + 1
        print("[cb] Keybind clicked! Number increased to:", KeybindNumber)
    end,
})

-- Long text label to demonstrate UI scrolling behaviour.
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox("Groupbox #2")
LeftGroupBox2:AddLabel(
    "This label spans multiple lines! We're gonna run out of UI space...\nJust kidding! Scroll down!\n\n\nHello from below!",
    true
)

local TabBox = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local Tab1 = TabBox:AddTab("Tab 1")
Tab1:AddToggle("Tab1Toggle", { Text = "Tab1 Toggle" })

local Tab2 = TabBox:AddTab("Tab 2")
Tab2:AddToggle("Tab2Toggle", { Text = "Tab2 Toggle" })

Library:OnUnload(function()
    print("Unloaded!")
end)

-- Anything we can do in a Groupbox, we can do in a Key tab (AddToggle, AddSlider, AddLabel, etc etc...)
Tabs.Key:AddLabel({
    Text = "Key: Banana",
    DoesWrap = true,
    Size = 16,
})

Tabs.Key:AddKeyBox({
    ExpectedKey = "Banana",
    Placeholder = "Type Banana and press Enter",
    ButtonText = "Unlock",
    ClearOnSuccess = true,
    SuccessText = "Access granted",
    FailureText = "Wrong key, try Banana",
    Callback = function(Success, ReceivedKey, KeyBox)
        print("Expected Key: Banana - Received Key:", ReceivedKey, "| Success:", Success)

        if Success then
            Library:NotifySuccess({
                Title = "Key accepted",
                Description = "The key system validated your access and cleared the input box.",
                Time = 4,
            })
        else
            Library:NotifyError({
                Title = "Invalid key",
                Description = "Received " .. ReceivedKey .. ". Try the expected key: " .. tostring(KeyBox.ExpectedKey),
                Time = 4,
            })
        end
    end,
})

local DynamicKeyBox = Tabs.Key:AddKeyBox({
    ExpectedKey = "Obsidian",
    Placeholder = "Dynamic key example",
    ButtonText = "Check",
    CaseSensitive = false,
    Callback = function(Success, ReceivedKey, KeyBox)
        KeyBox:SetStatus(
            Success and "Dynamic key accepted" or "Expected: " .. tostring(KeyBox.ExpectedKey),
            Success and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(245, 158, 11)
        )
    end,
})
Tabs.Key:AddButton({
    Text = "Change dynamic key",
    Func = function()
        DynamicKeyBox:SetExpectedKey("Modded")
        Library:NotifyInfo({
            Title = "Key changed",
            Description = "The dynamic key is now Modded.",
            Time = 3,
        })
    end,
})

-- DraggableLabel

Library:AddDraggableLabel("This is a Draggable Label")

-- UI Settings
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})
MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",

    Text = "Notification Side",

    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})
MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",

    Text = "DPI Scale",

    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)

        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = Library.CornerRadius,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        Window:SetCornerRadius(value)
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place") -- if the game has multiple places inside of it (for example: DOORS)
-- you can use this to save configs for those places separately
-- The path in this script would be: MyScriptHub/specific-game/settings/specific-place
-- [ This is optional ]

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs["UI Settings"])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
