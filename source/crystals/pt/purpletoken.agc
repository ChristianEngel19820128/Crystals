

/*
*
* Author:       Phaelax
* Date:         Aug 18, 2025
* Version:      3.1
*
* Changes:      V3 adds a new layer of security by adding a supplied hash
*               to validate the integrity of the message is genuine. This
*               requires the developer to create a secret key or passphrase
*               (done through the PT website). The key is used to salt the
*               data sent and hash it with SHA256. This hash is sent along
*               with the payload. The server will perform the same hash to
*               see if they match. The key itself is never sent, making it
*               nearly impossible to fake the check on the payload. This
*               also means exposure of your api_key is no longer a concern.
* 
* 
* Description:  The Purple Token library was created to make it
*			    easier for users to incorporate the functionality
*               of the Purple Token high-score service from within
*			    AGK Tier 1.
*
* Score format: No_Of_Entries,User1,Score1,User2,Score2,User3,Score3
*
*/


Type _PurpleToken_Score
	id     as integer
	player as string
	score  as integer
	date   as string
EndType


// Internally used variables. You should never need to access
// _PT directly in your application
Type _PurpleToken
	key				as string
	passphrase		as string
	connection   	as integer
	connType		as integer
	code			as integer
	scoresRetrieved as integer
	scores 			as _PurpleToken_Score[]
Endtype


Global _PT as _PurpleToken


// This array is safe to access from your application
// and contains the return codes possible for score submission
// The exception is an error code of -1, which is an unknown error
Global _PT_Codes as string[7]


#CONSTANT _PT_SCORE_GET    = 1
#CONSTANT _PT_SCORE_SEND   = 2
#CONSTANT _PT_SCORE_DELETE = 3

#CONSTANT _PT_ERROR_UNKNOWN   = 0
#CONSTANT _PT_ERROR_SUCCESS   = 1  // Request was successful
#CONSTANT _PT_ERROR_NAMELEN   = 2  // player name is too long, limit is 32 characters
#CONSTANT _PT_ERROR_BADKEY    = 3  // Game key was not found or is invalid
#CONSTANT _PT_ERROR_LOWSCORE  = 4  // score too low to make the board
#CONSTANT _PT_ERROR_REQS      = 5  // missing parameters for the requested action
#CONSTANT _PT_ERROR_RIGHTS    = 6  // Insufficient rights, typically because delete capability is not set for that key
#CONSTANT _PT_ERROR_INTEGRITY = 7  // supplied hash did not match payload




// Must be called before using any other PT commands
// 'secret' is your pass phrase created on your PT account
// Never share this! Only you and the server know it.
function PT_initialize(pt_gameKey as string, pt_secret as string)
	_PT.key  = pt_gameKey
	_PT.passphrase = pt_secret
	_PT.code = -1
	
	_PT_Codes[_PT_ERROR_UNKNOWN]   = "Unknown Error"
	_PT_Codes[_PT_ERROR_SUCCESS]  = "Success"
	_PT_Codes[_PT_ERROR_NAMELEN]   = "Name length exceeds 32 characters"
	_PT_Codes[_PT_ERROR_BADKEY]    = "Gamekey not recognized"
	_PT_Codes[_PT_ERROR_LOWSCORE]  = "Score too low"  // Score was too low to make the top 20
	_PT_Codes[_PT_ERROR_REQS]      = "Missing requirement"  // if you forgot an ID on deletion 
	_PT_Codes[_PT_ERROR_RIGHTS]    = "Insufficient Rights"
	_PT_Codes[_PT_ERROR_INTEGRITY] = "Payload integrity check fail"
endfunction






// Initiate the connection to get list of scores
// Once the request has completed, PT_scoresAvailable() will return 1
//
// limit		how many scores to return (decending order by score)
// incDates		If 1 then score submission dates are included
// incIDs		If 1 then score IDs is included (only necessary if you plan on manually deleting a score)
function PT_requestScores(pt_limit, pt_incDates, pt_incIDs)
	local pt_vars$   as string
	local pt_extras$ as string
	local pt_payload$ as string
	local pt_sig$     as string
	local pt_params$  as string
	
	_PT.connType = _PT_SCORE_GET
	_PT.scoresRetrieved = 0
    _PT.connection = createHTTPConnection()
    setHTTPHost(_PT.connection, "purpletoken.com", 1, "", "")
    
    pt_extras$ = "&limit="+str(pt_limit)
    if pt_incDates = 1 then pt_extras$ = pt_extras$ + "&dates=yes"
	if pt_incIDs   = 1 then pt_extras$ = pt_extras$ + "&ids=yes"

    pt_vars$ = "format=json&array=yes&gamekey="+_PT.key + pt_extras$
    
    pt_payload$ = stringToBase64(pt_vars$)
	pt_sig$ = sha256(pt_payload$+_PT.passphrase)
	
	pt_params$ = "payload="+pt_payload$+"&sig="+pt_sig$
    
    sendHTTPRequestASync(_PT.connection, "update/v3/get", pt_params$)
	
endfunction



// Delete a score
function PT_deleteScore(pt_id as integer)
	local pt_vars$ as string
	local pt_payload$ as string
	local pt_sig$     as string
	local pt_params$  as string
	
	_PT.connType = _PT_SCORE_DELETE
	
    _PT.connection = createHTTPConnection()
    setHTTPHost(_PT.connection, "purpletoken.com", 1, "", "")
 
    pt_vars$ = "gamekey="+_PT.key+"&score_id="+str(pt_id)
 
	pt_payload$ = stringToBase64(pt_vars$)
	pt_sig$ = sha256(pt_payload$+_PT.passphrase)

	pt_params$ = "payload="+pt_payload$+"&sig="+pt_sig$
	
    sendHTTPRequestASync(_PT.connection, "update/v3/delete", pt_params$)
endfunction



// Submit a score
function PT_submitScore(pt_player as string, pt_score as integer)
	local pt_vars$    as string
	local pt_payload$ as string
	local pt_sig$     as string
	local pt_params$  as string
	
	_PT.connType = _PT_SCORE_SEND
	//_PT.scoreSubmitted = 0
    _PT.connection = createHTTPConnection()
    setHTTPHost(_PT.connection, "purpletoken.com", 1, "", "")

    pt_vars$ = "player="+pt_player+"&score="+str(pt_score)+"&gamekey="+_PT.key
	pt_payload$ = stringToBase64(pt_vars$)
	pt_sig$ = sha256(pt_payload$+_PT.passphrase)

	pt_params$ = "payload="+pt_payload$+"&sig="+pt_sig$

    sendHTTPRequestASync(_PT.connection, "update/v3/submit", pt_params$)
endfunction

 



// Handles the http responses for API calls
// It is safe to call this every iteration of your game loop as it
// will not block
function PT_listener()
	local pt_ptResponse as integer

	if _PT.connection > 0
		
		if _PT.connType = _PT_SCORE_SEND  // Score submission
			
			pt_ptResponse = getHTTPResponseReady(_PT.connection)
			
			if pt_ptResponse = -1
				_PT.code = _PT_ERROR_UNKNOWN
			elseif pt_ptResponse = 1
				_PT.code = val(GetHTTPResponse(_PT.connection))
			endif
			
		elseif _PT.connType = _PT_SCORE_GET  // Score retrieval
			local r$ as String
			
			pt_ptResponse = getHTTPResponseReady(_PT.connection)
			
			if pt_ptResponse = -1
				_PT.code = _PT_ERROR_UNKNOWN
			elseif pt_ptResponse = 1
				r$ = GetHTTPResponse(_PT.connection)
				if val(r$) = 0
					_PT.scores.fromJSON(r$)
					_PT.scoresRetrieved = 1
					_PT.code = _PT_ERROR_SUCCESS
				else
					_PT.code = val(r$)
				endif
			endif
			
		elseif _PT.connType = _PT_SCORE_DELETE // Score deletion
			
			pt_ptResponse = getHTTPResponseReady(_PT.connection)
			
			if pt_ptResponse = -1
				_PT.code = _PT_ERROR_UNKNOWN
			elseif pt_ptResponse = 1
				_PT.code = val(GetHTTPResponse(_PT.connection))
			endif
		endif
		
		
		if pt_ptResponse <> 0 // response is completed, success or fail, close the connection
			closeHTTPConnection(_PT.connection)
			deleteHTTPConnection(_PT.connection)
			_PT.connection = 0
		endif
		
	endif
	
endfunction




function PT_getScoreArray()

endfunction _PT.scores



// After a score submission or deletion request has finished a code is generated (for success or possible errors)
// Once this function is called the code is cleared until a new request is made
function PT_getCode()
	local pt_code as integer
	pt_code = _PT.code
	_PT.code = -1
endfunction pt_code



// Check if new score data is available after a request is made through PT_requestScores()
// Returns 1 for true, 0 otherwise. This will reset to 0 if a new request is made until
// that request completes.
function PT_scoresAvailable()
	
endfunction _PT.scoresRetrieved


// Returns a human-friendly string of the error code
function PT_getCodeString(pt_err)
	if pt_err < 0 or pt_err > 7 then exitfunction "Invalid Code"
endfunction _PT_Codes[pt_err]




// Returns 1 if there's an active connection, otherwise 0
function PT_ConnectionActive()
    if _PT.connection <> 0 then exitfunction 1
endfunction 0


// Cancels the current HTTP request and resets its response state
function PT_cancelRequest()

	if _PT.connection <> 0
		closeHTTPConnection(_PT.connection)
		deleteHTTPConnection(_PT.connection)
		_PT.connection = 0
	endif

	_PT.code = -1
	_PT.scoresRetrieved = FALSE

endfunction





