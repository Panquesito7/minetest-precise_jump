# Precise Jump

[![luacheck](https://github.com/Panquesito7/minetest-precise_jump/actions/workflows/luacheck.yml/badge.svg)](https://github.com/Panquesito7/minetest-precise_jump/actions/)
[![ContentDB](https://content.minetest.net/packages/Panquesito7/precise_jump/shields/downloads/)](https://content.minetest.net/packages/Panquesito7/precise_jump/)

Calculates jump time and reduces the speed of the player for a more realistic feeling.\
This is something that's being used in a lot of **platformer** games. Very useful in:

- Advanced parkours that do not require the full jump.
- The full jump isn't required in various cases.
- Very specific cases, such as PvE and PvP.

![Screenshot](https://raw.githubusercontent.com/Panquesito7/minetest-precise_jump/main/screenshot.png)

Here's a video showcasing the mod in action.

[![Precise Jump showcase](https://markdown-videos-api.jorgenkh.no/url?url=https%3A%2F%2Fyoutu.be%2FTB1LNyI5Fzw)](https://youtu.be/TB1LNyI5Fzw)

## Settings

These settings can be customized by modifying [`minetest.conf`](https://wiki.minetest.net/Minetest.conf) or directly in the Minetest settings.

- `precise_jump.privilege_required`: Whether a privilege is required or not to perform precise jumps (`false` by default).

## To-do

- Make it a more smooth feeling when jumping.
- Probably adjust the velocity values.

## Installation

- Unzip the archive, rename the folder to `precise_jump` and
place it in `..minetest/mods/`

- GNU/Linux: If you use a system-wide installation place
    it in `~/.minetest/mods/`.

- If you only want this to be used in a single world, place
    the folder in `..worldmods/` in your world directory.

For further information or help, see:\
<https://wiki.minetest.net/Installing_Mods>

## License

See [`LICENSE.md`](LICENSE.md) for full details.
