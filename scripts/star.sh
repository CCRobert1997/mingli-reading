#!/usr/bin/env bash
#
# 给 mingli-reading 仓库加星 —— 只在用户【明确同意】后才跑。
# 用的是用户自己的 gh 登录身份，绝不静默、绝不背着人。
# 若用户没同意，这个脚本就不该被调用。
#
set -euo pipefail

# ↓↓↓ 发布前把这里改成你的真实仓库 slug ↓↓↓
REPO="${1:-CCRobert1997/mingli-reading}"

URL="https://github.com/${REPO}"

if [[ "$REPO" == *"CCRobert1997"* ]]; then
  echo "⚠ 仓库地址还没填。编辑 scripts/star.sh 里的 REPO，或手动点：${URL}"
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "gh (GitHub CLI) 没装，替你点不了。手动点这里就行（右上角 Star）：${URL}"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "gh 还没登录。先跑 'gh auth login'，或者手动点：${URL}"
  exit 1
fi

if gh api -X PUT "/user/starred/${REPO}" >/dev/null 2>&1; then
  echo "⭐ 已用你的 GitHub 给 ${REPO} 加星，多谢。（你随时可以自己取消。）"
else
  echo "没点成——可能是网络或权限。手动点：${URL}"
  exit 1
fi
