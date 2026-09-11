--==================================================
-- FFH4X | AIMBOT + ESP + CONFIG
-- Roblox Studio | LocalScript
--==================================================
-- VERSÃO COMPLETA
--
-- CORREÇÕES:
-- • ESP Line não atravessa a tela
-- • ESP Skeleton não cria linhas gigantes
-- • ESP Box inválida é escondida
-- • ESP antigo é limpo antes de redesenhar
-- • ESP Vida continua funcional
-- • X fecha o seletor de cores
--
-- RESTANTE DO PAINEL PRESERVADO
--==================================================


--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")


--==================================================
-- PLAYER
--==================================================

local LocalPlayer = Players.LocalPlayer

local PlayerGui =
	LocalPlayer:WaitForChild("PlayerGui")

local Camera =
	workspace.CurrentCamera


--==================================================
-- LIMPEZA DE EXECUÇÃO ANTERIOR
--==================================================

if _G.FFH4X_Cleanup then
	pcall(function()
		_G.FFH4X_Cleanup()
	end)
end

-- Limpa visuais órfãos de versões antigas.
pcall(function()
	for _, Name in ipairs({"FFH4X_ESP", "AimESPVisuals"}) do
		local Old = PlayerGui:FindFirstChild(Name)
		if Old then Old:Destroy() end
	end
end)


_G.FFH4X_RunID =
	(_G.FFH4X_RunID or 0) + 1

local RunID =
	_G.FFH4X_RunID


--==================================================
-- CONFIG
--==================================================

local Config = {

	-- AIM
	Aimbot = false,

	-- FOV
	ShowFOV = false,

	-- ESP
	ESPBox = false,
	ESPHealth = false,
	ESPName = false,
	ESPLine = false,
	ESPSkeleton = false,

	-- FOV
	FOV = 100,
	MinFOV = 30,
	MaxFOV = 400,

	-- DISTÂNCIAS
	AimbotDistance = 1500,
	ESPDistance = math.huge,

	-- PARTE DO ALVO
	TargetPart = "Head",

	-- CORES
	ESPColor =
		Color3.fromRGB(255, 0, 0),

	FOVColor =
		Color3.fromRGB(255, 255, 255),

	PanelColor =
		Color3.fromRGB(0, 0, 0),
}


--==================================================
-- CORES BASE
--==================================================

local WHITE =
	Color3.fromRGB(245, 245, 245)

local BLACK =
	Color3.fromRGB(0, 0, 0)

local DARK =
	Color3.fromRGB(20, 20, 20)

local RED =
	Color3.fromRGB(255, 0, 0)


--==================================================
-- CONNECTIONS
--==================================================

local Connections = {}


local function Connect(Connection)

	table.insert(
		Connections,
		Connection
	)

	return Connection
end


--==================================================
-- REMOVER GUI ANTIGA
--==================================================

local OldGUI =
	PlayerGui:FindFirstChild("FFH4X")

if OldGUI then
	OldGUI:Destroy()
end


local OldESP =
	PlayerGui:FindFirstChild("FFH4X_ESP")

if OldESP then
	OldESP:Destroy()
end


--==================================================
-- GUI PRINCIPAL
--==================================================

local GUI =
	Instance.new("ScreenGui")

GUI.Name = "FFH4X"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.Parent = PlayerGui


--==================================================
-- PAINEL
--==================================================

local Panel =
	Instance.new("Frame")

Panel.Name = "Panel"

Panel.Size =
	UDim2.fromOffset(
		300,
		330
	)

Panel.Position =
	UDim2.new(
		0.5,
		-150,
		0.5,
		-165
	)

Panel.BackgroundColor3 =
	Config.PanelColor

Panel.BorderSizePixel = 0

Panel.Parent = GUI


--==================================================
-- PANEL CORNER
--==================================================

local PanelCorner =
	Instance.new("UICorner")

PanelCorner.CornerRadius =
	UDim.new(0, 8)

PanelCorner.Parent =
	Panel


--==================================================
-- PANEL STROKE
--==================================================

local PanelStroke =
	Instance.new("UIStroke")

PanelStroke.Color = RED
PanelStroke.Thickness = 1
PanelStroke.Transparency = 0.2

PanelStroke.Parent =
	Panel


--==================================================
-- HEADER
--==================================================

local Header =
	Instance.new("Frame")

Header.Name = "Header"

Header.Size =
	UDim2.new(
		1,
		0,
		0,
		55
	)

Header.BackgroundColor3 =
	Config.PanelColor

Header.BorderSizePixel = 0

Header.Parent =
	Panel


--==================================================
-- HEADER CORNER
--==================================================

local HeaderCorner =
	Instance.new("UICorner")

HeaderCorner.CornerRadius =
	UDim.new(0, 8)

HeaderCorner.Parent =
	Header


--==================================================
-- TÍTULO
--==================================================

local Title =
	Instance.new("TextLabel")

Title.Name = "Title"

Title.Size =
	UDim2.new(
		1,
		-90,
		1,
		0
	)

Title.Position =
	UDim2.fromOffset(
		15,
		0
	)

Title.BackgroundTransparency = 1

Title.Text = "FFH4X"

Title.TextColor3 =
	WHITE

Title.Font =
	Enum.Font.GothamBold

Title.TextSize = 19

Title.TextXAlignment =
	Enum.TextXAlignment.Left

Title.Parent =
	Header


--==================================================
-- BOTÃO MINIMIZAR
--==================================================

local Minimize =
	Instance.new("TextButton")

Minimize.Name =
	"Minimize"

Minimize.Size =
	UDim2.fromOffset(
		32,
		32
	)

Minimize.Position =
	UDim2.new(
		1,
		-70,
		0,
		11
	)

Minimize.BackgroundColor3 =
	DARK

Minimize.Text = "—"

Minimize.TextColor3 =
	WHITE

Minimize.Font =
	Enum.Font.GothamBold

Minimize.TextSize = 18

Minimize.BorderSizePixel = 0

Minimize.Parent =
	Header


local MinCorner =
	Instance.new("UICorner")

MinCorner.CornerRadius =
	UDim.new(0, 6)

MinCorner.Parent =
	Minimize


--==================================================
-- BOTÃO FECHAR
--==================================================

local Close =
	Instance.new("TextButton")

Close.Name = "Close"

Close.Size =
	UDim2.fromOffset(
		32,
		32
	)

Close.Position =
	UDim2.new(
		1,
		-35,
		0,
		11
	)

Close.BackgroundColor3 =
	DARK

Close.Text = "×"

Close.TextColor3 =
	WHITE

Close.Font =
	Enum.Font.GothamBold

Close.TextSize = 20

Close.BorderSizePixel = 0

Close.Parent =
	Header


local CloseCorner =
	Instance.new("UICorner")

CloseCorner.CornerRadius =
	UDim.new(0, 6)

CloseCorner.Parent =
	Close


--==================================================
-- SIDEBAR
--==================================================

local Sidebar =
	Instance.new("Frame")

Sidebar.Name =
	"Sidebar"

Sidebar.Size =
	UDim2.new(
		0,
		62,
		1,
		-55
	)

Sidebar.Position =
	UDim2.fromOffset(
		0,
		55
	)

Sidebar.BackgroundColor3 =
	Config.PanelColor

Sidebar.BorderSizePixel = 0

Sidebar.Parent =
	Panel


--==================================================
-- CRIAR TAB
--==================================================

local function CreateTab(Text, Y)

	local Button =
		Instance.new("TextButton")

	Button.Size =
		UDim2.new(
			1,
			-10,
			0,
			65
		)

	Button.Position =
		UDim2.fromOffset(
			5,
			Y
		)

	Button.BackgroundColor3 =
		Config.PanelColor

	Button.BorderSizePixel = 0

	Button.Text = Text

	Button.TextColor3 =
		WHITE

	Button.Font =
		Enum.Font.GothamBold

	Button.TextSize = 11

	Button.Parent =
		Sidebar


	local Corner =
		Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(0, 6)

	Corner.Parent =
		Button


	return Button
end


--==================================================
-- TABS
--==================================================

local AimTab =
	CreateTab(
		"AIM",
		10
	)

local ESPTab =
	CreateTab(
		"ESP",
		80
	)

local ConfigTab =
	CreateTab(
		"⚙",
		150
	)


--==================================================
-- CONTENT
--==================================================

local Content =
	Instance.new("Frame")

Content.Name =
	"Content"

Content.Size =
	UDim2.new(
		1,
		-62,
		1,
		-55
	)

Content.Position =
	UDim2.fromOffset(
		62,
		55
	)

Content.BackgroundTransparency = 1

Content.Parent =
	Panel


--==================================================
-- AIM PAGE
--==================================================

local AimPage =
	Instance.new("Frame")

AimPage.Name =
	"AimPage"

AimPage.Size =
	UDim2.fromScale(
		1,
		1
	)

AimPage.BackgroundTransparency = 1

AimPage.Parent =
	Content


--==================================================
-- ESP PAGE
--==================================================

local ESPPage =
	Instance.new("Frame")

ESPPage.Name =
	"ESPPage"

ESPPage.Size =
	UDim2.fromScale(
		1,
		1
	)

ESPPage.BackgroundTransparency = 1

ESPPage.Visible = false

ESPPage.Parent =
	Content


--==================================================
-- CONFIG PAGE
--==================================================

local ConfigPage =
	Instance.new("Frame")

ConfigPage.Name =
	"ConfigPage"

ConfigPage.Size =
	UDim2.fromScale(
		1,
		1
	)

ConfigPage.BackgroundTransparency = 1

ConfigPage.Visible = false

ConfigPage.Parent =
	Content


--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle =
	Instance.new("Frame")

FOVCircle.Name =
	"FOVCircle"

FOVCircle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FOVCircle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

FOVCircle.Size =
	UDim2.fromOffset(
		Config.FOV * 2,
		Config.FOV * 2
	)

FOVCircle.BackgroundTransparency = 1

FOVCircle.Visible =
	Config.ShowFOV

FOVCircle.ZIndex = 0

FOVCircle.Parent =
	GUI


local FOVCircleCorner =
	Instance.new("UICorner")

FOVCircleCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

FOVCircleCorner.Parent =
	FOVCircle


local FOVCircleStroke =
	Instance.new("UIStroke")

FOVCircleStroke.Color =
	Config.FOVColor

FOVCircleStroke.Thickness = 1.5

FOVCircleStroke.Parent =
	FOVCircle


--==================================================
-- CONTRASTE DO TEXTO
--==================================================

local OptionLabels = {}


local function GetContrastTextColor(Color)

	local Luminance =
		(
			0.299 * Color.R
		)
		+
		(
			0.587 * Color.G
		)
		+
		(
			0.114 * Color.B
		)

	if Luminance > 0.55 then
		return BLACK
	end

	return WHITE
end


local function RegisterOptionLabel(Label)

	table.insert(
		OptionLabels,
		Label
	)

	Label.TextColor3 =
		GetContrastTextColor(
			Config.PanelColor
		)
end


local function UpdateOptionTextColors()

	local TextColor =
		GetContrastTextColor(
			Config.PanelColor
		)

	for _, Label in ipairs(
		OptionLabels
	) do

		if Label
			and Label.Parent then

			Label.TextColor3 =
				TextColor
		end
	end
end


--==================================================
-- TOGGLE
--==================================================

local function CreateToggle(
	Parent,
	Text,
	Y,
	ConfigName
)

	local Holder =
		Instance.new("Frame")

	Holder.Name =
		ConfigName .. "_Holder"

	Holder.Size =
		UDim2.new(
			1,
			-20,
			0,
			32
		)

	Holder.Position =
		UDim2.fromOffset(
			10,
			Y
		)

	Holder.BackgroundColor3 =
		Config.PanelColor

	Holder.BorderSizePixel = 0

	Holder.Parent =
		Parent


	local Corner =
		Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(0, 5)

	Corner.Parent =
		Holder


	--==================================================
	-- QUADRADO
	--==================================================

	local Toggle =
		Instance.new("TextButton")

	Toggle.Name =
		"Toggle"

	Toggle.Size =
		UDim2.fromOffset(
			18,
			18
		)

	Toggle.Position =
		UDim2.fromOffset(
			7,
			7
		)

	Toggle.BackgroundColor3 =
		DARK

	Toggle.BorderSizePixel = 0

	Toggle.Text = ""

	Toggle.Parent =
		Holder


	local ToggleCorner =
		Instance.new("UICorner")

	ToggleCorner.CornerRadius =
		UDim.new(0, 3)

	ToggleCorner.Parent =
		Toggle


	--==================================================
	-- TEXTO
	--==================================================

	local Label =
		Instance.new("TextLabel")

	Label.Name =
		"Label"

	Label.Size =
		UDim2.new(
			1,
			-38,
			1,
			0
		)

	Label.Position =
		UDim2.fromOffset(
			33,
			0
		)

	Label.BackgroundTransparency = 1

	Label.Text = Text

	Label.Font =
		Enum.Font.Gotham

	Label.TextSize = 12

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Holder


	RegisterOptionLabel(
		Label
	)


	local function Refresh()

		if Config[ConfigName] then

			Toggle.BackgroundColor3 =
				RED

		else

			Toggle.BackgroundColor3 =
				DARK
		end
	end


	Refresh()


	Connect(
		Toggle.MouseButton1Click:Connect(
			function()

				Config[ConfigName] =
					not Config[ConfigName]

				Refresh()


				if ConfigName ==
					"ShowFOV" then

					FOVCircle.Visible =
						Config.ShowFOV
				end
			end
		)
	)


	return Holder
end


--==================================================
-- AIM OPTIONS
--==================================================

CreateToggle(
	AimPage,
	"AIMBOT",
	48,
	"Aimbot"
)


CreateToggle(
	AimPage,
	"EXIBIR FOV",
	90,
	"ShowFOV"
)


--==================================================
-- TARGET LABEL
--==================================================

local TargetLabel =
	Instance.new("TextLabel")

TargetLabel.Name =
	"TargetLabel"

TargetLabel.Size =
	UDim2.new(
		1,
		-20,
		0,
		20
	)

TargetLabel.Position =
	UDim2.fromOffset(
		10,
		137
	)

TargetLabel.BackgroundTransparency = 1

TargetLabel.Text =
	"PARTE DO ALVO"

TargetLabel.Font =
	Enum.Font.GothamBold

TargetLabel.TextSize = 10

TargetLabel.TextXAlignment =
	Enum.TextXAlignment.Left

TargetLabel.Parent =
	AimPage


RegisterOptionLabel(
	TargetLabel
)


--==================================================
-- TARGET BUTTON
--==================================================

local TargetButton =
	Instance.new("TextButton")

TargetButton.Name =
	"TargetButton"

TargetButton.Size =
	UDim2.new(
		1,
		-20,
		0,
		32
	)

TargetButton.Position =
	UDim2.fromOffset(
		10,
		162
	)

TargetButton.BackgroundColor3 =
	DARK

TargetButton.BorderSizePixel = 0

TargetButton.Text =
	"Head                         ▼"

TargetButton.TextColor3 =
	WHITE

TargetButton.Font =
	Enum.Font.Gotham

TargetButton.TextSize = 12

TargetButton.Parent =
	AimPage


local TargetCorner =
	Instance.new("UICorner")

TargetCorner.CornerRadius =
	UDim.new(0, 5)

TargetCorner.Parent =
	TargetButton


--==================================================
-- DROPDOWN
--==================================================

local Dropdown =
	Instance.new("Frame")

Dropdown.Name =
	"Dropdown"

Dropdown.Size =
	UDim2.new(
		1,
		-20,
		0,
		105
	)

Dropdown.Position =
	UDim2.fromOffset(
		10,
		198
	)

Dropdown.BackgroundColor3 =
	DARK

Dropdown.BorderSizePixel = 0

Dropdown.Visible = false

Dropdown.ZIndex = 20

Dropdown.Parent =
	AimPage


local DropdownCorner =
	Instance.new("UICorner")

DropdownCorner.CornerRadius =
	UDim.new(0, 5)

DropdownCorner.Parent =
	Dropdown


--==================================================
-- TARGET OPTIONS
--==================================================

local TargetOptions = {

	{
		Name = "Head",
		Y = 0
	},

	{
		Name = "Neck",
		Y = 35
	},

	{
		Name = "Chest",
		Y = 70
	},
}


for _, Option in ipairs(
	TargetOptions
) do

	local Button =
		Instance.new("TextButton")

	Button.Size =
		UDim2.new(
			1,
			0,
			0,
			35
		)

	Button.Position =
		UDim2.fromOffset(
			0,
			Option.Y
		)

	Button.BackgroundTransparency = 1

	Button.Text =
		Option.Name

	Button.TextColor3 =
		WHITE

	Button.Font =
		Enum.Font.Gotham

	Button.TextSize = 12

	Button.ZIndex = 21

	Button.Parent =
		Dropdown


	Connect(
		Button.MouseButton1Click:Connect(
			function()

				Config.TargetPart =
					Option.Name

				TargetButton.Text =
					Option.Name ..
					"                         ▼"

				Dropdown.Visible = false
			end
		)
	)
end


Connect(
	TargetButton.MouseButton1Click:Connect(
		function()

			Dropdown.Visible =
				not Dropdown.Visible
		end
	)
)


--==================================================
-- FOV LABEL
--==================================================

local FOVLabel =
	Instance.new("TextLabel")

FOVLabel.Name =
	"FOVLabel"

FOVLabel.Size =
	UDim2.new(
		1,
		-20,
		0,
		20
	)

FOVLabel.Position =
	UDim2.fromOffset(
		10,
		220
	)

FOVLabel.BackgroundTransparency = 1

FOVLabel.Text =
	"FOV: " ..
	tostring(Config.FOV)

FOVLabel.Font =
	Enum.Font.GothamBold

FOVLabel.TextSize = 11

FOVLabel.TextXAlignment =
	Enum.TextXAlignment.Left

FOVLabel.Parent =
	AimPage


RegisterOptionLabel(
	FOVLabel
)


--==================================================
-- FOV BAR
--==================================================

local FOVBar =
	Instance.new("Frame")

FOVBar.Name =
	"FOVBar"

FOVBar.Size =
	UDim2.new(
		1,
		-30,
		0,
		6
	)

FOVBar.Position =
	UDim2.fromOffset(
		15,
		250
	)

FOVBar.BackgroundColor3 =
	DARK

FOVBar.BorderSizePixel = 0

FOVBar.Parent =
	AimPage


local FOVBarCorner =
	Instance.new("UICorner")

FOVBarCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

FOVBarCorner.Parent =
	FOVBar


--==================================================
-- FOV FILL
--==================================================

local InitialFOVAlpha =
	(
		Config.FOV -
		Config.MinFOV
	)
	/
	(
		Config.MaxFOV -
		Config.MinFOV
	)


local FOVFill =
	Instance.new("Frame")

FOVFill.Name =
	"FOVFill"

FOVFill.Size =
	UDim2.new(
		InitialFOVAlpha,
		0,
		1,
		0
	)

FOVFill.BackgroundColor3 =
	RED

FOVFill.BorderSizePixel = 0

FOVFill.Parent =
	FOVBar


--==================================================
-- FOV KNOB
--==================================================

local FOVKnob =
	Instance.new("TextButton")

FOVKnob.Name =
	"FOVKnob"

FOVKnob.Size =
	UDim2.fromOffset(
		14,
		14
	)

FOVKnob.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FOVKnob.Position =
	UDim2.new(
		InitialFOVAlpha,
		0,
		0.5,
		0
	)

FOVKnob.BackgroundColor3 =
	RED

FOVKnob.BorderSizePixel = 0

FOVKnob.Text = ""

FOVKnob.Parent =
	FOVBar


local FOVKnobCorner =
	Instance.new("UICorner")

FOVKnobCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

FOVKnobCorner.Parent =
	FOVKnob


--==================================================
-- FOV SLIDER
--==================================================

local Sliding = false


local function UpdateFOVFromX(X)

	if FOVBar.AbsoluteSize.X <= 0 then
		return
	end


	local Relative =
		(
			X -
			FOVBar.AbsolutePosition.X
		)
		/
		FOVBar.AbsoluteSize.X


	Relative =
		math.clamp(
			Relative,
			0,
			1
		)


	Config.FOV =
		math.floor(
			Config.MinFOV
			+
			(
				(
					Config.MaxFOV -
					Config.MinFOV
				)
				*
				Relative
			)
		)


	FOVFill.Size =
		UDim2.new(
			Relative,
			0,
			1,
			0
		)


	FOVKnob.Position =
		UDim2.new(
			Relative,
			0,
			0.5,
			0
		)


	FOVLabel.Text =
		"FOV: " ..
		tostring(Config.FOV)


	FOVCircle.Size =
		UDim2.fromOffset(
			Config.FOV * 2,
			Config.FOV * 2
		)
end


Connect(
	FOVKnob.MouseButton1Down:Connect(
		function()
			Sliding = true
		end
	)
)


Connect(
	FOVBar.InputBegan:Connect(
		function(Input)

			if
				Input.UserInputType ==
					Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
					Enum.UserInputType.Touch
			then

				Sliding = true

				UpdateFOVFromX(
					Input.Position.X
				)
			end
		end
	)
)


Connect(
	UserInputService.InputChanged:Connect(
		function(Input)

			if not Sliding then
				return
			end


			if
				Input.UserInputType ==
					Enum.UserInputType.MouseMovement
				or
				Input.UserInputType ==
					Enum.UserInputType.Touch
			then

				UpdateFOVFromX(
					Input.Position.X
				)
			end
		end
	)
)


Connect(
	UserInputService.InputEnded:Connect(
		function(Input)

			if
				Input.UserInputType ==
					Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
					Enum.UserInputType.Touch
			then

				Sliding = false
			end
		end
	)
)


--==================================================
-- ESP OPTIONS
--==================================================

CreateToggle(
	ESPP
