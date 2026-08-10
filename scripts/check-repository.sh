#!/usr/bin/env sh
set -eu

is_os_junk() {
  case "$1" in
    .DS_Store|*/.DS_Store|Thumbs.db|*/Thumbs.db|Desktop.ini|*/Desktop.ini)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_prohibited_artifact() {
  case "$1" in
    *.tfstate|*.tfstate.*|*.tfplan|tfplan|*/tfplan|crash.log|*/crash.log|crash.*.log|*/crash.*.log|\
    *.pem|*.key|.env|*/.env|.env.*|*/.env.*|*.tfvars|*.tfvars.json|.terraformrc|*/.terraformrc|terraform.rc|*/terraform.rc)
      case "$1" in
        .env.example|*/.env.example|*.tfvars.example|*.tfvars.json.example)
          return 1
          ;;
      esac
      return 0
      ;;
    .terraform/*|*/.terraform/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo 'Repository policy check must run inside a Git work tree.' >&2
  exit 1
fi

git ls-files | while IFS= read -r tracked_file; do
  if [ ! -e "$tracked_file" ] && [ ! -L "$tracked_file" ]; then
    continue
  fi

  if is_os_junk "$tracked_file"; then
    echo "Prohibited operating-system metadata is tracked: $tracked_file" >&2
    exit 1
  fi

  if is_prohibited_artifact "$tracked_file"; then
    echo "Prohibited infrastructure artifact is tracked: $tracked_file" >&2
    exit 1
  fi
done

find . \
  -path './.git' -prune -o \
  -path './.terraform' -prune -o \
  \( -type f -o -type l \) -print | while IFS= read -r repository_file; do
  relative_file=${repository_file#./}
  case "$relative_file" in
    .gitignore)
      continue
      ;;
  esac

  if is_prohibited_artifact "$relative_file"; then
    echo "Prohibited infrastructure file exists in the repository: $relative_file" >&2
    exit 1
  fi
done

echo "Infrastructure repository policy check passed."
