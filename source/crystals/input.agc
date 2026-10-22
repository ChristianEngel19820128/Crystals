
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputRightStateDown(Joystick ref as TJoystick,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if Joystick.Enabled = 1
			if GetRawJoystickExists(Joystick.Index) = 1
				if (GetRawJoystickX(Joystick.Index) > 0.5) or (GetRawJoystickButtonState(Joystick.Index,JoystickButtonCrossRight) = 1)
					Value = TRUE
				endif
			endif
		endif

		if GetRawKeyState(KEY_D) = 1 or GetRawKeyState(KEY_RIGHT) = 1
			Value = TRUE
		endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputLeftStateDown(Joystick ref as TJoystick,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if Joystick.Enabled = 1
			if GetRawJoystickExists(Joystick.Index) = 1
				if (GetRawJoystickX(Joystick.Index) < -0.5) or (GetRawJoystickButtonState(Joystick.Index,JoystickButtonCrossLeft) = 1)
					Value = TRUE
				endif
			endif
		endif

		if GetRawKeyState(KEY_A) = 1 or GetRawKeyState(KEY_LEFT) = 1
			Value = TRUE
		endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputUpStateDown(Joystick ref as TJoystick,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if Joystick.Enabled = 1
			if GetRawJoystickExists(Joystick.Index) = 1
				if (GetRawJoystickY(Joystick.Index) < -0.5) or (GetRawJoystickButtonState(Joystick.Index,JoystickButtonCrossUp) = 1)
					Value = TRUE
				endif
			endif
		endif

		if GetRawKeyState(KEY_W) = 1 or GetRawKeyState(KEY_UP) = 1
			Value = TRUE
		endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputDownStateDown(Joystick ref as TJoystick,InputTimer ref as TTime,Time ref as TGlobalTime)

	local Value as integer
	
	Value = FALSE
	
	if TimeGet(InputTimer,Time.RealNow) > REACTIONTIME
		
		if Joystick.Enabled = 1
			if GetRawJoystickExists(Joystick.Index) = 1
				if (GetRawJoystickY(Joystick.Index) > 0.5) or (GetRawJoystickButtonState(Joystick.Index,JoystickButtonCrossDown) = 1)
					Value = TRUE
				endif
			endif
		endif

		if GetRawKeyState(KEY_S) = 1 or GetRawKeyState(KEY_DOWN) = 1
			Value = TRUE
		endif
		
	endif
	
	if Value = TRUE
		TimeReset(InputTimer,Time.RealNow)
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputActionStatePressed(Joystick ref as TJoystick)

	local Value as integer
	
	Value = FALSE

	if Joystick.Enabled = 1
		if GetRawJoystickExists(Joystick.Index) = 1
			if GetRawJoystickButtonPressed(Joystick.Index,JoystickButtonA)
				Value = TRUE
			endif
		endif
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputActionAlternateStatePressed(Joystick ref as TJoystick)

	local Value as integer
	
	Value = FALSE
	
	if Joystick.Enabled = 1
		if GetRawJoystickExists(Joystick.Index) = 1
			if GetRawJoystickButtonPressed(Joystick.Index,JoystickButtonB)
				Value = TRUE
			endif
		endif
	endif

	if GetRawKeyPressed(KEY_W) = 1 or GetRawKeyPressed(KEY_UP) = 1
		Value = TRUE
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputStartStatePressed(Joystick ref as TJoystick)

	local Value as integer
	
	Value = FALSE
	
	if Joystick.Enabled = 1
		if GetRawJoystickExists(Joystick.Index) = 1
			if GetRawJoystickButtonPressed(Joystick.Index,JoystickButtonStart) = 1
				Value = TRUE
			endif
		endif
	endif

	if GetRawKeyPressed(KEY_ENTER) = 1
		Value = TRUE
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function CheckInputBackStatePressed(Joystick ref as TJoystick)

	local Value as integer
	
	Value = FALSE
		
	if Joystick.Enabled = 1
		if GetRawJoystickExists(Joystick.Index) = 1
			if GetRawJoystickButtonPressed(Joystick.Index,JoystickButtonBack) = 1
				Value = TRUE
			endif
		endif
	endif

	if Device$ = "windows"
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
		if CheckInputStartStatePressed(Game.Joystick) = TRUE
			PauseGame(Game)
		endif
	endif
	
	if Game.IsPause = TRUE
	
		if CheckInputLeftStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			// sound leiser
			if Game.SelectSound = 0
				if Game.SoundVol > 0
					Game.SoundVol = Game.SoundVol - 10
				endif
			else
				if Game.MusicVol > 0
					Game.MusicVol = Game.MusicVol - 10
					if Game.TitleThemeID > 0
						SetMusicVolumeOGG(Game.TitleThemeID,Game.MusicVol)
					endif
				endif
			endif
		endif

		if CheckInputRightStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			// sound lauter
			if Game.SelectSound = 0
				if Game.SoundVol < 100
					Game.SoundVol = Game.SoundVol + 10
				endif
			else
				if Game.MusicVol < 100
					Game.MusicVol = Game.MusicVol + 10
					if Game.TitleThemeID > 0
						SetMusicVolumeOGG(Game.TitleThemeID,Game.MusicVol)
					endif
				endif
			endif

		endif

		if CheckInputUpStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			// select sound or music
			if Game.SelectSound = 0
				Game.SelectSound = 1
			else
				Game.SelectSound = 0
			endif
		endif

		if CheckInputDownStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			// select sound or music
			if Game.SelectSound = 1
				Game.SelectSound = 0
			else
				Game.SelectSound = 1
			endif
		endif
	
	endif

	if Game.IsRunning = TRUE and Game.IsBlockMoving = TRUE
		
		if CheckInputLeftStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			WhileGameMoveBlockLeft(Game)
		endif

		if CheckInputRightStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			WhileGameMoveBlockRight(Game)
		endif

		if CheckInputDownStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
			WhileGameDropBlock(Game)
		endif
		
		if CheckInputActionStatePressed(Game.Joystick) = TRUE
			WhileGameShuffleBlock(Game,0)
		endif
		
		if CheckInputActionAlternateStatePressed(Game.Joystick) = TRUE
			WhileGameShuffleBlock(Game,1)
		endif
		
		if CheckInputBackStatePressed(Game.Joystick)
			AbortGame(Game)
		endif
		
	endif
	
	if Game.IsRunning = FALSE
		if Game.IsDifficultySelect = TRUE
		
			if CheckInputUpStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
				DifficultyMoveUp(Game)
			endif
			
			if CheckInputDownStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
				DifficultyMoveDown(Game)
			endif
			
			if CheckInputStartStatePressed(Game.Joystick) = TRUE
				DifficultySelect(Game,Now)
			endif
			
			if CheckInputBackStatePressed(Game.Joystick)
				AbortGame(Game)
			endif
			
		else
	
			if Game.IsHighScore = TRUE
			
				if CheckInputLeftStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
					HighscoreSwitchShiftLeft(Game)
				endif
				
				if CheckInputRightStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
					HighscoreSwitchShiftRight(Game)
				endif
				
				if CheckInputStartStatePressed(Game.Joystick) = TRUE
					StartGameInitialisation(Game)
				endif
				
			endif
			
			if Game.IsSummary = TRUE
				
				if CheckInputStartStatePressed(Game.Joystick) = TRUE
					SummarySelect(Game)
				endif
				
				if CheckInputBackStatePressed(Game.Joystick)
					AbortGame(Game)
				endif
					
				if Game.IsNewHighScore = TRUE
			
					if CheckInputLeftStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveLeft(Game)
					endif
					
					if CheckInputRightStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveRight(Game)
					endif
					
					if CheckInputUpStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
						EnterNameMoveUp(Game)
					endif
					
					if CheckInputDownStateDown(Game.Joystick,Game.InputTimer,Game.Time) = TRUE
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
