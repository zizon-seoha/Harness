---
paths:
  - "**/*.py"
---

# Python 규칙

언어 레벨 금지패턴·스타일. 명령어·폴더·버전은 여기 적지 않는다 → `docs/STACK.md`.

- bare `except:` 금지. 잡을 예외를 구체적으로 명시한다.
- 함수·메서드에 타입힌트를 단다.
- 디버깅용 `print()` 잔재를 커밋하지 않는다. 로깅은 `logging`을 쓴다.
- 매직넘버 금지. 명명 상수로 둔다.
- `async` 함수 안에서 blocking 호출(동기 I/O, `time.sleep`, 동기 DB/HTTP) 금지. async 대안을 쓰거나 executor로 분리한다.
- 시크릿을 코드·로그에 넣지 않는다 (`.claude/rules/secrets.md`).
