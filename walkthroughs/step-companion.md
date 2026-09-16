# Link your browser (once)

No token, no account, nothing to type. Store listings are submitted (links will appear in the Details page after approval):

- **Edge:** Edge Add-ons listing (link to follow), then just keep a chat tab open.
- **Firefox / Zen / LibreWolf:** Firefox AMO listing (link to follow), then just keep a chat tab open.
- **Brave / Chrome / Opera / Vivaldi / Arc:** use the Chrome Web Store listing once published (one listing covers all of them). Until then: copy `browser/manifest.chrome.json` over `browser/manifest.json`, then your browser's extensions page → Developer mode → Load unpacked → `browser/`.

Fallback without stores:
- **Firefox family:** `about:debugging` → Load Temporary Add-on → `browser/manifest.json`.
- **Chromium family:** your browser's extensions page → Developer mode → Load unpacked → `browser/`.

Then open your AI chat in a tab and keep it open. That is the whole setup —
every supported chat tab links itself automatically.
