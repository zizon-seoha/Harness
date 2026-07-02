---
paths:
  - "**/*.java"
---

# Java / Spring 규칙

언어 레벨 금지패턴·스타일. 명령어·폴더·버전은 여기 적지 않는다 → `CLAUDE.md` / `docs/`.

- 클래스 PascalCase, 메서드·변수 camelCase, 상수 UPPER_SNAKE_CASE.
- 의존성은 생성자 주입을 쓴다(필드 `@Autowired` 지양).
- 빈 `catch` 금지. 잡을 예외를 구체적으로 명시하고 삼키지 않는다.
- 디버깅용 `System.out.println` 잔재 금지. 로깅은 SLF4J(`log.info` 등).
- 매직넘버·매직스트링 금지. 명명 상수로 둔다.
- 엔티티/DTO를 혼용하지 않는다(영속 엔티티를 API 응답으로 직접 노출 금지).
- 금액/정밀 수치는 `float`/`double` 대신 `BigDecimal`을 쓴다.
- 시크릿을 코드·로그에 넣지 않는다 (`.claude/rules/secrets.md`).
