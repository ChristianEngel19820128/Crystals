
//----------------------------------------------------------------------
// xbox buttons const
//----------------------------------------------------------------------

#CONSTANT JoystickButtonA 1
#CONSTANT JoystickButtonB 2
#CONSTANT JoystickButtonX 3
#CONSTANT JoystickButtonY 4
#CONSTANT JoystickButtonLR 5
#CONSTANT JoystickButtonRR 6
#CONSTANT JoystickButtonBack 7
#CONSTANT JoystickButtonStart 8
#CONSTANT JoystickButtonPadLeft 9
#CONSTANT JoystickButtonPadRight 10
#CONSTANT JoystickButton 11

#CONSTANT JoystickButtonCrossLeft 13
#CONSTANT JoystickButtonCrossUp 14
#CONSTANT JoystickButtonCrossRight 15
#CONSTANT JoystickButtonCrossDown 16

type TJoystick

	Enabled as integer
	Index as integer

endtype

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------

function SetJoystickIndex(Joystick ref as TJoystick)
	
	local i as integer
	
	Joystick.Enabled = 0
	Joystick.Index = 1
	
	If Device$ = "windows"
		CompleteRawJoystickDetection()
		for i = 8 to 1 step -1
			if GetRawJoystickExists(i)
				Joystick.Enabled = 1
				Joystick.Index = i
			endif
		next i
	endif

	// work arround for new html5 player
	If Device$ = "html5"
		Joystick.Enabled = 1
		Joystick.Index = 1
	endif

endfunction

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------