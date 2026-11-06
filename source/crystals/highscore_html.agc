
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreGetTableNameForCookie(Index as integer)
	
	local Value as string
	
	Value = ""
	
	select Index
		case DIFFICULTY_EASY
			Value = "crystals_hs_table_easy.json"
		endcase
		case DIFFICULTY_MEDIUM
			Value = "crystals_hs_table_medium.json"
		endcase
		case DIFFICULTY_ADVANCED
			Value = "crystals_hs_table_advanced.json"
		endcase
		case DIFFICULTY_HARD
			Value = "crystals_hs_table_hard.json"
		endcase
		case DIFFICULTY_ULTRA
			Value = "crystals_hs_table_ultra.json"
		endcase
		case TABLEGEMS
			Value = "crystals_hs_table_gems.json"
		endcase
		case TABLELEVEL
			Value = "crystals_hs_table_level.json"
		endcase
		case TABLECASCADE
			Value = "crystals_hs_table_cascade.json"
		endcase
		case TABLEONLINE
			Value = "crystals_hs_table_online.json"
		endcase
	endselect
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableSaveAsCookie(Table ref as THighScore[],TableIndex as integer,OverWrite as integer)

	local EncString as string
	local TableName as string
	
	TableName = HighScoreGetTableNameForCookie(TableIndex)
	
	if OverWrite = TRUE or LoadSharedVariable(TableName,"") = ""

		EncString = HighScoreEncode(Table)
	
		if EncString <> ""
			if Len(EncString) < 4096 - Len(TableName)
				SaveSharedVariable(TableName,EncString)
			endif
		endif
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreSaveAsCookie(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	for i = 0 to MAXHIGHSCORETABLE
		HighScoreTableSaveAsCookie(HighScoreList.Score[i],i,TRUE)
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableLoadFromCookie(Table ref as THighScore[],TableIndex as integer)
	
	local EncString as string
	local TableName as string
	local Value as integer
	
	TableName = HighScoreGetTableNameForCookie(TableIndex)
	EncString = LoadSharedVariable(TableName,"")
	
	Value = FALSE
	
	if EncString <> ""
		Value = HighScoreDecode(Table,MAXHIGHSCOREITEMS,EncString)
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreLoadFromCookie(HighScoreList ref as THighScoreList)

	local Table as THighScore[]
	local i as integer
	local Value as integer
	local Valid as integer
	
	HighScoreClear(HighScoreList)
	Value = TRUE
	
		for i = 0 to MAXHIGHSCORETABLE

			Table.Length = -1
			
			Valid = HighScoreTableLoadFromCookie(Table,i)
			
			if Valid = TRUE
				if Table.Length <> MAXHIGHSCOREITEMS
					Valid = FALSE
				endif
			endif
			
			if Valid = FALSE
				Value = FALSE
				HighScoreTableInit(Table,i)
				HighScoreTableSaveAsCookie(Table,i,TRUE)
			endif
			
			HighScoreList.Score.Insert(Table)

		next i

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



