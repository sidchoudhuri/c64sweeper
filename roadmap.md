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
| TO DO | Listen to "Mines" on real hardware and tune it (it was composed and rendered, not heard) |
| TO DO | Test on real hardware, including two SIDs and NTSC (only tested in VICE so far, one SID; the music was checked as a .sid render) |
| TO DO | Update the itch.io page (the .d64 instead of the single .prg, new screenshots) and the GIF in the README |
| TO DO LATER | C64 puzzle disk: Hex64, C64Doku and C64Sweeper on one disk |
| MAYBE | Self-playing demo, like Hex64's |
| MAYBE | Reveal the cells around a number once its flags are placed (chording) |
| MAYBE | A timer and best times |
| MAYBE | Bigger tiles on the Small board |
