
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Init()

	PT_initialize('40e1f1dc7624289738d4a147dea1770a8d859ab2', 'pizza shakes')

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Request()

	PT_requestScores(MAXHIGHSCOREITEMS+1,0,0)

endfunction
    
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Receive(Table ref as THighScore[][])

	local i as integer
	local k as integer
	local code as integer
	local Found as integer

	local test1 as string
	local test2 as integer

	PT_listener()
	Found = FALSE
	code = PT_getCode()
	if code = _PT_ERROR_SUCCESS
		if PT_scoresAvailable()
			if Table.Length = MAXHIGHSCORETABLE
				if Table[TABLEONLINE].Length = MAXHIGHSCOREITEMS
					Found = TRUE
					i = 0
					while i <= MAXHIGHSCOREITEMS and i <= _PT.scores.Length
						Table[TABLEONLINE,i].Name = Left(_PT.scores[i].player,MAXCHARS+1)
						Table[TABLEONLINE,i].Score = _PT.scores[i].score
						inc i
					endwhile
					if i <= MAXHIGHSCOREITEMS
						for k = i to MAXHIGHSCOREITEMS
							Table[TABLEONLINE,i].Name = "XXX"
							Table[TABLEONLINE,i].Score = 0
						next k
					endif
				endif
			endif
		endif
	endif

endfunction Found

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Send(PlayerName as string,Score as integer)

	local Time as integer
	local code as integer

	if Len(PlayerName) <= MAXCHARS+1
		PT_submitScore(PlayerName,Score)
		code = -1
		while Time + 3000 > GetMilliseconds() and code = -1
			sleep(35)
			PT_listener()
			code = PT_getCode()
		endwhile
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



