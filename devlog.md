# C64Sweeper devlog

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
