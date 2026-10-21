
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputRightStateDown(JoystickIndex as integer,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if GetRawJoystickExists(JoystickIndex) = 1
			if (GetRawJoystickX(JoystickIndex) > 0.5) or (GetRawJoystickButtonState(JoystickIndex,JoystickButtonCrossRight) = 1)
				Value = TRUE
			endif
		endif
	
		//if GetDeviceBaseName() = "windows"
			if GetRawKeyState(KEY_D) = 1 or GetRawKeyState(KEY_RIGHT) = 1
				Value = TRUE
			endif
		//endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputLeftStateDown(JoystickIndex as integer,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if GetRawJoystickExists(JoystickIndex) = 1
			if (GetRawJoystickX(JoystickIndex) < -0.5) or (GetRawJoystickButtonState(JoystickIndex,JoystickButtonCrossLeft) = 1)
				Value = TRUE
			endif
		endif
	
		//if GetDeviceBaseName() = "windows"
			if GetRawKeyState(KEY_A) = 1 or GetRawKeyState(KEY_LEFT) = 1
				Value = TRUE
			endif
		//endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputUpStateDown(JoystickIndex as integer,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if GetRawJoystickExists(JoystickIndex) = 1
			if (GetRawJoystickY(JoystickIndex) < -0.5) or (GetRawJoystickButtonState(JoystickIndex,JoystickButtonCrossUp) = 1)
				Value = TRUE
			endif
		endif
	
		//if GetDeviceBaseName() = "windows"
			if GetRawKeyState(KEY_W) = 1 or GetRawKeyState(KEY_UP) = 1
				Value = TRUE
			endif
		//endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputDownStateDown(JoystickIndex as integer,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if GetRawJoystickExists(JoystickIndex) = 1
			if (GetRawJoystickY(JoystickIndex) > 0.5) or (GetRawJoystickButtonState(JoystickIndex,JoystickButtonCrossDown) = 1)
				Value = TRUE
			endif
		endif
	
		//if GetDeviceBaseName() = "windows"
			if GetRawKeyState(KEY_S) = 1 or GetRawKeyState(KEY_DOWN) = 1
				Value = TRUE
			endif
		//endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputActionStatePressed(JoystickIndex as integer)

	local Value as integer
	
	Value = FALSE
		
	if GetRawJoystickExists(JoystickIndex) = 1
		if GetRawJoystickButtonPressed(JoystickIndex,JoystickButtonA)
			Value = TRUE
		endif
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputActionAlternateStatePressed(JoystickIndex as integer)

	local Value as integer
	
	Value = FALSE
		
	if GetRawJoystickExists(JoystickIndex) = 1
		if GetRawJoystickButtonPressed(JoystickIndex,JoystickButtonB)
			Value = TRUE
		endif
	endif

	//if GetDeviceBaseName() = "windows"
		if GetRawKeyPressed(KEY_W) = 1 or GetRawKeyPressed(KEY_UP) = 1
			Value = TRUE
		endif
	//endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputStartStatePressed(JoystickIndex as integer)

	local Value as integer
	
	Value = FALSE
	
	if GetRawJoystickExists(JoystickIndex) = 1
		if GetRawJoystickButtonPressed(JoystickIndex,JoystickButtonStart) = 1
			Value = TRUE
		endif
	endif

	//if GetDeviceBaseName() = "windows"
		if GetRawKeyPressed(KEY_ENTER) = 1
			Value = TRUE
		endif
	//endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputBackStatePressed(JoystickIndex as integer)

	local Value as integer
	
	Value = FALSE
		
	if GetRawJoystickExists(JoystickIndex) = 1
		if GetRawJoystickButtonPressed(JoystickIndex,JoystickButtonBack) = 1
			Value = TRUE
		endif
	endif

	if GetDeviceBaseName() = "windows"
		if GetRawKeyPressed(KEY_ESCAPE) = 1
			Value = TRUE
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameInputDo(Game ref as TGame,Now as integer)
	
	if Game.IsRunning = TRUE
		if CheckInputStartStatePressed(Game.JoystickIndex) = TRUE
			PauseGame(Game)
		endif
	endif
	
	if Game.IsPause = TRUE
	
		if CheckInputLeftStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			// sound leiser
			if Game.SelectSound = 0
				if Game.SoundVol > 0
					Game.SoundVol = Game.SoundVol - 10
				endif
			else
				if Game.MusicVol > 0
					Game.MusicVol = Game.MusicVol - 10
					SetMusicVolumeOGG(Game.TitleThemeID,Game.MusicVol)
				endif
			endif
		endif

		if CheckInputRightStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			// sound lauter
			if Game.SelectSound = 0
				if Game.SoundVol < 100
					Game.SoundVol = Game.SoundVol + 10
				endif
			else
				if Game.MusicVol < 100
					Game.MusicVol = Game.MusicVol + 10
					SetMusicVolumeOGG(Game.TitleThemeID,Game.MusicVol)
				endif
			endif

		endif

		if CheckInputUpStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			// select sound or music
			if Game.SelectSound = 0
				Game.SelectSound = 1
			else
				Game.SelectSound = 0
			endif
		endif

		if CheckInputDownStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			// select sound or music
			if Game.SelectSound = 1
				Game.SelectSound = 0
			else
				Game.SelectSound = 1
			endif
		endif
	
	endif

	if Game.IsRunning = TRUE and Game.IsBlockMoving = TRUE
		
		if CheckInputLeftStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			WhileGameMoveBlockLeft(Game)
		endif

		if CheckInputRightStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			WhileGameMoveBlockRight(Game)
		endif

		if CheckInputDownStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
			WhileGameDropBlock(Game)
		endif
		
		if CheckInputActionStatePressed(Game.JoystickIndex) = TRUE
			WhileGameShuffleBlock(Game,0)
		endif
		
		if CheckInputActionAlternateStatePressed(Game.JoystickIndex) = TRUE
			WhileGameShuffleBlock(Game,1)
		endif
		
		if CheckInputBackStatePressed(Game.JoystickIndex)
			AbortGame(Game)
		endif
		
	endif
	
	if Game.IsRunning = FALSE
		if Game.IsDifficultySelect = TRUE
		
			if CheckInputUpStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
				DifficultyMoveUp(Game)
			endif
			
			if CheckInputDownStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
				DifficultyMoveDown(Game)
			endif
			
			if CheckInputStartStatePressed(Game.JoystickIndex) = TRUE
				DifficultySelect(Game,Now)
			endif
			
			if CheckInputBackStatePressed(Game.JoystickIndex)
				AbortGame(Game)
			endif
			
		else
	
			if Game.IsHighScore = TRUE
			
				if CheckInputLeftStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
					HighscoreSwitchShiftLeft(Game)
				endif
				
				if CheckInputRightStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
					HighscoreSwitchShiftRight(Game)
				endif
				
				if CheckInputStartStatePressed(Game.JoystickIndex) = TRUE
					StartGameInitialisation(Game)
				endif
				
			endif
			
			if Game.IsSummary = TRUE
				
				if CheckInputStartStatePressed(Game.JoystickIndex) = TRUE
					SummarySelect(Game)
				endif
				
				if CheckInputBackStatePressed(Game.JoystickIndex)
					AbortGame(Game)
				endif
					
				if Game.IsNewHighScore = TRUE
			
					if CheckInputLeftStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveLeft(Game)
					endif
					
					if CheckInputRightStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveRight(Game)
					endif
					
					if CheckInputUpStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveUp(Game)
					endif
					
					if CheckInputDownStateDown(Game.JoystickIndex,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveDown(Game)
					endif
					
				endif
			endif
			
		endif
	endif
		
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
