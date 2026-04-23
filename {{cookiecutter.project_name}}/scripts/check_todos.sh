#!/usr/bin/env sh
set -eu

# Run ripgrep to find TODO/FIXME/XXX occurrences
rg -n --hidden -S \
  -g '!venv/**' -g '!.venv/**' -g '!node_modules/**' \
  -g '!dist/**' -g '!build/**' -g '!coverage/**' \
  -g '!.mypy_cache/**' -g '!.pytest_cache/**' \
  -g '!todo_hits.txt' -g '!dev/check_todos.sh' \
  -e '\b(TODO|FIXME|XXX)\b' . | tee todo_hits.txt

# Fail if any hits were found
if [ -s todo_hits.txt ]; then
  echo "Found TODO/FIXME/XXX:"
  cat todo_hits.txt
  exit 1
else
  echo "No TODOs found."
fi
