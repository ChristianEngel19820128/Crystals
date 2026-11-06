
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

    local TempTable as THighScore[]
    local Score as THighScore
    local i as integer
    local Count as integer
    local Found as integer

    PT_listener()
    Found = FALSE

    if PT_getCode() = _PT_ERROR_SUCCESS
        if PT_scoresAvailable()
            if Table.Length = MAXHIGHSCORETABLE
                if Table[TABLEONLINE].Length = MAXHIGHSCOREITEMS

                    TempTable.Length = -1
                    Count = _PT.scores.Length + 1

                    if Count > MAXHIGHSCOREITEMS + 1
                        Count = MAXHIGHSCOREITEMS + 1
                    endif

                    for i = 0 to MAXHIGHSCOREITEMS

                        Score.Name = "XXX"
                        Score.Score = 0

                        if i < Count
                            Score.Name = Left(_PT.scores[i].player,MAXCHARS+1)
                            Score.Score = _PT.scores[i].score
                        endif

                        TempTable.Insert(Score)
                    next i

                    Table[TABLEONLINE] = TempTable
                    Found = TRUE

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



