# Crystals

A puzzle game written in AppGameKit Studio.

Imagine yourself in the ancient world of Phoenician merchants, playing a mysterious game of colorful gems.

Centuries later, the classic puzzle game *Columns* found its way onto arcade machines, computers, and consoles in the 1990s.

*Crystal Columns* is my own take on this timeless falling-block puzzle game.

# Version

The current version is 0.9996.

# License

The code is released under the Unlicense. You can use, modify, and distribute it freely. Sound and music created by third parties are not covered by this license.

# Release

Version 1.0 is planned for release on itch.io as an HTML5 game playable in your browser and as a Windows download.

# Link to HTML5

https://somebasics.itch.io/crystal-columns

# Gameplay & Objective

Move the falling block across the grid to position its crystals. Three or more crystals of the same color in a horizontal, vertical, or diagonal line will explode. Chain reactions (cascades) increase your score. Every gem you destroy counts.

The game ends when the crystals reach the top of the grid or there is no room for a new falling block to appear.

Every ten levels, a row of random crystals rises from the bottom. In addition to normal crystals, there are Rainbow and Magic Crystals, each with special properties. The Rainbow Crystal acts as a joker and can count as any existing color. The Magic Crystal destroys all crystals of the same color as the one it lands on.

# Difficulty & Highscores

On Ultra difficulty, you can submit your score to an online leaderboard. If no network connection is available, the connection attempt times out after three seconds. Online submissions currently use a test leaderboard.

Each difficulty level has its own local highscore table. In the HTML5 version, scores are stored as cookies. On Windows, you can find them under AppData/Local if you want to edit them.

There are also three additional achievement leaderboards that track gems, levels, and cascades.

# Keyboard Controls

- Enter - Confirm menu selection
- Back - Go back in menus
- Esc - End game
- A/D or Left/Right - Move block
- W or Up - Shuffle block upward
- S or Down - Drop block

# Controller Controls

Connect your controller before starting the game; otherwise, controller input will be disabled.

- Start - Confirm menu selection
- Back - Go back in menus
- Stick/D-pad Left/Right - Move block
- Stick/D-pad Down - Drop block
- Button A - Shuffle block downward
- Button B - Shuffle block upward

# Sound & Music

Sound effects are included. Music is currently disabled until suitable music files are available.

While the game is paused, you can adjust the sound and music volume for the current session.

Sound effect files:

- sndnextlvl.wav
- sndexplode.wav
- sndblockfall.wav
- sndblockdrop.wav
- sndshuffle.wav
- sndmenu.wav
- sndmenuselect.wav
- sndscore.wav

Planned music format:

- `*.ogg`

# Planned Features

- Add touch controls for mobile devices.
- Add two theme music tracks.
