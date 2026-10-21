
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundInit(Game ref as TGame)
	
	local File as TFilePath
	
	File.Path = "/media/sfx"
	
	File.Name = "sndnextlvl.wav"
	
	if FilePathSetAndCheck(File)
		Game.NextLevelSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndexplode.wav"
	
	if FilePathSetAndCheck(File)
		Game.ExplodeSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndblockfall.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockFallSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndblockdrop.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockDropSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndshuffle.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockShuffleSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndmenu.wav"
	
	if FilePathSetAndCheck(File)
		Game.MenuSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndmenuselect.wav"
	
	if FilePathSetAndCheck(File)
		Game.MenuSelectSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndscore.wav"
	
	if FilePathSetAndCheck(File)
		Game.ScoreSoundID = LoadSound(File.Name)
	endif

	File.Name = "hello2.ogg"
	
	if FilePathSetAndCheck(File)
		Game.TitleThemeID = LoadMusicOGG(File.Name)
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundPlayPitched(SoundID as integer,Rate as float,Vol as integer)
	
	local Value as integer
	
	if GetSoundExists(SoundID) = 1
		Value = PlaySound(SoundID)
		SetSoundInstanceVolume(Value,Vol)
		if GetSoundMinRate() < Rate and GetSoundMaxRate() > Rate
			SetSoundInstanceRate(Value,Rate)
		endif
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundPlay(SoundID as integer,Vol as integer)
	
	local Value as integer
	
	Value = SoundPlayPitched(SoundID,1,Vol)

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------





