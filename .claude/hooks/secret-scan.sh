#!/usr/bin/env bash
# 시크릿 스캔 훅 — PreToolUse(Write|Edit|MultiEdit).
# 파일에 쓰려는 내용(stdin tool_input JSON)에 "실제 키 값"이 있으면 차단(exit 2).
# 2단계: (1) 알려진 토큰 접두사  (2) 시크릿 필드에 16자+ 실값 할당.
# env 참조(${..}, process.env 등)·플레이스홀더는 오탐 제외.
#
# exit 0 = 통과, exit 2 = 차단(이유 stderr).

# JSON 이스케이프된 개행을 실제 개행으로 펴서 줄 단위 매칭이 되게 한다.
content="$(cat | sed 's/\\n/\n/g')"

# (1) 알려진 키/토큰 접두사 — 보이면 즉시 차단
known='sk-[A-Za-z0-9]{16,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|gho_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|glpat-[A-Za-z0-9_-]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[A-Za-z0-9_-]{30,}|-----BEGIN[ A-Z]*PRIVATE KEY-----'
if printf '%s' "$content" | grep -Eq "$known"; then
  echo "차단: 알려진 형식의 시크릿 키가 파일 내용에 있음. .env 사용." >&2
  exit 2
fi

# (2) 시크릿 필드에 16자+ 실값 할당 (단 env참조/플레이스홀더 제외)
assign='(api[_-]?key|secret|token|passwd|password|access[_-]?key)[^A-Za-z0-9]{0,3}[:=][^A-Za-z0-9]{0,3}["'"'"']?[A-Za-z0-9/+_-]{16,}'
exclude='\$\{|process\.env|import\.meta\.env|os\.environ|System\.getenv|getenv|<[^>]+>|change[-_]?me|your[-_]|xxxx|placeholder|example|[:=]["'"'"' ]*$'
if printf '%s' "$content" | grep -Eni "$assign" | grep -Eiv "$exclude" | grep -q .; then
  echo "차단: 시크릿 필드에 하드코딩된 값이 있음. .env/환경변수로 옮길 것." >&2
  exit 2
fi

exit 0
