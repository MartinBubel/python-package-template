## Developer Guide

### Project Structure
This project ...
`uv` can be used to setup the virtual environment and manage dependencies and run scripts:
```bash
uv sync
uv run <script.py>
```

### Dev Scripts
This repository features the following development scripts:
* `scripts/cycle-precommit.sh`: Updates and re-installs the pre-commit hooks, which replaces three commands by one if you changed it.

### Developer Tooling (Pre-Commit & Maintenance)
This repository ships a lean pre-commit configuration (Ruff lint + format, a few hygiene hooks).

Initial one-time setup after cloning:
```bash
uv sync --group dev      # ensure ruff + pre-commit are installed
uv run pre-commit install
```

Typical usage cycle:
1. Edit code
2. `git add <files>`
3. `git commit` → hooks auto-run on staged files (fast)

Run hooks against the entire repository (e.g. after bulk refactors):
```bash
uv run pre-commit run --all-files
```

Update hook versions periodically (creates a commit with bumped revisions):
```bash
uv run pre-commit autoupdate
```

Temporarily skip hooks (rare; e.g., emergency hotfix) using the standard git bypass flag:
```bash
git commit -m "hotfix: …" --no-verify
```

CI Enforcement (GitLab): The `.gitlab-ci.yml` includes a `lint:ruff` job mirroring local hooks. Keeping local hooks green ensures CI passes without surprises.

Optional enhancements you can enable later:
* Add a smoke `pytest` hook (uncomment sample in `.pre-commit-config.yaml`).
* Add mypy or additional structured file checks (`check-json`, `check-toml`, `check-yaml`).
* Cache Ruff explicitly if lint runtime ever becomes noticeable.

Housekeeping tips:
* After large dependency or configuration changes, run `uv run pre-commit run --all-files` once.
* If hooks stop firing, re-run `uv run pre-commit install` (e.g., after cloning a fresh copy).
* Avoid committing auto-generated artifacts (figures, large data) unless versioned intentionally.

Environment variables in CI:
* `PIP_DISABLE_PIP_VERSION_CHECK=1` suppresses upgrade noise.
* `PYTHONDONTWRITEBYTECODE=1` avoids writing `.pyc` files (keeps image ephemeral & clean).

These are convenience tweaks; feel free to adjust if you later add heavier test stages or caching.

### Linting & Formatting (Ruff + Pre-Commit)
This project uses [Ruff](https://docs.astral.sh/ruff/) for both linting and formatting.

Install dev tools (if not already):
```bash
uv sync --group dev
```

Run Ruff manually:
```bash
uv run ruff check --fix .
uv run ruff format .
```

Install pre-commit hooks:
```bash
uv run pre-commit install
```
Hooks run automatically on staged files. To run on all files:
```bash
uv run pre-commit run --all-files
```
