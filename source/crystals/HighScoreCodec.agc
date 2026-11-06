
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

#constant HighScoreChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,:;-+*/\()[]{}_§$%&!?#~=^°<>|"
#constant EncodingChars  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~*'()"

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreEncode(Table ref as THighScore[])

	local i as integer
	local k as integer
	local CharID as integer
	local Value as string
	local Code as string
	
	Value = ""
	for i = 0 to Table.Length
		for k = 1 to 5
			if k <= Len(Table[i].Name)
				Code = Mid(Table[i].Name, k, 1)
			else
				Code = " "
			endif
			CharID = FindString(HighScoreChars, Code)
			if CharID = 0
				// Hier Fehler behandeln und Encoding abbrechen
				exitfunction ""
			else
				Value = Value + Mid(EncodingChars, CharID, 1)
			endif
		next k
		// Score direkt als Dezimalzahl speichern
		Value = Value + Str(Table[i].Score)
		// Punkt als Trennzeichen
		Value = Value + "."
	next i

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreDecode(Table ref as THighScore[], MaxItems as integer, EncString as string)
	
	local i as integer
	local k as integer
	local EncID as integer
	local CharID as integer
	local Found as integer
	local ScoreEntry as THighScore
	local Code as string
	local Name as string
	local Score as string
	local Value as integer
	
	Value = TRUE
	Table.Length = -1
	EncID = 1
	
	for k = 0 to MaxItems
	
		// Mindestens 5 Namenszeichen, 1 Ziffer und 1 Punkt
		if EncID + 6 > Len(EncString)
			Value = FALSE
			exit
		endif
	
		Name = ""
	
		for i = 0 to 4
			Code = Mid(EncString, EncID + i, 1)
			CharID = FindString(EncodingChars, Code) - 1
			if CharID < 0 or CharID >= Len(HighScoreChars)
				Value = FALSE
				exit
			endif
			Name = Name + Mid(HighScoreChars, CharID + 1, 1)
		next i
		
		if Value = FALSE
			exit
		endif
	
		EncID = EncID + 5
	
		Score = ""
		Found = FALSE
	
		while EncID <= Len(EncString) and Found = FALSE
	
			Code = Mid(EncString, EncID, 1)
			EncID = EncID + 1
	
			if Code = "."
				Found = TRUE
			else
				// Nur Ziffern erlauben
				if FindString("0123456789", Code) = 0
					Value = FALSE
					exit
				endif
				Score = Score + Code
			endif
	
		endwhile
	
		if Value = FALSE or Found = FALSE or Score = ""
			Value = FALSE
			exit
		endif
	
		ScoreEntry.Name = Name
		ScoreEntry.Score = Val(Score)
		Table.Insert(ScoreEntry)
	
	next k

	if EncID <= Len(EncString)
	    Value = FALSE
	endif

endfunction Value


//----------------------------------------------------------------------
//
//----------------------------------------------------------------------