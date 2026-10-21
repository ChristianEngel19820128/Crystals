
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function StartGameInitialisation(Game ref as TGame)

	SoundPlay(Game.MenuSelectSoundID,Game.SoundVol)
	GameInit(Game)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function PauseGame(Game ref as TGame)

	SoundPlay(Game.MenuSelectSoundID,Game.SoundVol)
	GamePause(Game)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function AbortGame(Game ref as TGame)

	SoundPlay(Game.MenuSelectSoundID,Game.SoundVol)
	Game.IsRunning = FALSE
	Game.IsPause = FALSE
	Game.IsDifficultySelect = FALSE
	Game.IsLost = FALSE
	Game.IsHighScore = TRUE
	Game.IsSummary = FALSE
	Game.IsBlockMoving = FALSE
	Game.IsFieldExploding = FALSE
	Game.IsNewHighScore = FALSE

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function WhileGameShuffleBlock(Game ref as TGame,Alignment as integer)

	SoundPlay(Game.BlockShuffleSoundID,Game.SoundVol)
	MovebleBlockShuffle(Game.CurrentBlock,Alignment)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function WhileGameDropBlock(Game ref as TGame)

	SoundPlay(Game.BlockDropSoundID,Game.SoundVol)
	MovebleBlockMoveFast(Game.CurrentBlock)
	MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function WhileGameMoveBlockLeft(Game ref as TGame)

	MovebleBlockMoveLeft(Game.CurrentBlock,Game.Field)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function WhileGameMoveBlockRight(Game ref as TGame)

	MovebleBlockMoveRight(Game.CurrentBlock,Game.Field)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function DifficultyMoveUp(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	Game.Difficulty = Game.Difficulty +1
	if Game.Difficulty > MAXDIFFICULTY
		Game.Difficulty = 0
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function DifficultyMoveDown(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	Game.Difficulty = Game.Difficulty -1
	if Game.Difficulty < 0
		Game.Difficulty = MAXDIFFICULTY
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function DifficultySelect(Game ref as TGame,Now as integer)

	SoundPlay(Game.MenuSelectSoundID,Game.SoundVol)
	Game.IsRunning = TRUE
	Game.IsBlockMoving = TRUE
	TimeReset(Game.CurrentBlock.MoveTime,Now)
	Game.IsDifficultySelect = FALSE

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function EnterNameMoveUP(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	SummaryEnterNameShiftUp(Game.Summary)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function EnterNameMoveDown(Game ref as TGame)

	SoundPlay(Game.BlockFallSoundID,Game.SoundVol)
	SummaryEnterNameShiftDown(Game.Summary)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function EnterNameMoveLeft(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	SummaryEnterNameShiftLeft(Game.Summary)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function EnterNameMoveRight(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	SummaryEnterNameShiftRight(Game.Summary)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummarySelect(Game ref as TGame)

	SoundPlay(Game.MenuSelectSoundID,Game.SoundVol)
	if Game.IsNewHighScore = TRUE
		HighScoreInsertName(Game.HighScore,Game.Summary)
	endif
	Game.IsRunning = FALSE
	Game.IsPause = FALSE
	Game.IsDifficultySelect = FALSE
	Game.IsLost = FALSE
	Game.IsHighScore = TRUE
	Game.IsSummary = FALSE
	Game.IsBlockMoving = FALSE
	Game.IsFieldExploding = FALSE
	Game.IsNewHighScore = FALSE

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighscoreSwitchShiftLeft(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	HighScoreShiftLeft(Game.HighScore)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighscoreSwitchShiftRight(Game ref as TGame)

	SoundPlay(Game.MenuSoundID,Game.SoundVol)
	HighScoreShiftRight(Game.HighScore)				

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------