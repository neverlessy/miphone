---@diagnostic disable: undefined-global, lowercase-global
---@diagnostic disable-next-line: duplicate-index
local sampev = require 'samp.events'
local imgui = require 'mimgui'
local encoding = require 'encoding'
local vkeys = require 'vkeys'
local wm = require 'windows.message'
local fa = require 'fAwesome5'
local ffi = require 'ffi'

script_name('Mi Phone')
script_authors('neverlessy')
script_version('0.0.6')
script_version_number(2206)


local script = thisScript()
local scriptTag = '{CDAF95}[Mi Phone]{b7b7b7} '
local new = imgui.new
local sizeX, sizeY = getScreenResolution()
local font = {}
local icon
local serverName
local messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
local messagesListAll, messagesListAllMsg, messagesListAllDateNum, messagesListAllDateText, messagesListAllstatusMsg = {}, {}, {}, {}, {}
local mainMenu, callMenu, messageMenu, messagesMenu = new.bool(), new.bool(), new.bool(), new.bool()
local str, sizeof = ffi.string, ffi.sizeof
local sendMessageInput = new.char[62]("")
local arr = os.date("*t")

encoding.default = 'CP1251'
u8 = encoding.UTF8
cp1251 = encoding.CP1251

telephoneTrash = {{x = 87, y = 242}, {x = 67, y = 293}, {x = 65, y = 289}, {x = 64, y = 286}, {x = 111, y = 315}, {x = 102, y = 286}, {x = 87, y = 283}, {x = 106, y = 263}, {x = 87, y = 263}, {x = 69, y = 263}, {x = 68, y = 242}, {x = 106, y = 242}, {x = 68, y = 242}, {x = 106, y = 221}, {x = 87, y = 221}, {x = 68, y = 221}, {x = 111, y = 215}, {x = 57, y = 217}, {x = 57, y = 202}, {x = 50, y = 176}, {x = 95, y = 206}, {x = 108, y = 225}, {x = 46, y = 325}, {x = 104, y = 176}, {x = 104, y = 311}, {x = 50, y = 311}, {x = 61, y = 181}, {x = 54, y = 190}, {x = 57, y = 196}, {x = 49, y = 218}, {x = 80, y = 194}, {x = 111, y = 314}, {x = 54, y = 314}, {x = 59, y = 320}, {x = 54, y = 188}, {x = 60, y = 196}, {x = 111, y = 188}, {x = 111, y = 199}, {x = 75, y = 185}, {x = 103, y = 321}, {x = 57, y = 208}, {x = 80, y = 185}, {x = 63, y = 184}, {x = 64, y = 185}, {x = 74, y = 184}, {x = 62, y = 191}, {x = 109, y = 184}, {x = 110, y = 179}, {x = 111, y = 176}, {x = 116, y = 192}, {x = 102, y = 305}, {x = 61, y = 307}, {x = 101, y = 307}, {x = 59, y = 305}, {x = 73, y = 305}, {x = 88, y = 305}, {x = 63, y = 293}, {x = 61, y = 291}, {x = 64, y = 297}, {x = 77, y = 291}, {x = 76, y = 292}, {x = 92, y = 295}, {x = 92, y = 292}, {x = 107, y = 293}, {x = 88, y = 213}, {x = 88, y = 229}, {x = 68, y = 311}, {x = 65, y = 310}, {x = 105, y = 311}, {x = 93, y = 293}, {x = 103, y = 288}, {x = 107, y = 273}, {x = 108, y = 269}, {x = 88, y = 288}, {x = 85, y = 271}, {x = 95, y = 272}, {x = 61, y = 274}, {x = 79, y = 273}, {x = 109, y = 255}, {x = 109, y = 255}, {x = 66, y = 253}, {x = 66, y = 257}, {x = 81, y = 252}, {x = 81, y = 251}, {x = 80, y = 261}, {x = 66, y = 241}, {x = 110, y = 239}, {x = 58, y = 277}, {x = 58, y = 228}}
callButtons, menuButtons = {}, {}
huaweiTelephoneTrash = {{x =113, y = 202}, {x =89, y = 201}, {x =56, y = 184}, {x =66, y = 225}, {x =61, y = 238}, {x =115, y = 238}, {x =110, y = 274}, {x =101, y = 279}, {x =67, y = 279}, {x =56, y = 271}, {x =56, y = 271}, {x =71, y = 280}, {x =68, y = 284}, {x =88, y = 294},{x =92, y = 224}, {x =87, y = 223}, {x =57, y = 250}, {x =61, y = 252}, {x =61, y = 224},{x =64, y = 312}, {x =88, y = 307}, {x =91, y = 181}, {x =88, y = 184}, {x =88, y = 187}, {x =88, y = 194}, {x =88, y = 191}, {x =109, y = 192}, {x =108, y = 196}, {x =88, y = 208}, {x =50, y = 181}, {x =67, y = 190}, {x =56, y = 218}, {x =73, y = 240}, {x =74, y = 228}, {x =69, y = 226}, {x =104, y = 240}, {x =94, y = 284}, {x =90, y = 287}, {x =77, y = 286}, {x =71, y = 284}, {x =103, y = 258}, {x =107, y = 253}, {x =111, y = 250}, {x =98, y = 256}, {x =111, y = 223}, {x =102, y = 230}, {x =96, y = 229}, {x =99, y = 230}, {x =89, y = 228}, {x =89, y = 256}, {x =92, y = 252}, {x =58, y = 256}, {x =58, y = 228}, {x =81, y = 250}, {x =87, y = 250}, {x =74, y = 254}, {x =74, y = 270}, {x =104, y = 267}, {x =81, y = 223}, {x =57, y = 223}, {x =56, y = 191}, {x =88, y = 204}, {x =102, y = 234}, {x =104, y = 239}, {x =107, y = 252}, {x =88, y = 252}, {x =70, y = 252}, {x =64, y = 246}, {x =84, y = 231}, {x =88, y = 283}, {x =59, y = 310}, {x =82, y = 272}, {x =70, y = 264}, {x =105, y = 191},{x =57, y = 210},{x =50, y = 173}, {x =57, y = 185}, {x =63, y = 184}, {x =109, y = 194}, {x =95, y = 236}, {x =46, y = 322}, {x =57, y = 194}, {x =68, y = 285}, {x =66, y = 281}, {x =64, y = 279}, {x =88, y = 275}, {x =102, y = 278}, {x =107, y = 255}, {x =88, y = 255}, {x =69, y = 255}, {x =68, y = 234}, {x =88, y = 234}, {x =107, y = 234}, {x =107, y = 214}, {x =88, y = 214}, {x =68, y = 214}, {x =112, y = 207},{x =50, y = 173}, {x =57, y = 185}, {x =63, y = 184}, {x =109, y = 194}, {x =95, y = 236}, {x =46, y = 322},{x =90, y = 319}, {x =108, y = 323}, {x =102, y = 316}, {x =89, y = 318}, {x =83, y = 322}, {x =88, y = 316}, {x =83, y = 323}, {x =76, y = 318}, {x =73, y = 316}, {x =77, y = 319}, {x =62, y = 322}, {x =58, y = 316}, {x =58, y = 314}, {x =50, y = 309}, {x =62, y = 179}, {x =62, y = 179}, {x =56, y = 183}, {x =55, y = 188}, {x =56, y = 183}, {x =59, y = 178}, {x =86, y = 176}, {x =79, y = 176}, {x =86, y = 182}, {x =85, y = 180}, {x =86, y = 181}, {x =87, y = 182}, {x =81, y = 182}, {x =105, y = 173}, {x =111, y = 179}, {x =119, y = 180}, {x =106, y = 185}, {x =106, y = 185}, {x =114, y = 185}, {x =88, y = 202}, {x =88, y = 219}, {x =66, y = 234}, {x =66, y = 247}, {x =65, y = 251}, {x =80, y = 246}, {x =80, y = 244}, {x =80, y = 253}, {x =110, y = 232}, {x =109, y = 250}, {x =107, y = 266}, {x =108, y = 263}, {x =94, y = 265}, {x =85, y = 264}, {x =79, y = 266}, {x =61, y = 267}, {x =61, y = 281}, {x =67, y = 285}, {x =65, y = 284}, {x =88, y = 281}, {x =100, y = 281}, {x =104, y = 285}, {x =103, y = 281}, {x =104, y = 309}, {x =105, y = 302}, {x =92, y = 303}, {x =77, y = 301}, {x =75, y = 303}, {x =64, y = 307}, {x =62, y = 303}, {x =60, y = 301}, {x =109, y = 250}}
    xiaomiTelephoneTrash = {{x =56, y = 182}, {x =61, y = 238}, {x =115, y = 238}, {x =66, y = 225}, {x =113, y = 198}, {x =88, y = 198}, {x =110, y = 274}, {x =101, y = 279}, {x =88, y = 283}, {x =67, y = 279}, {x =68, y = 274}, {x =56, y = 271}, {x =61, y = 267}, {x =56, y = 271}, {x =88, y = 294}, {x =68, y = 284}, {x =71, y = 280},{x =105, y = 189}, {x =70, y = 262}, {x =50, y = 173}, {x =53, y = 177}, {x =61, y = 179}, {x =55, y = 187}, {x =54, y = 178}, {x =54, y = 178}, {x =57, y = 185}, {x =61, y = 186}, {x =56, y = 180}, {x =57, y = 182}, {x =63, y = 180}, {x =67, y = 175}, {x =73, y = 179}, {x =71, y = 178}, {x =85, y = 182}, {x =72, y = 180}, {x =97, y = 175}, {x =94, y = 179}, {x =104, y = 173}, {x =109, y = 168}, {x =110, y = 165}, {x =108, y = 173}, {x =111, y = 178}, {x =115, y = 181}, {x =109, y = 194}, {x =91, y = 186}, {x =87, y = 220}, {x =87, y = 204}, {x =61, y = 228}, {x =68, y = 232}, {x =65, y = 231}, {x =100, y = 228}, {x =104, y = 232}, {x =95, y = 236}, {x =110, y = 248}, {x =110, y = 264}, {x =107, y = 281}, {x =108, y = 278}, {x =109, y = 264}, {x =114, y = 323}, {x =63, y = 322}, {x =54, y = 328}, {x =46, y = 322}, {x =59, y = 316}, {x =103, y = 316}, {x =89, y = 316}, {x =74, y = 316}, {x =50, y = 308}, {x =104, y = 308}, {x =107, y = 303}, {x =93, y = 304}, {x =90, y = 300}, {x =89, y = 298}, {x =78, y = 301}, {x =76, y = 303}, {x =65, y = 307}, {x =63, y = 303}, {x =61, y = 301}, {x =61, y = 285}, {x =80, y = 283}, {x =95, y = 282}, {x =86, y = 281}, {x =80, y = 270}, {x =81, y = 262}, {x =81, y = 261}, {x =66, y = 267}, {x =66, y = 264}, {x =66, y = 251}, {x =56, y = 244}, {x =56, y = 244}, {x =103, y = 297}, {x =57, y = 192}, {x =107, y = 256}, {x =88, y = 256}, {x =69, y = 256}, {x =68, y = 235}, {x =68, y = 214}, {x =63, y = 210}, {x =88, y = 214}, {x =107, y = 214}, {x =107, y = 235}, {x =88, y = 235}, {x =64, y = 280}, {x =88, y = 276}, {x =102, y = 279}, {x =87, y = 306}, {x =85, y = 303}, {x =83, y = 300}, {x =50, y = 177}, {x =91, y = 177}, {x =88, y = 185}, {x =88, y = 186}, {x =88, y = 184}, {x =88, y = 188}, {x =67, y = 186}, {x =109, y = 188}, {x =108, y = 192}, {x =87, y = 206}, {x =57, y = 210}, {x =56, y = 217}, {x =63, y = 312}, {x =87, y = 306}, {x =94, y = 282}, {x =89, y = 285}, {x =77, y = 284}, {x =71, y = 282}, {x =58, y = 274}, {x =74, y = 268}, {x =74, y = 252}, {x =81, y = 248}, {x =58, y = 254}, {x =61, y = 250}, {x =57, y = 248}, {x =104, y = 265}, {x =98, y = 254}, {x =103, y = 256}, {x =107, y = 251}, {x =111, y = 248}, {x =111, y = 220}, {x =104, y = 238}, {x =99, y = 228}, {x =96, y = 227}, {x =102, y = 228}, {x =89, y = 226}, {x =81, y = 220}, {x =89, y = 254}, {x =92, y = 250}, {x =87, y = 248}, {x =92, y = 222}, {x =69, y = 224}, {x =58, y = 226}, {x =61, y = 222}, {x =57, y = 220}, {x =74, y = 226}, {x =73, y = 238}, {x =56, y = 189}, {x =88, y = 202}, {x =84, y = 229}, {x =64, y = 244}, {x =104, y = 237}, {x =102, y = 232}, {x =107, y = 250}, {x =88, y = 250}, {x =70, y = 250}, {x =88, y = 281}, {x =59, y = 308}, {x =82, y = 270}, {x =85, y = 262}}
    pixelTelephoneTrash = {{x =58, y = 229}, {x =113, y = 209}, {x =88, y = 209}, {x =87, y = 194}, {x =55, y = 192}, {x =58, y = 229}, {x =66, y = 233}, {x =61, y = 246}, {x =114, y = 246}, {x =60, y = 275}, {x =55, y = 279}, {x =110, y = 281}, {x =100, y = 286}, {x =67, y = 281}, {x =66, y = 286}, {x =55, y = 279}, {x =71, y = 288}, {x =68, y = 292}, {x =88, y = 302},{x =57, y = 202}, {x =105, y = 198}, {x =55, y = 198}, {x =88, y = 211}, {x =102, y = 241}, {x =104, y = 246}, {x =84, y = 238}, {x =64, y = 253}, {x =69, y = 259}, {x =87, y = 259}, {x =107, y = 259}, {x =88, y = 290}, {x =82, y = 279}, {x =69, y = 271}, {x =58, y = 317}, {x =50, y = 189}, {x =66, y = 198}, {x =87, y = 200}, {x =91, y = 189}, {x =87, y = 195}, {x =88, y = 196}, {x =87, y = 196}, {x =88, y = 199}, {x =108, y = 199}, {x =107, y = 204}, {x =87, y = 215}, {x =55, y = 225}, {x =87, y = 320}, {x =88, y = 314}, {x =63, y = 320}, {x =89, y = 293}, {x =94, y = 290}, {x =71, y = 290}, {x =77, y = 293}, {x =103, y = 274}, {x =98, y = 263}, {x =107, y = 259}, {x =111, y = 257}, {x =103, y = 264}, {x =111, y = 229}, {x =98, y = 236}, {x =103, y = 246}, {x =101, y = 236}, {x =96, y = 235}, {x =88, y = 234}, {x =88, y = 262}, {x =91, y = 258}, {x =80, y = 257}, {x =73, y = 260}, {x =73, y = 277}, {x =58, y = 276}, {x =58, y = 262}, {x =61, y = 258}, {x =87, y = 257}, {x =57, y = 257}, {x =73, y = 246}, {x =73, y = 235}, {x =69, y = 232}, {x =91, y = 230}, {x =80, y = 229}, {x =87, y = 229}, {x =57, y = 229}, {x =58, y = 234}, {x =61, y = 230},{x =50, y = 176}, {x =61, y = 181}, {x =75, y = 185}, {x =63, y = 184}, {x =74, y = 184}, {x =80, y = 185}, {x =64, y = 185}, {x =62, y = 191}, {x =57, y = 196}, {x =60, y = 196}, {x =54, y = 190}, {x =54, y = 188}, {x =80, y = 194}, {x =95, y = 206}, {x =111, y = 199}, {x =116, y = 192}, {x =111, y = 188}, {x =109, y = 184}, {x =110, y = 179}, {x =104, y = 176}, {x =111, y = 176}, {x =57, y = 208}, {x =88, y = 213}, {x =49, y = 218}, {x =58, y = 228}, {x =88, y = 229}, {x =108, y = 225}, {x =110, y = 239}, {x =109, y = 255}, {x =66, y = 241}, {x =66, y = 253}, {x =66, y = 257}, {x =81, y = 252}, {x =81, y = 251}, {x =80, y = 261}, {x =103, y = 321}, {x =111, y = 314}, {x =104, y = 311}, {x =101, y = 307}, {x =102, y = 305}, {x =105, y = 311}, {x =88, y = 305}, {x =73, y = 305}, {x =61, y = 307}, {x =68, y = 311}, {x =59, y = 305}, {x =65, y = 310}, {x =54, y = 314}, {x =50, y = 311}, {x =59, y = 320}, {x =46, y = 325}, {x =64, y = 297}, {x =63, y = 293}, {x =61, y = 291}, {x =77, y = 291}, {x =76, y = 292}, {x =92, y = 295}, {x =92, y = 292}, {x =88, y = 288}, {x =93, y = 293}, {x =107, y = 293}, {x =103, y = 288}, {x =107, y = 273}, {x =108, y = 269}, {x =95, y = 272}, {x =85, y = 271}, {x =79, y = 273}, {x =61, y = 274}, {x =58, y = 277}, {x =109, y = 255}, {x =111, y = 315}, {x =68, y = 242}, {x =69, y = 263}, {x =67, y = 293}, {x =65, y = 289}, {x =64, y = 286}, {x =87, y = 283}, {x =102, y = 286}, {x =106, y = 263}, {x =87, y = 263}, {x =87, y = 242}, {x =106, y = 242}, {x =106, y = 221}, {x =87, y = 221}, {x =68, y = 221}, {x =58, y = 228}, {x =57, y = 217}}
    iphoneTelephoneTrash = {{x =50, y = 173}, {x =51, y = 174}, {x =52, y = 175}, {x =61, y = 178}, {x =67, y = 177}, {x =61, y = 180}, {x =62, y = 182}, {x =55, y = 187}, {x =55, y = 188}, {x =74, y = 184}, {x =82, y = 183}, {x =57, y = 189}, {x =63, y = 197}, {x =50, y = 188}, {x =87, y = 197}, {x =102, y = 175}, {x =103, y = 174}, {x =104, y = 173}, {x =95, y = 177}, {x =109, y = 184}, {x =110, y = 182}, {x =112, y = 181}, {x =116, y = 183}, {x =98, y = 179}, {x =105, y = 202}, {x =68, y = 216}, {x =57, y = 206}, {x =66, y = 233}, {x =59, y = 236}, {x =66, y = 247}, {x =65, y = 251}, {x =61, y = 267}, {x =59, y = 278}, {x =61, y = 279}, {x =65, y = 282}, {x =68, y = 283}, {x =89, y = 281}, {x =101, y = 279}, {x =104, y = 283}, {x =103, y = 281}, {x =46, y = 322}, {x =50, y = 308}, {x =51, y = 307}, {x =52, y = 305}, {x =58, y = 315}, {x =73, y = 315}, {x =88, y = 315}, {x =102, y = 315}, {x =104, y = 308}, {x =103, y = 307}, {x =102, y = 305}, {x =105, y = 301}, {x =91, y = 301}, {x =77, y = 301}, {x =75, y = 302}, {x =62, y = 302}, {x =60, y = 301}, {x =64, y = 307}, {x =62, y = 295}, {x =95, y = 265}, {x =90, y = 235}, {x =76, y = 264}, {x =77, y = 263}, {x =86, y = 264}, {x =107, y = 266}, {x =109, y = 248}, {x =95, y = 248}, {x =108, y = 263}, {x =79, y = 254}, {x =80, y = 246}, {x =80, y = 244}, {x =95, y = 248}, {x =110, y = 231}, {x =57, y = 195}, {x =87, y = 306}, {x =85, y = 303}, {x =83, y = 300}, {x =62, y = 295}, {x =64, y = 280}, {x =88, y = 276}, {x =102, y = 279}, {x =107, y = 256}, {x =88, y = 256}, {x =69, y = 256}, {x =68, y = 235}, {x =88, y = 235}, {x =107, y = 235}, {x =107, y = 214}, {x =88, y = 214}, {x =68, y = 214}, {x =63, y = 210}, {x =56, y = 191}, {x =62, y = 295}, {x =59, y = 310}, {x =88, y = 283}, {x =82, y = 272}, {x =85, y = 264}, {x =70, y = 264}, {x =107, y = 252}, {x =88, y = 252}, {x =70, y = 252}, {x =64, y = 246}, {x =84, y = 231}, {x =102, y = 234}, {x =104, y = 239}, {x =88, y = 204}, {x =105, y = 191}, {x =50, y = 173}, {x =51, y = 174}, {x =52, y = 175}, {x =50, y = 188}, {x =50, y = 181}, {x =61, y = 178}, {x =67, y = 177}, {x =61, y = 180}, {x =62, y = 182}, {x =67, y = 190}, {x =63, y = 197}, {x =55, y = 187}, {x =55, y = 188}, {x =57, y = 189}, {x =74, y = 184}, {x =82, y = 183}, {x =102, y = 175}, {x =104, y = 173}, {x =103, y = 174}, {x =95, y = 177}, {x =91, y = 181}, {x =88, y = 187}, {x =98, y = 179}, {x =88, y = 188}, {x =87, y = 191}, {x =110, y = 182}, {x =109, y = 184}, {x =112, y = 181}, {x =116, y = 183}, {x =109, y = 192}, {x =108, y = 196}, {x =105, y = 202}, {x =88, y = 191}, {x =87, y = 208}, {x =55, y = 218}, {x =104, y = 308}, {x =103, y = 307}, {x =102, y = 305}, {x =88, y = 307}, {x =64, y = 312}, {x =50, y = 308}, {x =51, y = 307}, {x =52, y = 305}, {x =46, y = 322}, {x =62, y = 294}, {x =71, y = 284}, {x =94, y = 284}, {x =89, y = 287}, {x =77, y = 286}, {x =73, y = 270}, {x =74, y = 254}, {x =80, y = 250}, {x =103, y = 258}, {x =107, y = 253}, {x =111, y = 250}, {x =111, y = 223}, {x =73, y = 240}, {x =73, y = 228}, {x =69, y = 226}, {x =80, y = 223}, {x =98, y = 230}, {x =96, y = 229}, {x =102, y = 230}, {x =103, y = 240}, {x =98, y = 256}, {x =88, y = 256}, {x =103, y = 267}, {x =58, y = 256}, {x =61, y = 252}, {x =91, y = 252}, {x =88, y = 228}, {x =91, y = 224}, {x =58, y = 228}, {x =61, y = 224}, {x =57, y = 250}, {x =57, y = 223}, {x =87, y = 223}, {x =87, y = 250}, {x =50, y = 173}, {x =51, y = 174}, {x =52, y = 175}, {x =50, y = 188}, {x =50, y = 181}, {x =61, y = 178}, {x =61, y = 180}, {x =62, y = 182}, {x =67, y = 177}, {x =74, y = 184}, {x =82, y = 183}, {x =55, y = 187}, {x =55, y = 188}, {x =57, y = 189}, {x =55, y = 187}, {x =67, y = 190}, {x =63, y = 197}, {x =87, y = 191}, {x =88, y = 187}, {x =91, y = 181}, {x =98, y = 179}, {x =104, y = 173}, {x =103, y = 174}, {x =102, y = 175}, {x =95, y = 177}, {x =109, y = 184}, {x =110, y = 182}, {x =112, y = 181}, {x =116, y = 183}, {x =88, y = 188}, {x =88, y = 191}, {x =109, y = 192}, {x =113, y = 202}, {x =105, y = 202}, {x =108, y = 196}, {x =89, y = 201}, {x =115, y = 238}, {x =61, y = 238}, {x =66, y = 225}, {x =61, y = 267}, {x =56, y = 271}, {x =68, y = 284}, {x =67, y = 279}, {x =68, y = 274}, {x =56, y = 271}, {x =88, y = 283}, {x =71, y = 280}, {x =101, y = 279}, {x =110, y = 274}, {x =88, y = 294}, {x =62, y = 294}, {x =104, y = 308}, {x =103, y = 307}, {x =102, y = 305}, {x =51, y = 307}, {x =50, y = 308}, {x =52, y = 305}, {x =46, y = 322}, {x =64, y = 312}, {x =88, y = 307}, {x =109, y = 184}, {x =110, y = 182}, {x =112, y = 181}, {x =103, y = 174}, {x =104, y = 173}, {x =102, y = 175}, {x =87, y = 191}, {x =88, y = 187}, {x =95, y = 177}, {x =98, y = 179}, {x =91, y = 181}, {x =88, y = 188}, {x =88, y = 191}, {x =89, y = 201}}
    samsungTelephoneTrash = {{x =51, y = 176}, {x =62, y = 190}, {x =63, y = 190}, {x =56, y = 191}, {x =57, y = 189}, {x =57, y = 189}, {x =54, y = 196}, {x =26, y = 199}, {x =51, y = 200}, {x =62, y = 182}, {x =68, y = 185}, {x =84, y = 185}, {x =97, y = 190}, {x =96, y = 191}, {x =99, y = 189}, {x =105, y = 189}, {x =111, y = 189}, {x =111, y = 192}, {x =103, y = 188}, {x =103, y = 191}, {x =109, y = 191}, {x =105, y = 176}, {x =118, y = 189}, {x =112, y = 192}, {x =109, y = 184}, {x =41, y = 327}, {x =71, y = 331}, {x =63, y = 323}, {x =68, y = 316}, {x =58, y = 314}, {x =51, y = 312}, {x =74, y = 314}, {x =85, y = 315}, {x =89, y = 314}, {x =106, y = 319}, {x =105, y = 314}, {x =105, y = 312}, {x =102, y = 322}, {x =118, y = 323}, {x =108, y = 331}, {x =107, y = 298}, {x =94, y = 301}, {x =93, y = 302}, {x =75, y = 299}, {x =78, y = 298}, {x =63, y = 300}, {x =63, y = 303}, {x =60, y = 297}, {x =69, y = 282}, {x =67, y = 281}, {x =62, y = 278}, {x =90, y = 280}, {x =90, y = 278}, {x =102, y = 278}, {x =106, y = 282}, {x =105, y = 279}, {x =109, y = 264}, {x =110, y = 261}, {x =96, y = 262}, {x =87, y = 261}, {x =83, y = 271}, {x =77, y = 262}, {x =61, y = 265}, {x =66, y = 246}, {x =66, y = 242}, {x =82, y = 247}, {x =79, y = 245}, {x =96, y = 251}, {x =113, y = 248}, {x =113, y = 247}, {x =112, y = 226}, {x =109, y = 208}, {x =89, y = 212}, {x =89, y = 231}, {x =97, y = 242}, {x =97, y = 240}, {x =75, y = 236}, {x =66, y = 228}, {x =57, y = 201}, {x =70, y = 218}, {x =66, y = 216}, {x =89, y = 218}, {x =108, y = 218}, {x =108, y = 239}, {x =89, y = 239}, {x =70, y = 239}, {x =70, y = 259}, {x =89, y = 259}, {x =108, y = 259}, {x =103, y = 282}, {x =89, y = 279}, {x =65, y = 284}, {x =84, y = 304}, {x =86, y = 306}, {x =88, y = 310}, {x =118, y = 323}, {x =102, y = 322}, {x =63, y = 323}, {x =118, y = 189}, {x =108, y = 331}, {x =118, y = 323}, {x =106, y = 319}, {x =102, y = 322}, {x =71, y = 331}, {x =41, y = 327}, {x =57, y = 319}, {x =51, y = 312}, {x =68, y = 316}, {x =51, y = 176}, {x =50, y = 187}, {x =56, y = 191}, {x =68, y = 185}, {x =62, y = 182}, {x =62, y = 190}, {x =62, y = 189}, {x =57, y = 189}, {x =51, y = 200}, {x =68, y = 196}, {x =57, y = 189}, {x =63, y = 323}, {x =64, y = 312}, {x =85, y = 315}, {x =105, y = 312}, {x =89, y = 306}, {x =105, y = 176}, {x =109, y = 184}, {x =111, y = 189}, {x =105, y = 189}, {x =96, y = 191}, {x =89, y = 192}, {x =89, y = 193}, {x =89, y = 198}, {x =103, y = 191}, {x =97, y = 190}, {x =94, y = 187}, {x =99, y = 189}, {x =103, y = 188}, {x =84, y = 185}, {x =111, y = 192}, {x =109, y = 191}, {x =112, y = 192}, {x =110, y = 198}, {x =118, y = 189}, {x =109, y = 202}, {x =109, y = 208}, {x =88, y = 211}, {x =55, y = 222}, {x =95, y = 287}, {x =90, y = 290}, {x =72, y = 287}, {x =78, y = 289}, {x =104, y = 270}, {x =104, y = 261}, {x =108, y = 256}, {x =112, y = 253}, {x =104, y = 242}, {x =99, y = 233}, {x =97, y = 232}, {x =102, y = 233}, {x =112, y = 225}, {x =74, y = 242}, {x =74, y = 231}, {x =70, y = 229}, {x =74, y = 273}, {x =74, y = 257}, {x =81, y = 253}, {x =99, y = 259}, {x =89, y = 258}, {x =59, y = 258}, {x =62, y = 255}, {x =92, y = 255}, {x =89, y = 231}, {x =92, y = 227}, {x =59, y = 231}, {x =62, y = 227}, {x =58, y = 253}, {x =58, y = 225}, {x =81, y = 225}, {x =88, y = 225}, {x =88, y = 253}, {x =51, y = 176}, {x =89, y = 207}, {x =89, y = 198}, {x =89, y = 192}, {x =94, y = 187}, {x =84, y = 185}, {x =57, y = 189}, {x =56, y = 191}, {x =62, y = 182}, {x =68, y = 185}, {x =55, y = 188}, {x =50, y = 187}, {x =57, y = 189}, {x =62, y = 190}, {x =68, y = 196}, {x =51, y = 200}, {x =67, y = 225}, {x =62, y = 238}, {x =115, y = 238}, {x =62, y = 267}, {x =55, y = 271}, {x =68, y = 279}, {x =72, y = 280}, {x =71, y = 331}, {x =63, y = 323}, {x =51, y = 312}, {x =57, y = 319}, {x =41, y = 327}, {x =68, y = 316}, {x =64, y = 312}, {x =85, y = 315}, {x =89, y = 306}, {x =105, y = 312}, {x =106, y = 319}, {x =102, y = 322}, {x =108, y = 331}, {x =118, y = 323}, {x =111, y = 274}, {x =102, y = 279}, {x =68, y = 274}, {x =55, y = 271}, {x =89, y = 283}, {x =69, y = 284}, {x =89, y = 294}, {x =114, y = 208}, {x =109, y = 184}, {x =105, y = 176}, {x =99, y = 189}, {x =97, y = 190}, {x =96, y = 191}, {x =89, y = 193}, {x =103, y = 188}, {x =105, y = 189}, {x =103, y = 191}, {x =111, y = 189}, {x =118, y = 189}, {x =111, y = 192}, {x =109, y = 191}, {x =112, y = 192}, {x =110, y = 198}, {x =109, y = 202}, {x =109, y = 208}, {x =51, y = 176}, {x =57, y = 189}, {x =56, y = 191}, {x =51, y = 200}, {x =56, y = 199}, {x =57, y = 189}, {x =26, y = 199}, {x =62, y = 182}, {x =68, y = 185}, {x =62, y = 190}, {x =54, y = 196}, {x =84, y = 185}, {x =99, y = 189}, {x =97, y = 190}, {x =96, y = 191}, {x =105, y = 189}, {x =111, y = 192}, {x =109, y = 191}, {x =103, y = 188}, {x =109, y = 184}, {x =105, y = 176}, {x =118, y = 189}, {x =111, y = 189}, {x =103, y = 191}, {x =112, y = 192}, {x =105, y = 196}, {x =109, y = 208}, {x =88, y = 210}, {x =104, y = 244}, {x =102, y = 239}, {x =84, y = 237}, {x =75, y = 236}, {x =64, y = 251}, {x =82, y = 247}, {x =88, y = 257}, {x =70, y = 257}, {x =107, y = 257}, {x =88, y = 288}, {x =90, y = 280}, {x =82, y = 277}, {x =83, y = 271}, {x =85, y = 269}, {x =70, y = 270}, {x =71, y = 331}, {x =63, y = 323}, {x =68, y = 316}, {x =59, y = 316}, {x =51, y = 312}, {x =41, y = 327}, {x =85, y = 315}, {x =102, y = 322}, {x =105, y = 312}, {x =106, y = 319}, {x =118, y = 323}, {x =108, y = 331}}

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil

    local config = imgui.ImFontConfig()
    config.MergeMode = true
    local glyph_ranges_icon = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    local iconRanges = imgui.new.ImWchar[3](fa.min_range, fa.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromFileTTF('trebucbd.ttf', 14.0, nil, glyph_ranges_icon)
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    --icon = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/Fa6Pro-solid-900.otf', 16.0, config, iconRanges)
    --otherIcon = imgui.GetIO().Fonts:AddFontFromFileTTF('trebucbd.ttf', 24.0, nil, glyph_rangesglyph_ranges_icon)
    --icon = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/Fa6Pro-solid-900.otf', 26.0, config, iconRanges)
    font = {
        [10] = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/SFDR.otf', 15.0, nil, glyph_ranges),
        icon = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/Fa6Pro-solid-900.otf', 16.0, config, iconRanges),
        [45] = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/SFDR.otf', 45.0, nil, glyph_ranges),
        icon = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory()..'/resource/MiPhone/fonts/Fa6Pro-solid-900.otf', 26.0, config, iconRanges)
    }
    styleInit()
end)

local phoneCallMenu = imgui.OnFrame(
    function() return callMenu[0] end,
    function(player)
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
            imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 3, sizeY / 4), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
            imgui.Begin("Main Window", callMenu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar--[[ + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoScrollWithMouse]])
            local DL = imgui.GetWindowDrawList()
            imgui.PushFont(font[10])
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.00, 0.00, 0.00, 1.00))
                    imgui.Text(""..serverName, imgui.SetCursorPosX(15.0), imgui.SetCursorPosY(8.0))
                    imgui.Text("5G", imgui.SetCursorPosY(8.0), imgui.SetCursorPosX(230.0))
                imgui.PopFont()
                imgui.PushFont(font[45])
                    if sampTextdrawGetString(2121) ~= '_' then
                        imgui.CenterText(""..sampTextdrawGetString(2121), imgui.SetCursorPosY(60.0))
                    end
            imgui.PopStyleColor(1)
            imgui.PopFont()
            imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 94)
                imgui.PushFont(font[45])
                    for i = 1, 3 do
                        for z = 1, 3 do
                            imgui.SetCursorPos(imgui.ImVec2(-25 + (i * 80), 100 + (z * 80)))
                            local p = imgui.GetCursorScreenPos()
                            local radius = 30.00
                            local polygons = radius * 1.5
                            DL:AddCircleFilled(p, radius, 0x70545454, polygons, 0)
                        end
                    end

                    imgui.SetCursorPos(imgui.ImVec2(55, 420))
                    local p = imgui.GetCursorScreenPos()
                    local radius = 30.00
                    local polygons = radius * 1.5
                    DL:AddCircleFilled(p, radius, 0xFF5AF9A2, polygons, 0)

                    imgui.SetCursorPos(imgui.ImVec2(135, 420))

                    local p = imgui.GetCursorScreenPos()
                    DL:AddCircleFilled(p, radius, 0x70545454, polygons, 0)

                    imgui.SetCursorPos(imgui.ImVec2(215, 420))

                    local p = imgui.GetCursorScreenPos()
                    DL:AddCircleFilled(p, radius, 0xFF6565FF, polygons, 0)

                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.20, 0.20, 0.20, 1.00))
                        if isKeyJustPressed(48) then sampSendClickTextdraw(callButtons[10]) end
                        if isKeyJustPressed(49) then sampSendClickTextdraw(callButtons[1]) end
                        if isKeyJustPressed(50) then sampSendClickTextdraw(callButtons[2]) end
                        if isKeyJustPressed(51) then sampSendClickTextdraw(callButtons[3]) end
                        if isKeyJustPressed(52) then sampSendClickTextdraw(callButtons[4]) end
                        if isKeyJustPressed(53) then sampSendClickTextdraw(callButtons[5]) end
                        if isKeyJustPressed(54) then sampSendClickTextdraw(callButtons[6]) end
                        if isKeyJustPressed(55) then sampSendClickTextdraw(callButtons[7]) end
                        if isKeyJustPressed(56) then sampSendClickTextdraw(callButtons[8]) end
                        if isKeyJustPressed(57) then sampSendClickTextdraw(callButtons[9]) end
                        if isKeyJustPressed(32) then sampSendClickTextdraw(callButtons[11]) end
                        if isKeyJustPressed(8)  then sampSendClickTextdraw(callButtons[13]) end
                        if isKeyJustPressed(27) then sampSendClickTextdraw(callButtons[12]) end
                        if imgui.Button('1', imgui.ImVec2(60, 60), imgui.SetCursorPosY(150.0), imgui.SetCursorPosX(25.0)) then
                            sampSendClickTextdraw(callButtons[1])
                        end
                        if imgui.Button('2', imgui.ImVec2(60, 60), imgui.SetCursorPosY(150.0), imgui.SetCursorPosX(105.0)) then
                            sampSendClickTextdraw(callButtons[2])
                        end
                        if imgui.Button('3', imgui.ImVec2(60, 60), imgui.SetCursorPosY(150.0), imgui.SetCursorPosX(185.0)) then
                            sampSendClickTextdraw(callButtons[3])
                        end
                        if imgui.Button('4', imgui.ImVec2(60, 60), imgui.SetCursorPosY(230.0), imgui.SetCursorPosX(25.0)) then
                            sampSendClickTextdraw(callButtons[4])
                        end
                        if imgui.Button('5', imgui.ImVec2(60, 60), imgui.SetCursorPosY(230.0), imgui.SetCursorPosX(105.0)) then
                            sampSendClickTextdraw(callButtons[5])
                        end
                        if imgui.Button('6', imgui.ImVec2(60, 60), imgui.SetCursorPosY(230.0), imgui.SetCursorPosX(185.0)) then
                            sampSendClickTextdraw(callButtons[6])
                        end
                        if imgui.Button('7', imgui.ImVec2(60, 60), imgui.SetCursorPosY(310.0), imgui.SetCursorPosX(25.0)) then
                            sampSendClickTextdraw(callButtons[7])
                        end
                        if imgui.Button('8', imgui.ImVec2(60, 60), imgui.SetCursorPosY(310.0), imgui.SetCursorPosX(105.0)) then
                            sampSendClickTextdraw(callButtons[8])
                        end
                        if imgui.Button('9', imgui.ImVec2(60, 60), imgui.SetCursorPosY(310.0), imgui.SetCursorPosX(185.0)) then
                            sampSendClickTextdraw(callButtons[9])
                        end
                        if imgui.Button('0', imgui.ImVec2(60, 60), imgui.SetCursorPosY(390.0), imgui.SetCursorPosX(105.0)) then
                            sampSendClickTextdraw(callButtons[10])
                        end
                        imgui.PopFont()
                        imgui.PopStyleColor(4)
                        imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(1.00, 1.00, 1.00, 0.00))
                        imgui.PushFont(font[45])
                            --imgui.SetCursorPosY(310.0) imgui.SetCursorPosX(25.0)
                            if imgui.Button(fa.ICON_FA_PHONE, imgui.ImVec2(60, 50), imgui.SetCursorPosY(390.0), imgui.SetCursorPosX(25.0)) then
                                sampSendClickTextdraw(callButtons[11])
                            end
                            if imgui.Button(fa.ICON_FA_DELETELEFT, imgui.ImVec2(60, 50), imgui.SetCursorPosY(390.0), imgui.SetCursorPosX(185.0)) then
                                sampSendClickTextdraw(callButtons[13])
                            end
                         imgui.PopFont()
                        imgui.PopStyleColor(4)
            imgui.PopStyleVar(1)
            imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.20, 0.20, 0.20, 1.00))
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.21, 0.21, 0.21, 0.40))
            if imgui.Button(u8'�����', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(505.0)) then
                callMenu[0] = not callMenu[0]
                mainMenu[0] = not mainMenu[0]
                sampSendClickTextdraw(callButtons[12])
                sampCloseCurrentDialogWithButton(0)
            end
            imgui.PopStyleColor(2)
            imgui.PopStyleVar(1)
        imgui.PopStyleColor(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

local messageFrame = imgui.OnFrame(
    function() return messageMenu[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(50, 50), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
        imgui.Begin("Main Window", messageMenu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
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
            imgui.InputTextWithHint('', u8'������� ���������', sendMessageInput, ffi.sizeof(sendMessageInput) - 1, imgui.SetCursorPosX(47.0), imgui.SetCursorPosY(440.0))
            imgui.Text(string.len(u8:decode(str(sendMessageInput))).."/"..((sizeof(sendMessageInput) / 2) - 1), imgui.SetCursorPosY(440.0), imgui.SetCursorPosX(235.0))
            if imgui.Button(u8'���������', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(475.0)) then
                sampSendDialogResponse(955, 1 , -1, ''..u8:decode(str(sendMessageInput)))
                imgui.StrCopy(sendMessageInput, '')
            end
            if imgui.Button(u8'�����', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(505.0)) then
                imgui.StrCopy(sendMessageInput, '')
                messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
                messageMenu[0] = not messageMenu[0]
                mainMenu[0] = not mainMenu[0]
                sampCloseCurrentDialogWithButton(0)
            end
        imgui.PopStyleVar(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

local messagesFrame = imgui.OnFrame(
    function() return messagesMenu[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(50, 50), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(275, 540), imgui.Cond.FirstUseEver)
        imgui.Begin("Main Window", messagesMenu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
            imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(0.21, 0.75, 0.54, 0.00))
                imgui.BeginChild("#messagesAllList", imgui.ImVec2(270, 381), imgui.SetCursorPosY(40.0), imgui.SetCursorPosX(20.0),  false)
                    imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(1.00, 1.00, 1.00, 0.05))
                    imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
                        for i = 2, #messagesListAll do
                            if messagesListAll[i] ~= nil then
                                if messagesListAllMsg[i] ~= nil then
                                    if imgui.Button(''..messagesListAllMsg[i], imgui.ImVec2(235, 60)) then
                                        sampSendDialogResponse(sampGetCurrentDialogId(), 1 , i - 1, tostring(messagesListAll[i]))
                                        messageMenu[0] = not messageMenu[0]
                                        messagesMenu[0] = not messagesMenu[0]
                                    end
                                end
                            end
                        end
                    imgui.PopStyleVar(1)
                    imgui.PopStyleColor(1)
                imgui.EndChild()
            imgui.PopStyleColor(1)
        imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 15)
            if imgui.Button(u8'�����', imgui.ImVec2(200, 25), imgui.SetCursorPosX(37.0), imgui.SetCursorPosY(505.0)) then
                imgui.StrCopy(sendMessageInput, '')
                messagesListAll, messagesListAllMsg, messagesListAllDateNum, messagesListAllDateText, messagesListAllstatusMsg = {}, {}, {}, {}, {}
                messagesMenu[0] = not messagesMenu[0]
                mainMenu[0] = not mainMenu[0]
                sampCloseCurrentDialogWithButton(0)
            end
        imgui.PopStyleVar(1)
        imgui.End()
        imgui.HideCursor = false
    end
)

local phoneMainMenu = imgui.OnFrame(
    function() return mainMenu[0] end,
    function(player)
        player.HideCursor = false
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
            imgui.PushFont(font[10])
                if imgui.Button(fa.ICON_FA_HOME, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(menuButtons[11])
                end
                if imgui.Button(fa.ICON_FA_TAXI, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(menuButtons[10])
                end
                if imgui.Button(fa.ICON_FA_DELIVERY, imgui.ImVec2(40, 40), imgui.SetCursorPosY(295.0), imgui.SetCursorPosX(35.0)) then
                    sampSendClickTextdraw(menuButtons[9])
                end
                if imgui.Button(fa.ICON_FA_DOLLAR, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(90.0)) then
                    sampSendClickTextdraw(menuButtons[6])
                end
                if imgui.Button(fa.ICON_FA_COIN, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(90.0)) then
                    sampSendClickTextdraw(menuButtons[7])
                end
                if  imgui.Button(fa.ICON_FA_CHEM, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(145.0)) then
                    sampSendClickTextdraw(menuButtons[13])
                end
                if imgui.Button(fa.ICON_FA_DRIVER, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(145.0)) then
                    sampSendClickTextdraw(menuButtons[12])
                end
                if imgui.Button(fa.ICON_FA_CARSHARING, imgui.ImVec2(40, 40), imgui.SetCursorPosY(405.0), imgui.SetCursorPosX(200.0)) then
                    sampSendClickTextdraw(menuButtons[5])
                end
                if imgui.Button(fa.ICON_FA_SWORD, imgui.ImVec2(40, 40), imgui.SetCursorPosY(350.0), imgui.SetCursorPosX(200.0)) then
                    sampSendClickTextdraw(menuButtons[8])
                end
            imgui.PopStyleVar(1)
            imgui.BeginChild("#navbar", imgui.ImVec2(235, 60), imgui.SetCursorPosY(460.0), imgui.SetCursorPosX(20.0),  false)
                imgui.PushStyleVarFloat(imgui.StyleVar.FrameRounding, 7)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.21, 0.75, 0.54, 0.50))
                        if imgui.Button(fa.ICON_FA_PHONE, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(15.0)) then
                            sampSendClickTextdraw(menuButtons[1])
                            callMenu[0] = not callMenu[0]
                            mainMenu[0] = not mainMenu[0]
                        end
                        if imgui.Button(fa.ICON_FA_COMMENT, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(70.0)) then
                            sampSendClickTextdraw(menuButtons[3])
                            messagesMenu[0] = not messagesMenu[0]
                            mainMenu[0] = not mainMenu[0]
                        end
                    imgui.PopStyleColor(1)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.89, 0.66, 0.90, 0.50))
                        if imgui.Button(fa.ICON_FA_USER, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(125.0)) then
                            sampSendClickTextdraw(menuButtons[2])
                        end
                    imgui.PopStyleColor(1)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.98, 0.38, 0.45, 0.50))
                        if imgui.Button(fa.ICON_FA_BARS, imgui.ImVec2(40, 40), imgui.SetCursorPosY(10.0), imgui.SetCursorPosX(180.0)) then
                            sampSendClickTextdraw(menuButtons[4])
                        end
                    imgui.PopStyleColor(1)
                imgui.PopStyleVar(1)
            imgui.EndChild()
        imgui.PopFont()
        imgui.PopStyleVar(1)
        imgui.End()
    end
)

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(scriptTag..'������ ������� ��������. �����: {CDAF95}'..script.authors[1], -1)
    while not sampIsPlayerConnected() do wait(0) end
    if sampGetCurrentServerName():match("Arizona Role Play | (%u%w+-%w+)") then
        serverName = sampGetCurrentServerName():match("Arizona Role Play | (%u%w+-%w+)")
    else sampGetCurrentServerName():match("Arizona Role Play | (%u%w+)")
        serverName = sampGetCurrentServerName():match("Arizona Role Play | (%u%w+)")
    end
    sampRegisterChatCommand('dt', deleteTextdraw)
    sampRegisterChatCommand('fdt', fastDeleteTrash)
    sampRegisterChatCommand('gb', getMenuButtonsIds)
    sampRegisterChatCommand('ph', function()
        mainMenu[0] = not mainMenu[0]
    end)
    --[[addEventHandler('onWindowMessage', function(msg, wparam, lparam) -- ���� �������, � ������� ����� ������������ ������� �������. �������� ��������, ��� ������ ������ �������� �������� ������ � ����� �����������.
        if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then -- ���� ������� ������
            if wparam == vkeys.VK_P then -- � ���� ��� ������� X
                mainMenu[0] = not mainMenu[0] -- ����������� ��������� �������
                sampSendChat('/phone')
                lockPlayerControl(false)
            end
        end
    end)]]
    while true do wait(0)

    end
end

function sampev.onSendCommand(text)
    if text == '/phone' then
        otherSeek = {{x = 87, y = 201}}
        menuMenuButtons = {{x = 57, y = 286}, {x = 72, y = 286}, {x = 86, y = 286}, {x = 101, y = 286}, {x = 101, y = 235}, {x = 100, y = 251}, {x = 101, y = 269}, {x = 86, y = 268}, {x = 71, y = 268}, {x = 72, y = 250}, {x = 56, y = 268}, {x = 57, y = 250}, {x = 57, y = 234}}
        callMenuButtons = {{x = 57, y = 216}, {x = 76, y = 216}, {x = 95, y = 216}, {x = 57, y = 238}, {x = 76, y = 238}, {x = 95, y = 238}, {x = 57, y = 258}, {x = 76, y = 258}, {x = 95, y = 258}, {x = 76, y = 279}, {x = 57, y = 279}, {x = 95, y = 279}, {x = 110, y = 206}}
        function sampev.onShowTextDraw(id, data)
            posX = math.floor(data.position.x)
            posY = math.floor(data.position.y)
            for i = 1, #menuMenuButtons do
                if menuMenuButtons[i].x == posX and menuMenuButtons[i].y == posY then
                    sampAddChatMessage(scriptTag..''..i..' > '..id, -1)
                    menuButtons[i] = id
                    data.position.x = 50000.0
                    return { id, data }
                end
            end
            for i = 1, #callMenuButtons do
                if callMenuButtons[i].x == posX and callMenuButtons[i].y == posY then
                    sampAddChatMessage(scriptTag..''..i..' > '..id, -1)
                    callButtons[i] = id
                    data.position.x = 50000.0
                    return { id, data }
                end
            end
            for i = 1, #telephoneTrash do
                if telephoneTrash[i].x == posX and telephoneTrash[i].y == posY then
                    return false
                end
            end
            for i = 1, #otherSeek do
                if otherSeek[i].x == posX and otherSeek[i].y == posY then
                    data.position.x = 50000.0
                    return { id, data }
                end
            end
        end
    end
end

function sampev.onPlaySound(id, position)
    if id == 17803 then
        --return false
    end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if title:find("%u%w+_%u%w+") and button1:find("���������") then
        userName = title:match("(%u%w+_%u%w+)")
        separator = '\n'
        messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
        for str in string.gmatch(text, "([^"..separator.."]+)") do
                table.insert(messagesList, str)
        end
        for i = 1, #messagesList do
            dateNum[i], dateText[i], whoSender[i], msgText[i] = string.match(messagesList[i], "%[%{......%}(%d+)%{FFFFFF%} (.+) �����%] %- %{......%}%[(.+)%]%{......%}(.+)")
            if dateNum[i] == nil then
                whoSender[i], msgText[i] = string.match(messagesList[i], "%[%{......%}������ ���%{......%}%] %- %{......%}%[(.+)%]%{......%}(.+)")
                dateNum[i] = ''
                dateText[i] = '������'
            end
            if whoSender[i] == '��' then
                whoSender[i] = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
            elseif whoSender[i] == '�������' then
                whoSender[i] = userName
            end
            if dateText[i] == '����(�)' then
                dateText[i] = getDateMessage(tonumber(dateNum[i]))
            elseif dateText[i] == '�����(�)' then
                dateText[i] = getTimeMessage(tonumber(dateNum[i]))
            elseif dateText[i] == '���(��)' then
                if dateNum[i] == '1' or dateNum[i] == '21' then
                    dateText[i] = dateNum[i]..' ���'
                elseif dateNum[i] == '2' or dateNum[i] == '3' or dateNum[i] == '4' or dateNum[i] == '22' or dateNum[i] == '23' then
                    dateText[i] = dateNum[i]..' ����'
                else
                    dateText[i] = dateNum[i]..' �����'
                end
            elseif dateText[i] == '������(�)' then
                dateText[i] = dateNum[i]..' ���'
            end
        end
        return false
    end
    if text:find("%{......%}�� ������� ������ ��������%: %{......%}(%d+).+%{......%}.") then
        phoneBalance = text:match("%{......%}�� ������� ������ ��������%: %{......%}(%d+).+%{......%}.")
        title = scriptTag
        text = text.gsub(text, "%{......%}�� ������� ������ ��������%: %{......%}(%d+).+%{......%}.", '{b7b7b7}������ ��������: {CDAF95}'..phoneBalance..'${b7b7b7}.\n ����� ������ �� {CDAF95}'..(tonumber(phoneBalance) / 25)..' {b7b7b7}���������.')
        return { id, style, title, button1, button2, text }
    end
    if title:find("�������� ������") or button1:find("���������") then
        separator = '\n'
        messagesList, dateNum, dateText, whoSender, msgText = {}, {}, {}, {}, {}
        messagesListAll, messagesListAllMsg, messagesListAllDateNum, messagesListAllDateText, messagesListAllstatusMsg = {}, {}, {}, {}, {}
        for str in string.gmatch(text, "([^"..separator.."]+)") do
                table.insert(messagesListAll, str)
        end
        for i = 2, #messagesListAll do
            messagesListAllMsg[i], messagesListAllDateNum[i], messagesListAllDateText[i], messagesListAllstatusMsg[i] = string.match(messagesListAll[i], ".+%{......%}(.+)%{......%} 	%[%{......%}(.+)%{......%} (.+)%].. %{......%}%[(.+)%]%{......%}")
        end
        for i = 2, #messagesListAll do
            messagesListAll[i] = messagesListAll[i].gsub(messagesListAll[i], "%{......%}", "")
        end
        return false
    end
end

function deleteTextdraw(int)
    sampTextdrawDelete(int)
    sampAddChatMessage(scriptTag..'������ ���������: {CDAF95}'..int, -1)
    print('[MiPhone] ������ ���������: '..int)
end

function getDateMessage(days) -- � ��� �������� 3 ��� �����, ������ ��� �� ���� � !*t, �� ����� ��� ����� � 20 ����� :)
    mouth, day, year = os.date("%x", os.time(os.date("!*t")) - (86400 * tonumber(days))):match("(%d+)/(%d+)/(%d+)")
    return day..'.'..mouth..'.'..year
end

function getTimeMessage(minutes)
    hour, minute = os.date("%X", os.time(os.date("*t")) - (60 * tonumber(minutes))):match("(%d+):(%d+):%d+")
    return hour..':'..minute
end

--[[function sampev.onServerMessage(color, text)
    if text:match('(.+) ������%X�%X (.+) �� �������') then
        result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if text:match(tostring(sampGetPlayerNickname(id))..' ������%X�%X (.+) �� �������') then
            mainMenu[0] = not mainMenu[0]
        end
    end
end]]

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