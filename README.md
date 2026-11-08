# Crystal Columns

A falling-block puzzle game written in AppGameKit Studio.

Imagine yourself in the ancient world of Phoenician merchants, playing a mysterious game of colorful gems.

Centuries later, the classic puzzle game *Columns* found its way onto arcade machines, computers, and consoles in the 1990s.

*Crystal Columns* is my own take on this timeless falling-block puzzle game.

# Version

The current version is **1.0**.

# Release

Crystal Columns V1.0 is released on itch.io as an HTML5 game playable in your browser. A Windows ZIP build is also prepared for release.

# Play Online

https://somebasics.itch.io/crystal-columns

# Gameplay & Objective

Move the falling block across the grid to position its crystals. Three or more crystals of the same color in a horizontal, vertical, or diagonal line will explode. Chain reactions (cascades) increase your score. Every gem you destroy counts.

The game ends when the crystals reach the top of the grid or there is no room for a new falling block to appear.

Every ten levels, a row of random crystals rises from the bottom. In addition to normal crystals, there are Rainbow and Magic Crystals, each with special properties. The Rainbow Crystal acts as a joker and can count as any existing color. The Magic Crystal destroys all crystals of the same color as the one it lands on.

# Difficulty & Highscores

There are five difficulty levels, from Easy to Ultra. On Ultra difficulty, you can submit your score to the online leaderboard. An internet connection is required for online submissions; if no connection is available, the connection attempt times out after three seconds.

Each difficulty level has its own local highscore table. In the HTML5 version, scores are stored using browser cookies. On Windows, local score data can be found under AppData/Local.

There are also three additional achievement leaderboards that track gems, levels, and cascades.

# Keyboard Controls

- Enter - Confirm menu selection
- Esc - Go back in menus / End game
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

Sound effects are included for gameplay, menus, scoring, and special events. The background music is a demo track from the *SnakeSnacker* example project included with AppGameKit Studio.

While the game is paused, you can adjust the sound and music volume for the current session.

# Credits

**SomeBasics**

- Game design and development
- Programming (AppGameKit Studio)
- Graphics and visual design
- Gameplay, testing, and balancing

**BYTE (AI assistant, powered by OpenAI)**

- Code review and bug research
- Debugging assistance
- Audio polish and sound processing
- Development support

**Third-party audio**

- Background music: Demo track from the *SnakeSnacker* example project included with AppGameKit Studio. Original composer and licensing terms have not been confirmed.

# License

The game source code is released under the **Unlicense**. You can use, modify, and distribute the source code freely. Third-party sound and music assets are not covered by this license.

**Note:** Crediting the *SnakeSnacker* demo track identifies its source but does not establish permission to redistribute it. Its license should be verified separately.

# Planned Features

- Add touch controls for mobile devices.
- Add original background music tracks.
