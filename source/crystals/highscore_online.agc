
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
		sleep(35)
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



