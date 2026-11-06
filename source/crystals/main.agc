
// Project: crystals 
// Created: 25-10-20

// show all errors

SetErrorMode(2)

// set window properties
SetWindowTitle("Cystals")

local dx as integer
local dy as integer
local wx as integer
local wy as integer
local vx as integer
local vy as integer
local cx as float
local cy as float

wx = 450
wy = 800

vx = 450
vy = 800

SetOrientationAllowed(1,0,0,0)
SetWindowSize(wx,wy,0)
SetWindowAllowResize(1)

cx = vx/2
cy = vy/2

SetVirtualResolution(vx,vy)

#option_explicit

#constant Device$ GetDeviceBaseName()



If Device$ = "html5"
	SetVSync(1)
else
	SetSyncRate(120,0)
endif

SetScissor(0,0,0,0)
UseNewDefaultFonts(1)



#constant FALSE 0
#constant TRUE 1

#include "def_keys.agc"
#include "def_joypad.agc"
#include "def_game.agc"
#include "def_strings.agc"
#include "base64.agc"
#include "HighScoreCodec.agc"
#include "color.agc"
#include "file.agc"
#include "timer.agc"
#include "sound.agc"
#include "explosion.agc"
#include "background.agc"
#include "crystal.agc"
#include "block.agc"
#include "field.agc"
#include "summary.agc"
#include "highscore_online.agc"
#include "highscore_html.agc"
#include "highscore_windows.agc"
#include "highscore.agc"
#include "game.agc"
#include "workflow.agc"
#include "controls.agc"
#include "input.agc"

#constant maxdebug = 3
global debug as integer[maxdebug]
local i

for i = 0 to maxdebug
	debug[i] = CreateText("")
	SetTextPosition(debug[i],10,vy-50-i*30)
	SetTextSize(debug[i],24)
next i

local Game as TGame
GameCreate(Game,cx,cy)

local TimeDraw as integer
local TimeSwap as integer
TimeDraw = GetMilliseconds()
TimeSwap = GetMilliseconds()

local Text1 as integer
local Text2 as integer
Text1 = CreateText("")
Text2 = CreateText("" + Chr(92))
settextposition(text1,10,10)
settextposition(text2,10,30)
settextsize(text1,24)
settextsize(text2,24)

repeat
	
	SetTextString(Game.FPS,Str(Trunc(ScreenFPS())))
	
	if Game.IsPause = FALSE
		Game.Time.VirtualNow = Game.Time.VirtualNow + GetMilliseconds() - Game.Time.RealNow
	endif
	Game.Time.RealNow = GetMilliseconds()
	
	GameInputDo(Game,Game.Time.VirtualNow)
	GameDo(Game)
	HighScoreOnlineDo(Game.HighScore)
	PurpleToken_SendDo()

settextstring(debug[0],"State"+str(PurpleTokenSend.State))
settextstring(debug[1],"Time"+str(PurpleTokenSend.Time))
settextstring(debug[2],"Result "+str(PurpleTokenSend.Result))
settextstring(debug[3],"OnlineState "+str(Game.HighScore.OnlineState))


/*	If Device$ = "html5"
		if TimeDraw + 12 < GetMilliseconds()
			GameDraw(Game)
			Drawtext(debug)
			Drawtext(Game.FPS)
			TimeDraw = GetMilliseconds()
			Swap()
		endif
	else */
		GameDraw(Game)

		for i = 0 to maxdebug
			//Drawtext(debug[i])
		next i

		Drawtext(Game.FPS)
		Swap()
	//endif
	
until GetESCPressed() = 1 and Game.IsHighScore = TRUE
