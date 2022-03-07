---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: lowercase-global

local sampev = require 'samp.events'
local imgui = require 'mimgui'
local vkeys = require 'vkeys'
local wm = require 'windows.message'
local encoding = require 'encoding'
local ffi = require 'ffi'

local new = imgui.new
local messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
local dialogWindow = new.bool()
local str, sizeof = ffi.string, ffi.sizeof
local sendMessageInput = new.char[62]("")
local sizeX, sizeY = getScreenResolution()
local arr = os.date("*t")
local scriptTag = '{CDAF95}Mi Phone{b7b7b7} '
encoding.default = 'CP1251'
u8 = encoding.UTF8
cp1251 = encoding.CP1251

imgui.OnInitialize(function()
    styleInit()
    imgui.GetIO().IniFilename = nil
end)

local messageFrame = imgui.OnFrame(
    function() return dialogWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(50, 50), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
        imgui.Begin("Main Window", dialogWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
            imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(0.21, 0.75, 0.54, 0.00))
                imgui.BeginChild("#messagesList", imgui.ImVec2(270, 381), imgui.SetCursorPosY(40.0), imgui.SetCursorPosX(20.0),  false)
                    imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(1.00, 1.00, 1.00, 0.05))
                        for i = 1, #messagesList do
                            if messagesList[i] ~= nil then
                                if i == 1 then
                                    imgui.BeginChild("#lastmessage", imgui.ImVec2(235, 60), imgui.SetCursorPosY(0), false)
                                    imgui.Text(u8""..u8(whoSender[i]), imgui.SetCursorPosY(5), imgui.SetCursorPosX(8)) -- Nick
                                    imgui.Text(u8""..u8(dateText[i]), imgui.SetCursorPosY(5), imgui.SetCursorPosX(170)) -- Date
                                    imgui.Text(u8""..u8(msgText[i]), imgui.SetCursorPosY(25), imgui.SetCursorPosX(8)) -- Message
                                imgui.EndChild()
                                else
                                    imgui.BeginChild("#message"..i, imgui.ImVec2(235, 60), imgui.SetCursorPosY((i * 80) - 80), false)
                                    imgui.Text(u8""..u8(whoSender[i]), imgui.SetCursorPosY(5), imgui.SetCursorPosX(8)) -- Nick
                                    imgui.Text(u8""..u8(dateText[i]), imgui.SetCursorPosY(5), imgui.SetCursorPosX(170)) -- Date
                                    imgui.Text(u8""..u8(msgText[i]), imgui.SetCursorPosY(25), imgui.SetCursorPosX(8)) -- Message
                                imgui.EndChild()
                                end
                            end
                        end
                    imgui.PopStyleColor(1)
                imgui.EndChild()
            imgui.PopStyleColor(1)
        imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
            if imgui.InputText(u8"", sendMessageInput, sizeof(sendMessageInput), imgui.SetCursorPosX(47.0), imgui.SetCursorPosY(440.0)) then
                 
            end
            imgui.Text(string.len(u8:decode(str(sendMessageInput))).."/"..((sizeof(sendMessageInput) / 2) - 1), imgui.SetCursorPosY(440.0), imgui.SetCursorPosX(235.0))
            if imgui.Button(u8'Отправить', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(475.0)) then
                sampSendDialogResponse(955, 1 , -1, ''..u8:decode(str(sendMessageInput)))
                imgui.StrCopy(sendMessageInput, '')
            end
            if imgui.Button(u8'Назад', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(505.0)) then
                imgui.StrCopy(sendMessageInput, '')
                messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
                sampCloseCurrentDialogWithButton(0)
            end
        imgui.PopStyleVar(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(scriptTag..'Скрипт успешно загружен. Автор: {CDAF95}neverlessy', -1)
    addEventHandler('onWindowMessage', function(msg, wparam, lparam) -- Сама функция, в которой будем обрабатывать горячие клавиши. Обратите внимание, что данный способ является наиболее верным в плане оптимизации.
        if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then -- Если клавиша нажата
            if wparam == vkeys.VK_X then -- И если это клавиша X
                dialogWindow[0] = not dialogWindow[0] -- Переключаем состояние рендера
            end
        end
    end)
    dialogWindow[0] = not dialogWindow[0]
    while true do wait(-1) end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    print(text)
    if title:find("%u%w+_%u%w+") and button1:find("Отправить") then
        userName = title:match("(%u%w+_%u%w+)")
        separator = '\n'
        messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
        for str in string.gmatch(text, "([^"..separator.."]+)") do
                table.insert(messagesList, str)
        end
        for i = 1, #messagesList do
            dateNum[i], dateText[i], whoSender[i], msgText[i] = string.match(messagesList[i], "%[%{......%}(%d+)%{FFFFFF%} (.+) назад%] %- %{......%}%[(.+)%]%{......%}(.+)")
            if dateNum[i] == nil then
                whoSender[i], msgText[i] = string.match(messagesList[i], "%[%{......%}только что%{......%}%] %- %{......%}%[(.+)%]%{......%}(.+)")
                dateNum[i] = ''
                dateText[i] = 'сейчас'
            end
            if whoSender[i] == 'Вы' then
                whoSender[i] = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
            elseif whoSender[i] == 'Контакт' then
                whoSender[i] = userName
            end
            if dateText[i] == 'дней(я)' then
                dateText[i] = getDateMessage(tonumber(dateNum[i]))
            elseif dateText[i] == 'минут(ы)' then
                dateText[i] = getTimeMessage(tonumber(dateNum[i]))
            elseif dateText[i] == 'час(ов)' then
                if dateNum[i] == '1' or dateNum[i] == '21' then
                    dateText[i] = dateNum[i]..' час'
                elseif dateNum[i] == '2' or dateNum[i] == '3' or dateNum[i] == '4' or dateNum[i] == '22' or dateNum[i] == '23' then
                    dateText[i] = dateNum[i]..' часа'
                else
                    dateText[i] = dateNum[i]..' часов'
                end
            elseif dateText[i] == 'секунд(ы)' then
                dateText[i] = dateNum[i]..' сек'
            end
        end
        return { id, style, title, button1, button2, text }
    end
    if text:find("%{......%}На балансе вашего телефона%: %{......%}(%d+).+%{......%}.") then
        phoneBalance = text:match("%{......%}На балансе вашего телефона%: %{......%}(%d+).+%{......%}.")
        title = scriptTag
        text = text.gsub(text, "%{......%}На балансе вашего телефона%: %{......%}(%d+).+%{......%}.", '{b7b7b7}Баланс телефона: {CDAF95}'..phoneBalance..'${b7b7b7}.\n Этого хватит на {CDAF95}'..(tonumber(phoneBalance) / 25)..' {b7b7b7}сообщений.')
        return { id, style, title, button1, button2, text }
    end
end

function getDateMessage(days) -- я эту ебаторию 3 дня делал, потому что не знал о !*t, до этого был метод в 20 строк :)
    mouth, day, year = os.date("%x", os.time(os.date("!*t")) - (86400 * tonumber(days))):match("(%d+)/(%d+)/(%d+)")
    return day..'.'..mouth..'.'..year
end

function getTimeMessage(minutes)
    hour, minute = os.date("%X", os.time(os.date("*t")) - (60 * tonumber(minutes))):match("(%d+):(%d+):%d+")
    return hour..':'..minute
end

function styleInit()
    local style = imgui.GetStyle()
      local colors = style.Colors
      local clr = imgui.Col
      local ImVec4 = imgui.ImVec4
      local ImVec2 = imgui.ImVec2
  
      style.Alpha = 1.0
      style.ChildRounding = 15.0
      style.WindowRounding = 15.0
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
      colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 0.00);
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