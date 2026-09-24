# Pull Request

## What / why

<!-- One or two sentences: what changes, and why. Link the issue: Fixes #123 -->

## How

<!-- Key implementation notes. Call out any bridge / origin / auto-submit surface you touched. -->

## How tested

<!-- Be specific — this is the test plan until we have a suite. Check all that apply. -->

- [ ] `bun run check-types` passes
- [ ] `bun run compile` (or `bun run package`) passes
- [ ] `bun run format:check` passes
- [ ] F5 Extension Host manual test: <!-- flows tried, e.g. terminal send, browser copy+open, companion tab reuse -->
- [ ] Companion browsers tried: <!-- e.g. N/A, Firefox, Chrome, Edge, Brave -->

## Checklist

- [ ] One change per PR, small focused diff
- [ ] No inline comments added to `src/` (explanations go in `docs/CODE-NOTES.md`)
- [ ] New `selectbeam.*` settings documented in `package.json` + `src/config.ts` + `README.md`
- [ ] `CHANGELOG.md` entry added under `Unreleased`
- [ ] No auto-submit, no telemetry, no remote servers introduced
- [ ] I read `CONTRIBUTING.md` and follow the Code of Conduct
