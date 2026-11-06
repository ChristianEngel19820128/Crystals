
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

#include "pt/purpletoken.agc"
#include "pt/pt_interface.agc"

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

	PurpleToken_Request()

endfunction
    
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineSendScore(PlayerName as string,Score as integer)

	PT_submitScore(PlayerName,Score)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineStart(HighScoreList ref as THighScoreList)

	if HighScoreList.OnlineState <> ONLINE_WAITING
		HighScoreOnlineRequestScore()
		HighScoreList.OnlineRequestTime = GetMilliseconds()
		HighScoreList.OnlineState = ONLINE_WAITING
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreOnlineDo(HighScoreList ref as THighScoreList)
	
	if HighScoreList.OnlineState = ONLINE_WAITING
	
		if PurpleToken_Receive(HighScoreList.Score) = TRUE
		
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
				HighScoreList.OnlineState = ONLINE_IDLE
				HighScoreList.OnlineResult = FALSE
			endif
		endif
	
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------


