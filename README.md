# SelectBeam

> Highlight code, press one shortcut, send it to terminal AI or browser AI — same tab every time. No copy-paste.

SelectBeam hands your selected code to an AI, with file name and line numbers attached:

````markdown
```python
// MergeSort.py (lines 12-25)
def merge(arr, low, mid, high):
    ...
```
````

You review it and press Enter yourself. SelectBeam never submits for you.

Repo: https://github.com/NoahMenezes/SelectBeam

## Install (VS Code, VSCodium, Cursor, Windsurf, Antigravity…)

Same code, same `.vsix` — SelectBeam uses only stable VS Code APIs, so one
build runs on every VS Code-compatible editor.

| Editor | How to install |
|---|---|
| **VS Code** | Extensions view (`Ctrl+Shift+X`) → search `SelectBeam`, or `vsce publish` listing. |
| **VSCodium** | Extensions view → search `SelectBeam` on **Open VSX** (`open-vsx.org`). VSCodium can't use Microsoft's gallery, so Open VSX is its native source. |
| **Cursor** | Extensions view usually syncs the VS Marketplace listing — search `SelectBeam`. If a version lags, `Ctrl+Shift+P` → `Extensions: Install from VSIX…` with the `.vsix` from GitHub Releases. |
| **Windsurf** | Same as Cursor: gallery search first, else `Install from VSIX…`. CLI: `windsurf --install-extension selectbeam-*.vsix`. |
| **Antigravity** | `...` menu in Extensions view → `Install from VSIX…`, or CLI: `antigravity --install-extension selectbeam-*.vsix`. Open VSX search also works. |
| **Theia / Gitpod / Eclipse / Positron** | Native Open VSX gallery — search `SelectBeam`. |
| **Devin** | Not a marketplace editor — it works inside your repo. Run `code --install-extension selectbeam-*.vsix` in its environment, or add the `.vsix` to your devcontainer setup. |

Maintainer notes (publishing both galleries):

```bash
vsce publish   # VS Code Marketplace (covers VS Code + Cursor/Windsurf gallery sync)
ovsx publish   # Open VSX (covers VSCodium, Theia, Gitpod, Antigravity-via-OpenVSX)
```

First Open VSX release needs a one-time namespace claim
(`ovsx create-namespace NoahMenezes`) plus `OVSX_PAT` from
`open-vsx.org`. After that, pushing a `v*` tag runs
`.github/workflows/publish.yml`, which publishes to **both** galleries and
attaches the `.vsix` to the GitHub Release for manual installs.
Not supported: Zed, Sublime, Neovim — different extension systems, not VSIX.

## Status

- **VS Code extension:** v0.0.6, VS Code 1.85+. Terminal AI, browser AI, clipboard — all working.
- **Edge Add-ons:** SelectBeam Bridge 0.0.4 submitted, link to follow after approval.
- **Firefox AMO:** SelectBeam Bridge 0.0.4 submitted, link to follow after approval.
- **Brave:** working via unpacked `selectbeam-bridge-brave-0.0.4.zip` (Brave-gated auto-paste fix included).
- **Chrome Web Store:** listing prepped (`browser/CWS-LISTING.md`), on hold — one listing will cover Brave + Chrome + Opera + Vivaldi + Arc.
- **Next up:** Safari (needs Xcode + Mac), Opera Add-ons.

## What you need

1. **VS Code 1.85 or newer.**
2. One of these:
   - **Terminal way:** OpenCode, Claude Code, Codex CLI, Copilot CLI, aider, Gemini CLI, Qwen Code, Cursor agent, Amp, Anti-Gravity, Crush, or Goose. Different binary name? Map it in `selectbeam.agentCommands`, e.g. `{ "copilot": "gh copilot" }`.
   - **Browser way:** ChatGPT, Claude, Gemini, DeepSeek, Grok, or Copilot — SelectBeam opens it for you.
   - **Browser way with tab reuse (recommended):** the free `browser/` companion (below). Repeat sends refill the SAME chat tab.

No account, no API key. Install and use.

## How to use

1. **Highlight code** in any file.
2. **Send it:** `Ctrl+Alt+A` (`Cmd+Alt+A` on Mac), or palette (`Ctrl+Shift+P`, type `SelectBeam`), or right-click.
3. **Answer one question if asked** (pick terminal AI / browser AI / clipboard; SelectBeam asks before using an unknown terminal).
4. **Check and submit yourself.** Terminal: code waits in the AI prompt. Browser without companion: one `Ctrl+V`. Browser with companion: auto-fills in ~2s.

First send to a new AI picks the browser app (Firefox, Edge, Chrome, Brave…), opens its chat, auto-fills on load. Later sends offer **Existing tab** or **New tab**. Set `selectbeam.systemBrowser: last` to skip the app picker.

## Mac keys

| Windows / Linux | Mac |
|---|---|
| `Ctrl+Alt+A` | `Cmd+Alt+A` |
| `Ctrl+V` | `Cmd+V` |
| `Ctrl+Shift+P` | `Cmd+Shift+P` |
| `Ctrl+,` | `Cmd+,` |

If the shortcut does nothing, rebind it under File → Preferences → Keyboard Shortcuts (macOS sometimes reserves `Cmd+Alt` combos).

## Commands

| Command | What it does |
|---|---|
| SelectBeam: Send Selection to AI | Sends to a terminal AI (or pick a browser AI from the same list). Shortcut + right-click. |
| SelectBeam: Send Selection to Browser AI | Always lets you pick the AI (and remembers it). |
| SelectBeam: Choose Send Target | Reset to Auto, clipboard-only for this session, or pin one terminal. Auto clears all saved picks, live tabs, and queue. |
| SelectBeam: Show Browser Bridge Status | Bridge port, linked tabs, queued items. |

## Settings

Search `SelectBeam` in Settings (`Ctrl+,`). Defaults work for most people.

| Setting | Default | Meaning |
|---|---|---|
| `selectbeam.defaultTarget` | `"auto"` | `"auto"` = terminal first, clipboard fallback. `"clipboard"` = always copy. `"terminal"` = always terminal. |
| `selectbeam.rememberTerminalChoice` | `true` | Ask once, not every time. |
| `selectbeam.askForPrompt` | `true` | Ask for a note after code (`explain this`). Empty = code only. |
| `selectbeam.agentStartDelayMs` | `2000` | Wait after starting an AI tool before pasting (ms). |
| `selectbeam.agentCommands` | `{}` | Override tool binaries, e.g. `{ "copilot": "gh copilot" }`. |
| `selectbeam.defaultBrowser` | `"last"` | Ask once, then automatic. `"ask"` = every time, or fix one AI. |
| `selectbeam.rememberBrowserChoice` | `true` | Remembers browser pick for `"last"`. |
| `selectbeam.systemBrowser` | `"ask"` | Which app opens the chat: `"ask"`, `"last"`, `"system"`, `"firefox"`, `"edge"`, `"chrome"`, `"chromium"`, `"brave"`. |
| `selectbeam.rememberSystemBrowserChoice` | `true` | Remembers app pick for `"last"`. |
| `selectbeam.browserUrls` | `{}` | Override chat URLs, e.g. `{ "deepseek": "https://chat.deepseek.com/" }`. |
| `selectbeam.reuseBrowserTab` | `true` | Reuse the linked tab. Needs the companion. |
| `selectbeam.liveTabTTLMinutes` | `60` | Outer bound for linked-tab freshness (tabs also heartbeat every 15s; stale tabs open fresh). |
| `selectbeam.bridgeEnabled` | `true` | Run the localhost bridge. Off = copy+open only. |
| `selectbeam.bridgePort` | `51337` | Change only if taken. |

## Browser companion

Vanilla MV3, no build, no `npm install`. Works with all 6 AIs the same way. No token, no pairing — chat tabs link themselves on load.

| Browser | Recommended | Fallback |
|---|---|---|
| **Edge** | Edge Add-ons — submitted, link to follow | `edge://extensions` → Developer mode → Load unpacked → `browser/` |
| **Firefox, Zen, LibreWolf…** | Firefox AMO — submitted, link to follow | `about:debugging#/runtime/this-firefox` → Load Temporary Add-on → `browser/manifest.json` |
| **Brave** | Unzip `selectbeam-bridge-brave-0.0.4.zip` → `brave://extensions` → Developer mode → Load unpacked (CWS listing later covers it) | `browser/` folder directly |
| **Chrome, Opera, Vivaldi, Arc** | CWS listing (prepped, on hold) | Same unpacked flow (`chrome://extensions`, `opera://extensions`, …). Opera also accepts CWS via “Install Chrome Extensions”. |

Chromium unpacked loads use `browser/manifest.chrome.json` as `browser/manifest.json` (background key differs); Firefox uses `manifest.firefox.json`. Brave: Shields down for the chat site if fills miss; log in first (logged-out landings reject fill). **Safari:** later — needs an Xcode wrapper + Mac.

Bridge: `http://127.0.0.1:51337` only, extension-origin check, no password. One VS Code window owns it; a second falls back to copy+open.

## Privacy — what SelectBeam stores (Open VSX Data Information)

SelectBeam works fully offline apart from opening AI chat sites you choose. No account, no API key, no analytics, no telemetry, no remote servers.

What is handled, all on your own machine:

- **Your selected code + file reference** (e.g. `MergeSort.py (lines 12-25)`): always copied to your clipboard first so nothing is lost, and held in an in-memory queue (max 20 items, max ~500KB each) so the browser companion can fill the chat box. Purpose: tab reuse. Retention: memory only, cleared on window close or via `SelectBeam: Choose Send Target` → Auto. Shared with: nobody — localhost only.
- **Linked chat tabs** (provider id, page URL up to 500 chars, page title up to 200 chars, timestamp): reported by the optional browser companion over `http://127.0.0.1`. Purpose: refill the same tab instead of opening new tabs. Retention: expires after `selectbeam.liveTabTTLMinutes` (default 60 min, hard reuse window 90s); cleared via Choose Target → Auto. Shared with: nobody.
- **Your picks** (remembered terminal name, terminal→agent map, last browser AI, last browser app): stored in VS Code `workspaceState`/`globalState` on your machine. Purpose: ask once, then automatic. Retention: until you reset via Choose Target → Auto. Shared with: nobody.
- **Bridge port** (`51337` by default, changeable via `selectbeam.bridgePort`): stored in VS Code settings and in the companion's local storage. Purpose: localhost connection only.

The localhost bridge binds `127.0.0.1` only, accepts only companion extension origins (`moz-extension://`, `chrome-extension://`) or no-origin local callers, and rejects any `http(s)` page origin — websites can never read your queue. Only the open health check `GET /status` (version + counts, no code) skips the origin check.

The browser companion (separate store listing, not bundled in this VSIX) reads the open chat page's title/URL and fills its visible chat box. It never auto-submits, never contacts any server other than your localhost bridge.

If this policy changes, it will be updated here before any new publish. Questions: https://github.com/NoahMenezes/SelectBeam/issues

## If something goes wrong

- **Shortcut does nothing:** highlight code first; else rebind in Keyboard Shortcuts.
- **New tab every time:** no tab linked — companion unloaded (re-load Firefox temporary add-on; Chromium unpacked persists) or chat closed. Check Bridge Status.
- **Badge “bridge off?”:** VS Code closed, `bridgeEnabled` off, or wrong port. Click badge to retry.
- **Chat box empty:** wait ~30s (Brave ~60s) for editor load; code is also in clipboard (`Ctrl+V`). Persistent failure = site redesign → `SELECTORS` table in `browser/content.js`.
- **Terminal shows `bquote>`:** code landed in a plain shell — `Ctrl+C`, then run your AI tool there first.

## Building from source

Offline-safe, `node_modules` vendored:

```bash
bun run check-types  # type-check
bun run compile      # one-off build
bun run watch        # rebuild on save (used by F5)
bun run package      # minified production build
```

Press **F5** for the Extension Development Host. VS Code side is `src/` (see `docs/CODE-NOTES.md` for the module map — source files are comment-free by design). Browser side is `browser/`.

## Support

Bug reports and feature requests: https://github.com/NoahMenezes/SelectBeam/issues

## Trademarks

All third-party AI and browser names (ChatGPT, Claude, Gemini, DeepSeek, Grok, Copilot, Firefox, Edge, Chrome, Brave, etc.) and their sites are property of their respective owners. SelectBeam is an independent project with no affiliation with or endorsement by any of them.
