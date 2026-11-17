# [C64Sweeper](https://m0n.de/?disk=c64sweeper&full=1)

A Minesweeper clone for the Commodore 64, written in C64 BASIC V2

https://m0nde.itch.io/c64sweeper

## Features

- Three board sizes: Small (8x8, 10 mines), Medium (16x10, 30 mines), Large (24x14, 60 mines)
- Classic minesweeper reveal/flood-fill/flag gameplay; your first reveal is always safe
- Loader with a menu, instructions, credits, a self-playing demo and SID setup (one or two SIDs, PAL or NTSC)
- Multicolour character set: flags and bombs, double-size cells on Small and Medium
- Four board styles: Classic, Blue, Outline and Dashed
- The Large board scrolls in big cells; Z zooms out to see all of it
- The mine you hit blows up, and the other mines follow
- Music: "Mines" and "Mines Calm"
- SID sound effects for moving, reveal, flagging, winning and losing

## Controls
- Cursor keys or W/A/S/D: move cursor
- Space: reveal cell
- Return or F: flag/unflag cell
- V: volume (M / E with two SIDs)
- T: tune
- B: board style
- Z: zoom in or out (Large board)
- I or H: instructions
- Q: back to the menu

## Demo
D on the menu starts the demo: the game plays itself on all three boards. + and - change the speed, Q goes back to the menu.

## Playing
Mount c64sweeper.d64 in VICE or on your C64 Ultimate or Ultimate 64, or write it to a disk.
```
LOAD "*",8
RUN
```

## Files

- `c64sweeper.d64` - the disk
- `src/` - the loader, game and demo listings, and the assembly for the music, menu background and help screen
- `prg/` - the programs on the disk
- `font/` - the character set
- `sid/` - the music as .sid files for PAL and NTSC
- `framework.md` - the memory map and techniques shared with Hex64 and C64Doku
- `devlog.md`, `roadmap.md`
