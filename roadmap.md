# C64Sweeper roadmap

Status: **DONE**, **TO DO**, **TO DO LATER**, **MAYBE**.

Branches are named `v#-short-description`, for example `v3-framework`.

## C64Sweeper

| Status | Item |
|---|---|
| DONE | Before v3: three board sizes, reveal, flood fill and flags, sound effects, drawing with POKEs (one program, `c64sweeper.prg`) |
| DONE | v3: loader with animated minefield menu, SID detection, one or two SIDs, PAL/NTSC, SID setup, instructions and credits; Q goes back to the menu |
| DONE | v3: character set (tiles, flag, mine, bold numbers, Hex64 font, mixed-case text), pulsing cursor sprite, board frame, flags-left counter |
| DONE | v3: first reveal always safe; only changed cells are drawn; W/A/S/D; instant instructions; play again or menu after a win or loss |
| DONE | v3: collection framework memory map, game at $4001, integer arrays and tables (`framework.md`) |
| DONE | v3: `c64sweeper.d64` with directory art; license CC BY-NC-SA 4.0 |
| DONE | v4: music "Mines" and "Mines Calm" (only the long tones, the default) as 2 subtunes; T switches tunes; .sid files for PAL and NTSC |
| DONE | v4: M / E volume keys with two SIDs (music $D400, sound FX $D420), V with one; the tune named under the menu and in the credits |
| DONE | v5: multicolour characters: raised tiles, flag and bomb; double-size cells on Small and Medium |
| DONE | v5: four board styles (Classic, Blue, Outline, Dashed), switched with B before or during a game; Outline the default and the menu's style |
| DONE | v5: Choose a board screen with the animated minefield behind it, following the style |
| DONE | v5: blast sprite with shake, border flash and a 3-voice explosion; neighbouring mines go off, the rest show one by one; music changes to "Mines" at a blast |
| DONE | v5: tile press, click pitch by number, flood ripple, flags and colour wave when you win, bombs in the menu background |
| DONE | v6: Large board in big cells, 16x10 view that scrolls, arrows where there is more board; Z zooms out to the whole board |
| DONE | v6: board view in machine code (`C64SWEEPERVIEW`): map of the board, instant redraw |
| DONE | v7: self-playing demo (`C64SWEEPERDEMO`, D on the menu): same games every time, all 3 boards, a blast on Medium, zoom on Large, +/- speed, Q to the menu |
| TO DO | Chain explosion: after you hit a bomb, every other bomb goes off one after another (flash, sparks, sound); any key stops it and shows the rest at once |
| TO DO | Large, zoomed in: the chain starts in the zoomed-in view, and after 5 bombs it zooms out to the whole board and carries on |
| TO DO | Listen to "Mines" on real hardware and tune it (it was composed and rendered, not heard) |
| TO DO | Test on real hardware, including two SIDs and NTSC (only tested in VICE so far, one SID; the music and the blast sounds were not heard, only checked as code and a .sid render) |
| TO DO | Update the itch.io page (the .d64 instead of the single .prg, new screenshots) and the GIF in the README |
| TO DO LATER | C64 puzzle disk: Hex64, C64Doku and C64Sweeper on one disk |
| MAYBE | Reveal the cells around a number once its flags are placed (chording) |
| MAYBE | A timer and best times |
