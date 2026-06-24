---
paths:
  - "**/*.{ts,tsx,jsx,js}"
---

# 프론트 규칙

언어 레벨 금지패턴·스타일. 명령어·폴더는 여기 적지 않는다 → `CLAUDE.md` / `docs/`.

- 네이밍 camelCase. 컴포넌트는 PascalCase.
- 디버깅용 `console.log` 잔재를 커밋하지 않는다.
- 타입을 명시한다. 암묵 `any`를 지양하고, 컴포넌트 props에 타입을 단다.
- 매직넘버·매직스트링 금지. 상수로 둔다.
- 불필요한 리렌더를 유발하는 인라인 객체/함수 prop을 주의한다 (필요 시 `useMemo`/`useCallback`).
- 점수 등 숫자 표시는 소수점 2자리 (`toFixed(2)`).
- 시크릿을 클라이언트 코드·번들에 넣지 않는다 (`.claude/rules/secrets.md`).
