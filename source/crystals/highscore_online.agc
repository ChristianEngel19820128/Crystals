
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

function HighScoreOnlineReceiveScore(Table ref as THighScore[][])	

	local Time as integer
	local Found as integer

	HighScoreOnlineRequestScore()

	Time = GetMilliseconds()
	Found = FALSE
	while Time + 3000 > GetMilliseconds() and Found = FALSE
		//sleep(35)
		//swap()
		if PurpleToken_Receive(Table) = TRUE
			Found = TRUE
		endif
	endwhile

endfunction Found
    
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


