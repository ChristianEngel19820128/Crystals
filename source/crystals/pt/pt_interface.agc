
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

#CONSTANT PURPLETOKEN_SEND_IDLE 0
#CONSTANT PURPLETOKEN_SEND_WAITING 1
#CONSTANT PURPLETOKEN_SEND_READY 2
#CONSTANT PURPLETOKEN_SEND_ERROR 3

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

type TPurpleTokenSend
	State as integer
	Time as integer
	Result as integer
endtype

global PurpleTokenSend as TPurpleTokenSend

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Init()

	local Key as string
	local Password as string

	Key = PurpleToken_GetKey()
	Password = PurpleToken_GetPassword()

	PT_initialize(Key,Password)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Request(MaxItems as integer)

	local Started as integer

	Started = FALSE

	if PT_ConnectionActive() = FALSE

		PT_requestScores(MaxItems,0,0)
		Started = TRUE

	endif

endfunction Started
    
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
function PurpleToken_Receive()

	local Found as integer
	
	Found = FALSE
	
	PT_listener()
	
	if PT_getCode() = _PT_ERROR_SUCCESS
		if PT_scoresAvailable() = TRUE
			Found = TRUE
		endif
	endif

endfunction Found

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_Send(PlayerName as string,Score as integer)

	local Started as integer

	Started = FALSE

	if PurpleTokenSend.State <> PURPLETOKEN_SEND_WAITING
		if PT_ConnectionActive() = FALSE
			if Len(PlayerName) <= 32

				PT_submitScore(PlayerName,Score)

				PurpleTokenSend.Time = GetMilliseconds()
				PurpleTokenSend.Result = -1
				PurpleTokenSend.State = PURPLETOKEN_SEND_WAITING

				Started = TRUE

			endif
		endif
	endif

endfunction Started

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PurpleToken_SendDo()

	local Code as integer

	if PurpleTokenSend.State = PURPLETOKEN_SEND_WAITING

		PT_listener()

		Code = PT_getCode()

		if Code <> -1

			PurpleTokenSend.Result = Code

			if Code = _PT_ERROR_SUCCESS
				PurpleTokenSend.State = PURPLETOKEN_SEND_READY
			else
				PurpleTokenSend.State = PURPLETOKEN_SEND_ERROR
			endif

		else

			if GetMilliseconds() - PurpleTokenSend.Time >= 3000
				PT_cancelRequest()
				PurpleTokenSend.Result = -1
				PurpleTokenSend.State = PURPLETOKEN_SEND_ERROR
			endif

		endif

	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



