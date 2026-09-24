# Reminders — manual steps to do later

- [ ] **Apply GitHub labels** (`scripts/setup-labels.sh`, 29 labels):
  ```bash
  gh auth login
  bun run labels
  ```
- [ ] **Branch protection on `main`** (GitHub → Settings → Branches): require CI (`build`) green + 1 review before merge.
