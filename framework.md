# Puzzle collection framework

Shared by Hex64, C64Doku and C64Sweeper, so the games feel the same and can later share one disk.

## Memory map

| Address | What |
|---|---|
| $0801 | Loader (BASIC). Top of memory $2400 while it runs. When it is loaded back from a game it lands at $4001, so it sets the top to $9000 instead: `POKE 56,36-108*(PEEK(44)>63)` |
| $2400-$2BFF | Game screen ($2400) and colours ($2800) saved while the instructions show |
| $2C00-$33FF | Instructions screen ($2C00) and colours ($3000), ready-made (`...HELP`) |
| $3400 | Copy routine: `POKE 780,from page:POKE 782,to page:SYS 13312` copies 4 pages. $3440-$37FF is free; C64Sweeper has its blast sprite there (blocks 209-214) |
| $3800-$3FFF | Character set (`...CHARS`) |
| $4001-$8FFF | Game (and demo), BASIC. The loader sets `POKE 44,64:POKE 16384,0` before `LOAD`; the game starts with `POKE 45,PEEK(174):POKE 46,PEEK(175):POKE 55,0:POKE 56,144:CLR` |
| $9000-$9EFF | Music player and tunes (`...MUSIC`): $9000 start, $9003 stop, $9006 two-SID flag, $9007 song, $9009 init, $900C play, $900F volume. C64Sweeper puts its board map at $9800 and its board view (`C64SWEEPERVIEW`) at $9A00-$9CFF, after the music. $9008 is free in the player; C64Sweeper puts 77 there to mark its own music file |
| $9F00 | Settings shared by the loader and the game (below) |
| $C000-$C7FF | Menu background screen ($C000) and colours ($C400) (`...BG`) |
| $C800 | Background helper, `SYS 51200`. C64Sweeper: board styles from $C83F (`POKE 780,style:SYS 51264`) |

## Settings (40704-40711)

| Byte | Meaning |
|---|---|
| 40704 | 80 = settings are set (SID detection done) |
| 40705 | 1 = two SIDs in use |
| 40706 | Music volume + 1 (0 = not set) |
| 40707 | Sound FX volume + 1 |
| 40708 | SID mode: 0 auto, 1 one SID, 2 two SIDs |
| 40709 | 82 = coming back from a game: the loader fixes the BASIC pointers |
| 40710 | Number of SIDs found |
| 40711 | Tune + 1 (0 = not set; each game picks its calm tune by default) |
| 40712 | C64Sweeper: board style + 1 (0 Classic, 1 Blue, 2 Outline, 3 Dashed; 0 = not set: Outline) |
| 40713 | C64Sweeper: 6 = its settings were set by V6 or later (otherwise the loader resets the board style) |

## Techniques

- Music on SID 1 voices 1-2. Sound FX: with two SIDs on $D420, with one SID on voice 3. Waveforms are cleared a second after a sound (6581 noise).
- Every tune has a calm version with only the long tones; T switches tunes in SID setup and the game.
- Integer arrays (`%`) everywhere; screen addresses and other per-cell values worked out once into tables; no arithmetic per keypress.
- The menu background is a ready-made screen copied by machine code; animation changes one or two characters at a time.
- The loader's Instructions can show the same ready-made help screen (C64Sweeper does), so the text exists once.
- Instructions in the game: save the screen, copy the help screen in, any key copies the board back. Nothing is redrawn in BASIC.
- Moving into an edge does nothing but clear the keyboard buffer (`POKE 198,0`).
- BASIC looks for a line from the top of the program (unless the target is far ahead) and for a variable in the order they were made: the busiest routines go first, the busiest variables are made first (`DIM J,K,A,...`), and inner loops use `IF ... THEN GOSUB` rather than a GOTO around the body. In C64Sweeper V5 this made the game several times quicker.
- When BASIC is too slow to redraw a screenful (scrolling a board), keep what each cell shows in a map in memory and let a small machine-code routine draw from it (C64Sweeper's `C64SWEEPERVIEW`).
- Printing is much quicker than POKEs: a cell of 4 characters is one string (colour code, reverse on, 2 characters, down and 2 left, 2 characters). With reverse on, screen codes 160-255 are printed as CHR$ 32-63, 192-223 and 160-191; keep 160 blank, it is the space in mixed-case text.
- Multicolour character mode (Hex64, C64Sweeper): text and plain characters may only use colours 0-7.
- The look the games share: thin blue lines on black for the playfield, white, yellow, red and green for what is on it, a mostly black screen.
- A different look can be switched in at once by copying character shapes into the character set with a little machine code and changing a shared colour (C64Sweeper's board styles).
- A multicolour character has black, the two shared colours and one of its own (0-7). Something that needs three colours on a coloured background (a red flag with a grey pole on a blue tile) only works if the background is one of the shared colours.
- If memory is short, the program on the disk can be stored without its comments (REM lines kept as bare REM); the listing in `src/` keeps them.
- Control codes typed inline in strings; mixed-case text (lowercase letters at 129-154, printed with reverse on).

## Rules for each game

- Nothing may draw on the screen while the instructions show (pause animations, timers and cursor effects; a timer must not count that time).
- Sprites are switched off while the instructions show and back on after.
- The instructions screen must suit one or two SIDs (e.g. "V - Volume (M / E with two SIDs)").
- The help file is rebuilt whenever the instructions text changes.
- The loader's "already loaded?" checks must look at bytes that differ between games. C64Sweeper's do: music `PEEK(36872)=77`, characters `PEEK(16344)=109` (a marker in character 251), background `PEEK(51263)=109` (a marker before its board style routine), help `PEEK(11268)=19` (its help text starts in column 1, so 11265 is not the 54 C64Doku looks for) and `PEEK(13344)=110`, view `PEEK(39442)=110`. Bytes that change with a version make the loader load a file again when an older version left it in memory. Hex64 and C64Doku still check bytes that pass for each other's music and background files; that needs fixing for one collection disk. Until then C64Sweeper's Quit clears 36864 and 36872, so the next game loads its own music.
