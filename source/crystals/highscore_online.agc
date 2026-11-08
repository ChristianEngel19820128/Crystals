
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

#include "pt/purpletoken.agc"
#include "pt/pt_interface.agc"
#include "pt/pt_key.agc"

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineInit()

	PurpleToken_Init()

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineRequestScore()

	local Started as integer

	Started = PurpleToken_Request(MAXHIGHSCOREITEMS+1)

endfunction Started
    
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineSendScore(PlayerName as string,Score as integer)

	local Started as integer

	Started = PurpleToken_Send(PlayerName,Score)

endfunction Started

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineStart(HighScoreList ref as THighScoreList)

	if HighScoreList.OnlineState <> ONLINE_WAITING
		if HighScoreOnlineRequestScore() = TRUE
			HighScoreList.OnlineRequestTime = GetMilliseconds()
			HighScoreList.OnlineState = ONLINE_WAITING
		endif
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineDo(HighScoreList ref as THighScoreList)
	
	if HighScoreList.OnlineState = ONLINE_WAITING
	
		if HighScoreOnlineReceive(HighScoreList.Score) = TRUE
		
			HighScoreList.OnlineState = ONLINE_READY
			HighScoreList.OnlineResult = TRUE
			
			if Device$ = "windows"
				HighScoreTableSave(HighScoreList.Score[TABLEONLINE],TABLEONLINE,TRUE)
			endif
			
			if Device$ = "html5"
				HighScoreTableSaveAsCookie(HighScoreList.Score[TABLEONLINE],TABLEONLINE,TRUE)
			endif
			
		else
			if GetMilliseconds() - HighScoreList.OnlineRequestTime >= 3000
				PT_cancelRequest()
				HighScoreList.OnlineState = ONLINE_IDLE
			endif
		endif
	
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineReceive(Table ref as THighScore[][])

	local TempTable as THighScore[]
	local Scores as _PurpleToken_Score[]
	local Score as THighScore
	local i as integer
	local Count as integer
	local Found as integer
	
	Found = FALSE
	
	if PurpleToken_Receive() = TRUE
	
		Scores = PT_getScoreArray()
		
		if Table.Length = MAXHIGHSCORETABLE
			if Table[TABLEONLINE].Length = MAXHIGHSCOREITEMS
			
				TempTable.Length = -1
				Count = Scores.Length + 1
				
				if Count > MAXHIGHSCOREITEMS + 1
					Count = MAXHIGHSCOREITEMS + 1
				endif
				
				for i = 0 to MAXHIGHSCOREITEMS
				
					Score.Name = "XXX"
					Score.Score = 0
					
					if i < Count
						Score.Name = Left(Scores[i].player,MAXCHARS+1)
						Score.Score = Scores[i].score
					endif
					
					TempTable.Insert(Score)
				
				next i
				
				Table[TABLEONLINE] = TempTable
				Found = TRUE
		
			endif
		endif
	endif

endfunction Found

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
