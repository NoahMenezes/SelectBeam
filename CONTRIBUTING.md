# Contributing to SelectBeam

Thanks for picking up SelectBeam! This guide gets you from clone to PR in a few minutes.

> **New here?** Good first places to look: open [Issues](https://github.com/NoahMenezes/SelectBeam/issues) labeled `good first issue`, and read [`docs/CODE-NOTES.md`](docs/CODE-NOTES.md) for the module map.

## 1. Ground rules

- Be kind and constructive — see [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). It applies to issues, PRs, and discussions.
- Security-sensitive finding? **Do not open a public issue.** Follow [`SECURITY.md`](SECURITY.md) instead.
- One PR = one change. Keep diffs small and focused so review is fast.
- VS Code side is TypeScript (`src/`), browser side is vanilla JS (`browser/`, no build, no `npm install` there).
- **Comment-free sources by design.** `src/*.ts` ships with (almost) no comments. Explanations live in [`docs/CODE-NOTES.md`](docs/CODE-NOTES.md). If your change needs explanation, update `CODE-NOTES.md` — don't add inline comments (except where the compiler forces you, e.g. `// @ts-expect-error` with justification, or a `// Esc` dismissal note matching existing convention).
- Never auto-submit for the user. SelectBeam fills prompts / chat boxes only — the user always presses Enter. Any PR that submits on the user's behalf will be rejected.
- No telemetry, no remote servers, no API keys. The only networking is the localhost bridge (`127.0.0.1`) between the extension and the companion. Keep it that way.

## 2. Prerequisites

- **Node 22+** (see [`.nvmrc`](.nvmrc); `nvm use` / `fnm use` picks it up) and **[Bun 1.x](https://bun.sh)** (project convention — scripts use `bun run`).
- **VS Code 1.85+** (or VSCodium / Cursor / Windsurf for manual `.vsix` testing).
- For the browser companion: Firefox and/or a Chromium browser (Chrome / Edge / Brave) for `Load unpacked` testing.

## 3. Setup

```bash
git clone https://github.com/NoahMenezes/SelectBeam.git
cd SelectBeam
bun install
bun run check-types   # type-check (tsc --noEmit)
bun run compile       # one-off esbuild to dist/
```

Press **F5** in VS Code to open the Extension Development Host with SelectBeam loaded. The default build task (`bun run watch`) rebuilds on save.

Useful scripts (`package.json`):

| Script                 | What it does                               |
| ---------------------- | ------------------------------------------ |
| `bun run check-types`  | `tsc --noEmit` — must pass before every PR |
| `bun run compile`      | dev build to `dist/` (with sourcemap)      |
| `bun run watch`        | rebuild on save (used by F5)               |
| `bun run package`      | minified production build                  |
| `bun run format`       | Prettier write (`bunx prettier --write .`) |
| `bun run format:check` | Prettier check (what CI runs)              |
| `bun run clean`        | remove `dist/` build output                |

Browser companion needs no build:

- Chromium: `chrome://extensions` (or `edge://`, `brave://`) → Developer mode → Load unpacked → `browser/` (see `browser/CHROMIUM-SETUP.md`).
- Firefox: `about:debugging#/runtime/this-firefox` → Load Temporary Add-on → `browser/manifest.json` (see `browser/FIREFOX-SETUP.md`).

## 4. Project layout

```text
src/               VS Code extension (TypeScript, bundled by esbuild to dist/extension.js)
  extension.ts     wiring only — no behavior here
  commands.ts      palette command orchestration
  terminal.ts      terminal-AI send path
  browserSend.ts   browser-AI send path
  bridge.ts        localhost HTTP bridge (Node http only, zero deps)
  systemBrowser.ts browser APP picker + launcher
  config.ts        all selectbeam.* settings reads
  payload.ts       code-block building + clipboard
  state.ts         workspaceState / globalState
  constants.ts     storage keys, limits, agent + browser catalogs (no vscode import)
  platform.ts      OS/Mac helpers (no vscode import)
  types.ts         shared types (no runtime code)
browser/           companion extension (vanilla MV3, no build)
  content.js       per-site chat-box find + verified fill (SELECTORS table)
  background.js    owns ALL bridge networking (extension Origin trust)
  popup.js         status-only popup
  manifest.*.json  per-store manifests (firefox / chrome / brave)
docs/CODE-NOTES.md archived explanations for the comment-free sources
walkthroughs/      in-product Get Started pages
```

Read [`docs/CODE-NOTES.md`](docs/CODE-NOTES.md) alongside the source — it documents every module's invariants (bridge endpoints, reuse window, origin checks, paste strategies).

## 5. Workflow

1. **Find or file an issue.** Bug reports and feature requests live in [Issues](https://github.com/NoahMenezes/SelectBeam/issues). Check for duplicates first. For bugs, include: extension version, editor + version, OS, AI target + browser (if relevant), steps to reproduce, expected vs actual, and Bridge Status output (`SelectBeam: Show Browser Bridge Status`) when it involves tab reuse. New issues are auto-labeled `needs triage`; maintainers then add `area:*`, `os:*` / `browser:*`, and `priority:*` labels (full set lives in `scripts/setup-labels.sh`, applied via `bun run labels`).
2. **Fork + branch.** Fork the repo, then branch from `main`:
   `git checkout -b feat/short-name` or `fix/short-name`.
3. **Make the change.** Follow the conventions below. Add/adjust docs (`README.md`, `docs/CODE-NOTES.md`, `CHANGELOG.md` under `Unreleased`) when behavior or settings change.
4. **Verify locally.**
   ```bash
   bun run check-types
   bun run compile        # or: bun run package for a prod check
   bun run format:check
   ```
   Then F5-test the flows you touched (terminal send, browser send with and without companion, tab reuse, bridge-off fallback).
5. **Commit + push + PR.** Use clear messages (see below), push to your fork, and open a PR against `main` using the PR template. Link the issue (`Fixes #123`). Keep the PR description focused on _what / why / how tested_.

## 6. Coding conventions

- TypeScript `strict` is on. No new `any` without justification; prefer narrow types in `src/types.ts`.
- `constants.ts`, `platform.ts`, `types.ts` must stay `vscode`-free (pure data / helpers) so they remain importable everywhere.
- Settings: new `selectbeam.*` keys need a default + description in `package.json` **and** a reader in `src/config.ts` **and** a README Settings-table row.
- Browser chat-box support: site redesigns are fixed in the `SELECTORS` table in `browser/content.js` only — don't restructure the paste pipeline for one site.
- Bridge: keep the origin check (`moz-extension://` / `chrome-extension://` / no-origin local only; reject `http(s)` page origins). `GET /status` stays the only origin-exempt endpoint. No auth tokens — the origin check _is_ the auth.
- Formatting: Prettier defaults (see [`.prettierrc.json`](.prettierrc.json)) + [`.editorconfig`](.editorconfig). Run `bun run format` before pushing.
- Line endings LF, UTF-8, final newline (enforced by `.editorconfig` / `.gitattributes`).

## 7. Commit messages & changelog

- Imperative, short subject (`Add Grok URL override`, `Fix Brave shadow-DOM fill`), body explaining _why_ when non-obvious.
- Reference issues (`Fixes #12`) in the PR, not necessarily every commit.
- `CHANGELOG.md`: add entries under an `## [Unreleased]` section at the top. Maintainers fold it into versioned sections at release.

## 8. Tests & CI

- There is no unit-test suite yet (V1 placeholder `bun run test`). Until one lands, **manual verification is the test**: state exactly what you ran in the PR (`check-types`, `compile`/`package`, F5 flows, companion browsers tried).
- CI ([`.github/workflows/ci.yml`](.github/workflows/ci.yml)) runs on every PR/push to `main`: `bun install`, `check-types`, `compile`, `format:check`. A PR must be green before review.
- If you add automated tests, wire them into `package.json` (`test` script) and `ci.yml` in the same PR.

## 9. Releases (maintainers)

Contributors don't publish. Tagging `v*` triggers [`.github/workflows/publish.yml`](.github/workflows/publish.yml): type-check → prod build → `vsce publish` (Marketplace) → `ovsx publish` (Open VSX) → attach `.vsix` to the GitHub Release. Version bumps touch `package.json` + `CHANGELOG.md` together.

## 10. Getting help

- Questions: open a [Discussion or Issue](https://github.com/NoahMenezes/SelectBeam/issues) — include what you tried and what the docs didn't answer.
- In-product troubleshooting: `README.md` → "If something goes wrong", plus `SelectBeam: Show Browser Bridge Status`.

Thanks for contributing — small, well-tested PRs are the fastest way to land. 🙌
