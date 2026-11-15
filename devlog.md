# C64Sweeper devlog

## v5 - 2026-11-15

**Multicolour characters**
- The game and the loader run in multicolour character mode. Mid grey and light grey are shared by every cell; each character has one colour of its own (the red of a flag, the yellow of a spark).
- Raised tiles, a flag on a pole and a bomb with a fuse and a spark instead of the one-colour tile, flag and mine. The small flag and both bombs were finished by m0nde.
- Small and Medium have double-size cells (2x2 characters): big tiles, big numbers, big flags and bombs. Large keeps single-size cells so it fits the screen.
- Text only uses the first 8 colours now (plain characters cannot use the others in this mode).
- Open empty cells show a small blue dot.

**Board styles**
- Four styles, which B cycles on the Choose a board screen and during a game: **Classic** (raised grey tiles), **Blue** (solid blue tiles), **Outline** (one solid blue line in the gap between cells) and **Dashed** (the same lines, dashed). The choice is kept (settings byte 40712).
- Outline is the default, and the loader's menu always uses it.
- In Outline and Dashed a covered cell has a grey dot in the middle, like C64Doku's empty cells, and an open empty cell is plain black. The lines stop short of the frame, so the black strip between the board and the frame is the same on all four sides: the cells in the last column and the last row (tile, flag, wrong flag) have edge versions without the line towards the frame, and the frame sits one step further out on the right and at the bottom.
- A style changes the board, and what stands on it adapts: a flag sits on a grey tile in Classic, a blue tile in Blue, and on black between the lines in Outline and Dashed, always with the red pennant. The flag pole reaches the top of the pennant.
- How: a character has black, two shared colours and one of its own. Mid grey is always shared; the second shared colour is light grey in Classic and blue in the others. The bomb looks the same in every style: mid grey body and fuse, a black highlight, a yellow spark.
- Switching is instant on any board: a machine-code routine (`POKE 780,style:SYS 51264`, next to the menu background in `C64SWEEPERBG`) copies the 51 characters that differ between the styles into the character set, and one POKE sets the second shared colour, so every cell on the screen changes at once.
- The numbers use the same colours in every style, from the palette of the other games: 1 white, 2 yellow, 3 red, 4 green, 5 purple, 6 cyan, 7 blue, 8 white.
- The numbers have one shape at both sizes: the big ones are the small ones with every pixel doubled, so they are sharp. The 4 is the C64's own 4 from the character ROM (the old one had too small a gap and read as a blob).

**Choose a board**
- The menu's minefield is behind it, animated the same way (cells open, close and get flags; now and then a bomb goes off), in the chosen style. B changes the style of the board and the background at once.
- The mine counts are left out so the text fits the panel; the game's header shows them.

**The blast**
- The mine you reveal goes off: a multicolour sprite at double size (6 frames: flash, fireball, smoke), the screen shakes, the border flashes, and a crater is left.
- Sound: a falling roar (noise), a low thump (triangle) and crackle (noise) on three voices.
- Music: with one SID it stops for the blast and comes back as "Mines". With two SIDs it changes to "Mines" and plays on. The next game goes back to the tune you chose with T.
- The mines next to the blast go off next (flash and sparks), then the tile over every other mine goes with a tick, one by one, and the bombs show. Flagged mines stay flags; wrong flags are crossed out. Any key hurries it up.
- Measured in VICE: about 1 second on Small, 2.6 on Medium, 4.2 on Large.

**Other animation and sound**
- A tile presses in before it opens. The click is higher the bigger the number under it.
- An area that opens up ripples: every fourth cell blips, rising.
- When you win, a flag goes up on every mine with rising notes, then a colour wave runs over the flags (white, yellow, green) before the fanfare. These flags have no tile behind them, so the green stands out.
- The menu background uses the new tiles; now and then a bomb shows and goes off.

**Speed and memory**
- Big cells are printed (a string of colour and 4 characters per kind of cell), which is much quicker than 8 POKEs; rows of tiles are printed as one string.
- The busiest routines sit at the top of the game and the busiest variables are made first, because BASIC looks for lines and variables from the start. Loops avoid GOTO where they can.
- The mine flags live in the counts array (+16) and big cells reuse the address array for their row, to fit in memory.
- The game on the disk is stored without its comments (the REM lines stay as bare REM so the line numbers match). `src/c64sweeper-game.bas` is the same program with the comments.

**Files**
- `C64SWEEPERHELP` also holds the blast sprite ($3440) and a version marker ($3420). `C64SWEEPERBG` also holds the board style routine and the four styles ($C840) and a version marker ($C83F). The character set has a version marker in character 251. The loader checks these markers, so files left in memory by an older version are loaded again.

**Version**
- Title, instructions and credits say V5; disk ID 05.

## v4 - 2026-11-15

**Music**
- New tune, "Mines", in D minor: three plucks and a pause, twice a bar, like picking a way across the field, with long tones in the middle part. The loop is about 77 seconds.
- "Mines Calm", only the long tones: every half bar of plucks becomes one held note that swells in, over the same bass. It plays by default.
- The player is the collection's (the same code and entry points as C64Doku's), in `C64SWEEPERMUSIC` at $9000. Music uses voices 1 and 2 of the first SID.
- `sid/` has both as subtunes for PAL and NTSC (subtune 2, Mines Calm, first).

**Music and volume keys, the same as Hex64 and C64Doku**
- T switches between Mines Calm and Mines, in SID setup and in the game; the choice is kept and shown under the menu, and the game names the tune on the status line for 2 seconds.
- With one SID, V sets the volume and the sound effects share voice 3. With two SIDs, M sets the music volume ($D400) and E the sound effects ($D420). Volumes start at music 2/5 and sound FX 5/5 with two SIDs, 3/5 with one.
- SID setup shows "Two SIDs: music $D400, FX $D420" with M and E, or V, and the tune.
- The instructions read "V - Volume (M / E with two SIDs)" and "T - Tune: Mines or Mines Calm".
- The credits name the music.

**Loader**
- The loader knows its own music file by a marker byte (`PEEK(36872)=77`), and Quit clears the music markers, so each game of the collection loads its own tune after another one has run.

**Version**
- Title, instructions and credits say V4; disk ID 04.

## v3 - 2026-11-15

C64Sweeper moves onto the puzzle collection framework shared with Hex64 and C64Doku (`framework.md`). It is now a disk, `c64sweeper.d64`, instead of a single program.

**Loader**
- New loader, `C64SWEEPER`, first on the disk: Play, Instructions, Credits, SID setup and Quit in a framed panel.
- Menu background: a covered minefield over the whole screen where cells open (empty, 1, 2, 3 or a flag) and are covered again, 8 times a second. It is a ready-made screen (`C64SWEEPERBG`) put up by machine code (`SYS 51200`).
- SID detection (a second SID at $D420), SID setup (auto, one or two SIDs, volume) and PAL/NTSC under the menu, the same way as Hex64 and C64Doku. Settings are kept at $9F00 between the menu and the game.
- Instructions shows the same ready-made help screen the game uses (`C64SWEEPERHELP`).

**Board**
- New character set: the Hex64 font with mixed-case text, plus a covered tile, flag, mine, the mine you hit, a crossed-out wrong flag, bold numbers 1-8 and a thin frame.
- The cursor is a sprite outline that pulses around the cell, so the cell keeps its own colour.
- A frame around the board; the header shows the board size and the flags left (it used to show the mine count and never changed).

**Game**
- Your first reveal is always safe: if it lands on a mine, the mine moves to a free cell and only the counts around the two cells change. The top-left cell is no longer special.
- Only the cells that change are drawn. A reveal used to redraw the whole board.
- W/A/S/D as well as the cursor keys; F flags as well as RETURN; S/M/L pick the board as well as 1/2/3.
- I shows the instructions instantly and puts the board back exactly as it was.
- Q asks "Quit to the menu? Y/N" and goes back to the loader. After a win or a loss, SPACE plays again and Q goes to the menu.
- When you lose, every mine shows, the one you hit is marked and wrong flags are crossed out. When you win, the mines are flagged in green.
- The win fanfare's delays could never end (each loop reset its own start time); they are fixed.

**Memory and speed (the collection framework)**
- The game loads at $4001 with the top of memory at $9000; screen save $2400, instructions $2C00, copy routine $3400, characters $3800, settings $9F00, menu background $C000.
- All arrays are integer. The board has a border of open cells, so nothing checks for edges; each cell's screen address and the cursor sprite positions are in tables, and moving does no arithmetic.
- Mines add 1 to the 8 cells around them, instead of every cell counting its 8 neighbours. The tiles are drawn while the tables are filled.
- Moving into an edge does nothing but clear the keyboard buffer.

**Sound**
- Sound effects only, the same five as before (move, reveal, flag, boom, fanfare). With one SID they play on voice 3; with two SIDs on $D420. V sets the volume, in SID setup and in the game.
- Waveforms are cleared after a sound (6581 noise).

**Version and license**
- Title, instructions and credits say V3; disk ID 03, with directory art of a game in progress.
- License changed from CC0 to CC BY-NC-SA 4.0, like the other games.
