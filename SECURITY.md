# Security Policy

## Supported versions

SelectBeam is pre-1.0 and moving fast. Only the latest published version
(`main` branch / newest GitHub Release and marketplace listing) receives
security fixes. Older `.vsix` files attached to past releases are provided
for manual install convenience and are not patched retroactively.

| Version                                       | Supported           |
| --------------------------------------------- | ------------------- |
| latest (`main`, newest Release / marketplace) | ✅                  |
| older releases / older `.vsix`                | ❌ (please upgrade) |

## Reporting a vulnerability

**Do not open a public GitHub issue for security findings.**

Report privately via **GitHub Private Vulnerability Reporting** on this repo
(Security tab → Report a vulnerability). If that is unavailable to you, contact
the maintainer directly through the email listed on the
[maintainer's GitHub profile](https://github.com/NoahMenezes).

Please include:

- What you found and why it matters (what an attacker could actually do).
- Steps to reproduce (extension version, editor, OS, settings involved).
- Which surface it affects: VS Code side (`src/`, bridge on `127.0.0.1:51337`)
  or browser companion (`browser/`).
- Any suggested fix or mitigation, if you have one.

You will get an acknowledgement, and we will keep you updated as a fix is
prepared. Please give us a reasonable window to patch before any public
disclosure. We will credit reporters in the release notes unless you ask
otherwise.

## Security model (what contributors must preserve)

- **Localhost only.** The bridge binds `127.0.0.1` (never `0.0.0.0`). No remote servers, no analytics, no API keys.
- **Origin check is the auth.** The bridge accepts only companion extension
  origins (`moz-extension://`, `chrome-extension://`) or no-origin local
  callers, and rejects any `http(s)` page origin. `GET /status` is the only
  origin-exempt endpoint (version + counts, no code). Do not weaken this, and
  do not add token/auth schemes without discussion.
- **The web page is untrusted.** `browser/content.js` never talks to the bridge
  directly — all networking goes through `browser/background.js`. Keep it that way.
- **Never auto-submit.** Code may be placed into prompts/chat boxes; the user
  always reviews and submits. PRs that press Enter / click send will be rejected.
- **Clipboard-first.** User code is copied before any send so nothing is lost;
  queued bridge payloads stay in memory only (max 20 items, ~500KB each) and
  clear on window close or `Choose Send Target` → Auto.

If your change touches `src/bridge.ts`, `browser/background.js`,
`browser/content.js`, or origin handling, call it out explicitly in the PR
description and describe how you tested the trust boundary.
