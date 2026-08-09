#!/usr/bin/env sh
set -eu

find . -type f -not -path './.git/*' | while IFS= read -r repository_file; do
  relative_file=${repository_file#./}
  case "$relative_file" in
    *.tfstate|*.tfstate.*|*.tfplan|*.pem|*.key|.env|.env.*)
      echo "Prohibited infrastructure file exists in the repository: $relative_file" >&2
      exit 1
      ;;
  esac
done

echo "Infrastructure repository policy check passed."
