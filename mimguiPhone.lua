---@diagnostic disable: undefined-global, lowercase-global
---@diagnostic disable-next-line: duplicate-index
local sampev = require 'samp.events'
local imgui = require 'mimgui'
local encoding = require 'encoding'
local vkeys = require 'vkeys'
local wm = require 'windows.message'
local fa = require 'fAwesome5'

script_name('Mi Phone')
script_authors('neverlessy')
script_version('1.0.0')
script_version_number(2201)


local script = thisScript()
local scriptTag = '{CDAF95}[Mi Phone]{b7b7b7} '
local new = imgui.new
local mainMenu = new.bool()
local callMenu = new.bool()
local sizeX, sizeY = getScreenResolution()
local font = {}
local serverName
encoding.default = 'CP1251'
u8 = encoding.UTF8
cp1251 = encoding.CP1251

telephoneTrash = {{x = 50, y = 176}, {x = 95, y = 206}, {x = 108, y = 225}, {x = 46, y = 325}, {x = 104, y = 176}, {x = 104, y = 311}, {x = 50, y = 311}, {x = 61, y = 181}, {x = 54, y = 190}, {x = 57, y = 196}, {x = 49, y = 218}, {x = 80, y = 194}, {x = 111, y = 314}, {x = 54, y = 314}, {x = 59, y = 320}, {x = 54, y = 188}, {x = 60, y = 196}, {x = 111, y = 188}, {x = 111, y = 199}, {x = 75, y = 185}, {x = 103, y = 321}, {x = 57, y = 208}, {x = 80, y = 185}, {x = 63, y = 184}, {x = 64, y = 185}, {x = 74, y = 184}, {x = 62, y = 191}, {x = 109, y = 184}, {x = 110, y = 179}, {x = 111, y = 176}, {x = 116, y = 192}, {x = 102, y = 305}, {x = 61, y = 307}, {x = 101, y = 307}, {x = 59, y = 305}, {x = 73, y = 305}, {x = 88, y = 305}, {x = 63, y = 293}, {x = 61, y = 291}, {x = 64, y = 297}, {x = 77, y = 291}, {x = 76, y = 292}, {x = 92, y = 295}, {x = 92, y = 292}, {x = 107, y = 293}, {x = 88, y = 213}, {x = 88, y = 229}, {x = 68, y = 311}, {x = 65, y = 310}, {x = 105, y = 311}, {x = 93, y = 293}, {x = 103, y = 288}, {x = 107, y = 273}, {x = 108, y = 269}, {x = 88, y = 288}, {x = 85, y = 271}, {x = 95, y = 272}, {x = 61, y = 274}, {x = 79, y = 273}, {x = 109, y = 255}, {x = 109, y = 255}, {x = 66, y = 253}, {x = 66, y = 257}, {x = 81, y = 252}, {x = 81, y = 251}, {x = 80, y = 261}, {x = 66, y = 241}, {x = 110, y = 239}, {x = 58, y = 277}, {x = 58, y = 228}}
callButtons = {
    ['1'] = 0, -- 1
    ['2'] = 0, -- 2
    ['3'] = 0, -- 3
    ['4'] = 0, -- 4
    ['5'] = 0, -- 5
    ['6'] = 0, -- 6
    ['7'] = 0, -- 7
    ['8'] = 0, -- 8
    ['9'] = 0, -- 9
    ['11'] = 0, -- 0
    ['12'] = 0, -- Call
    ['13'] = 0, -- Exit
    ['14'] = 0, -- DeleteNum
}

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil

    local config = imgui.ImFontConfig()
    config.MergeMode = true
    local glyph_ranges_icon = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    local iconRanges = imgui.new.ImWchar[3](fa.min_range, fa.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromFileTTF('trebucbd.ttf', 14.0, nil, glyph_ranges_icon)
    icon = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/Fa6Pro-solid-900.otf', 16.0, config, iconRanges)

    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    font = {
        [10] = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/SFDR.otf', 15.0, nil, glyph_ranges),
        [45] = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/SFDR.otf', 45.0, nil, glyph_ranges)
    }

    styleInit()
end)

local phoneCallMenu = imgui.OnFrame(
    function() return callMenu[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 3, sizeY / 4), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
        imgui.Begin("callmenu", callMenu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar--[[ + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoScrollWithMouse]])
        imgui.PushFont(font[10])
            imgui.Text(""..serverName, imgui.SetCursorPosX(15.0), imgui.SetCursorPosY(8.0))
            imgui.Text("5G", imgui.SetCursorPosY(8.0), imgui.SetCursorPosX(230.0))
        imgui.PopFont()
        imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 24)
            imgui.Button('1', imgui.ImVec2(40, 40), imgui.SetCursorPosY(295.0), imgui.SetCursorPosX(35.0))
        imgui.PopStyleVar(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

local phoneMainMenu = imgui.OnFrame(
    function() return mainMenu[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 3, sizeY / 4), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
        imgui.Begin("Main Window", mainMenu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar--[[ + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoScrollWithMouse]])
        imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 15)
            imgui.PushFont(font[45])
                imgui.CenterText(""..os.date("%H:%M"), imgui.SetCursorPosY(80.0)) imgui.SameLine()
            imgui.PopFont()
            imgui.PushFont(font[10])
                imgui.Text(""..os.date("%S"), imgui.SetCursorPosX(193.0), imgui.SetCursorPosY(103.0))
                imgui.CenterText(""..os.date("%A, %B %d"), imgui.SetCursorPosY(120.0))
                imgui.Text(""..serverName, imgui.SetCursorPosX(15.0), imgui.SetCursorPosY(8.0))
                imgui.Text("5G", imgui.SetCursorPosY(8.0), imgui.SetCursorPosX(230.0))
            imgui.PopFont()
            imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
                if imgui.Button(fa.ICON_FA_HOME, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(2125)
                end
                if imgui.Button(fa.ICON_FA_TAXI, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(2135)
                end
                if imgui.Button(fa.ICON_FA_DELIVERY, imgui.ImVec2(40, 40), imgui.SetCursorPosY(295.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(2127)
                end
                if imgui.Button(fa.ICON_FA_DOLLAR, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(90.0)) then
                    sampSendClickTextdraw(2129)
                end
                if imgui.Button(fa.ICON_FA_COIN, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(90.0)) then
                    sampSendClickTextdraw(2118)
                end
                if  imgui.Button(fa.ICON_FA_CHEM, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(145.0)) then
                    sampSendClickTextdraw(2139)
                end
                if imgui.Button(fa.ICON_FA_DRIVER, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(145.0)) then
                    sampSendClickTextdraw(2132)
                end
                if imgui.Button(fa.ICON_FA_CARSHARING, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(200.0)) then
                    sampSendClickTextdraw(2141)
                end
                if imgui.Button(fa.ICON_FA_SWORD, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(200.0)) then
                    sampSendClickTextdraw(2122)
                    --sampSendClickTextdraw(callButtons[1])
                end
            imgui.PopStyleVar(1)
            imgui.BeginChild("#navbar", imgui.ImVec2(235, 60), imgui.SetCursorPosY(460.0), imgui.SetCursorPosX(20.0),  false)
                imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.21, 0.75, 0.54, 0.50))
                        if imgui.Button(fa.ICON_FA_PHONE, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(15.0)) then
                            sampSendClickTextdraw(2098)
                            callMenu[0] = not callMenu[0]
                            mainMenu[0] = not mainMenu[0]
                        end
                        if imgui.Button(fa.ICON_FA_COMMENT, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(70.0)) then
                            sampSendClickTextdraw(2102)
                        end
                    imgui.PopStyleColor(1)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.89, 0.66, 0.90, 0.50))
                        if imgui.Button(fa.ICON_FA_USER, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(125.0)) then
                            sampSendClickTextdraw(2100)
                        end
                    imgui.PopStyleColor(1)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.98, 0.38, 0.45, 0.50))
                        if imgui.Button(fa.ICON_FA_BARS, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(180.0)) then
                            sampSendClickTextdraw(2096)
                        end
                    imgui.PopStyleColor(1)
                imgui.PopStyleVar(1)
            imgui.EndChild()
        imgui.PopStyleVar(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(scriptTag..'Скрипт успешно загружен. Автор: {CDAF95}'..script.authors[1], -1)
    while not sampIsPlayerConnected() do wait(0) end
    if sampGetCurrentServerName():match("Arizona RP | (%u%w+-%w+)") then
        serverName = sampGetCurrentServerName():match("Arizona RP | (%u%w+-%w+)")
    else sampGetCurrentServerName():match("Arizona RP | (%u%w+)")
        serverName = sampGetCurrentServerName():match("Arizona RP | (%u%w+)")
    end
    sampRegisterChatCommand('dt', deleteTextdraw)
    sampRegisterChatCommand('fdt', fastDeleteTrash)
    sampRegisterChatCommand('gb', getMenuButtonsIds)
    addEventHandler('onWindowMessage', function(msg, wparam, lparam) -- Сама функция, в которой будем обрабатывать горячие клавиши. Обратите внимание, что данный способ является наиболее верным в плане оптимизации.
        if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then -- Если клавиша нажата
            if wparam == vkeys.VK_X then -- И если это клавиша X
                mainMenu[0] = not mainMenu[0] -- Переключаем состояние рендера
            end
        end
    end)
    while true do wait(-1) end
end

function getMenuButtonsIds(typeMenu)
    if typeMenu == 'callmenu' then
        t = {
            ['1'] = {x = 57, y = 216}, -- 1
            ['2'] = {x = 76, y = 216}, -- 2
            ['3'] = {x = 95, y = 216}, -- 3
            ['4'] = {x = 57, y = 238}, -- 4
            ['5'] = {x = 76, y = 238}, -- 5
            ['6'] = {x = 95, y = 238}, -- 6
            ['7'] = {x = 57, y = 258}, -- 7
            ['8'] = {x = 76, y = 258}, -- 8
            ['9'] = {x = 95, y = 258}, -- 9
            ['11'] = {x = 76, y = 279}, -- 0
            ['12'] = {x = 57, y = 279}, -- Call
            ['13'] = {x = 95, y = 279}, -- Exit
            ['14'] = {x = 110, y = 206}, -- DeleteNum
        }
        for i = 1, 4096 do
            if sampTextdrawIsExists(i) then
                posX, posY = sampTextdrawGetPos(i)
                for v, k in pairs(t) do
                    if math.floor(posX) == tonumber(k.x) and math.floor(posY) == tonumber(k.y) then
                        table.insert(callButtons, v, i)
                    end
                end
            end
        end
    end
    if typeMenu == 'menu' then
        t = {
            '101x235',
            '100x251',
            '101x269', 
            '101x286',
            '86x286',
            '86x268',
            '72x286',
            '71x268',
            '72x250',
            '57x286',
            '56x268',
            '57x250',
            '57x234'
        }
        d = {}
        listTd = ''
        for i = 1, 4096 do
            if sampTextdrawIsExists(i) then
                posX, posY = sampTextdrawGetPos(i)
                for z = 1, #t do
                    buttonX = t[z]:match("(%d+)%w%d+")
                    buttonY = t[z]:match("%d+%w(%d+)")
                    if tonumber(buttonX) == math.floor(posX) and tonumber(buttonY) == math.floor(posY) then
                        table.insert(d, i)
                    end
                end
                --listTd = listTd .. ', {x = '..tostring(math.floor(posX))..', y = '..tostring(math.floor(posY))..'}'
            end
        end
        --print(listTd)
        for i = 1, 13 do
            sampAddChatMessage(scriptTag..''..i..' = '..d[i], -1)
        end
    end
end

function sampev.onShowTextDraw(id, data)
    posX = math.floor(data.position.x)
    posY = math.floor(data.position.y)
    for i = 1, #telephoneTrash do
        if telephoneTrash[i].x == posX and telephoneTrash[i].y == posY then
            return false
        end
    end
end

function deleteTextdraw(int)
    sampTextdrawDelete(int)
    sampAddChatMessage(scriptTag..'Удален текстдрав: {CDAF95}'..int, -1)
    print('[MiPhone] Удален текстдрав: '..int)
end

function miSendClickTextdraw(string)
    
end

function sampev.onServerMessage(color, text)
    if text:match('(.+) достал%Xа%X (.+) из кармана') then
        result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if text:match(tostring(sampGetPlayerNickname(id))..' достал%Xа%X (.+) из кармана') then
            mainMenu[0] = not mainMenu[0]
        end
    end
end

function styleInit()
    local style = imgui.GetStyle()
      local colors = style.Colors
      local clr = imgui.Col
      local ImVec4 = imgui.ImVec4
      local ImVec2 = imgui.ImVec2
  
      style.Alpha = 1.0
      style.ChildRounding = 3.0
      style.WindowRounding = 25.0
      style.GrabRounding = 40.0
      style.GrabMinSize = 20.0
      style.WindowBorderSize = 0.0
      style.FrameRounding = 3.0
  
      colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00);
      colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00);
      colors[clr.ChildBg] = ImVec4(1.00, 1.00, 1.00, 0.05);
      colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00);
      colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 1.00);
      colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00);
      colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75);
      colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00);
      colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00);
      colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.Column] = ImVec4(0.56, 0.56, 0.58, 1.00);
      --colors[clr.ColumnHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      --colors[clr.ColumnActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00);
      colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16);
      --colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39);
      --colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00);
      colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63);
      colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00);
      colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63);
      colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00);
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43);
      --colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73);
  end