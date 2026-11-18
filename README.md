# Unblock

An Ashita v4 addon that clears whatever is blocking a command, so you don't have to do it by hand.

## What it does

| When the game says | Unblock does |
| --- | --- |
| `You cannot use that command while invisible.` | Removes **Invisible**, **Hide** and **Camouflage** with `/debuff 69`, `/debuff 76` and `/debuff 77` |
| `You cannot use that command while mounted.` | Runs `/dismount`, but only if you have the Mounted status |

Notes:

- Unblock does not re-issue the command that was blocked. Once the effect is gone, use the command again.
- The invisible check only looks at system messages, so someone saying that phrase in chat won't make you drop invisibility.
- The mounted message can arrive in other chat modes, so Unblock checks every mode for it. Before dismounting, it confirms that you're actually mounted, so someone typing the phrase in chat won't dismount you.

## Requirements

- [Ashita v4](https://ashitaxi.com/)
- The `debuff` addon by atom0s (ships with Ashita v4), loaded with `/addon load debuff`. Unblock needs it to remove the invisible effects. Dismounting works without it.

## Installation

1. Put `Unblock.lua` in `Ashita/addons/Unblock/`.
2. Load it in game with `/addon load unblock`, or add that line to your Ashita startup script.

Unblock has no commands or settings.

## License

MIT. See [LICENSE](LICENSE).
