# 소마 코드배틀 (Soma Code Battle)

<!--
  작성 원칙:
  1) 매 세션 로드된다 → "항상 참인 것"만 넣는다.
  2) 짧게 (~200줄 이하). 길면 클로드가 무시한다.
  3) 코드만 봐서 알 수 있는 건 적지 않는다.
  4) 각 줄에 물어봐라: "이걸 지우면 클로드가 실수할까?" 아니면 삭제.
  상세는 @ 포인터로 링크하고 인라인하지 않는다.
-->

## What — 이 프로젝트가 무엇인가
- 한 줄: 소마고 교내 AI 코딩 배틀 — 2일마다 AI가 문제 자동 출제, 학생이 익명/실명으로 풀면 AI가 피드백·점수, 다양한 랭킹.
- 스택(선언): React + Vite + TypeScript + Tailwind (전역 상태 Context API) / Spring + MySQL + JPA/Hibernate + Flyway / OpenAI API / Judge0 / 배포 Vercel(프론트)+Railway(백).
- 진입점: 백 Spring Boot 메인(`@SpringBootApplication`) · 프론트 Vite(`src/main`).

> 신규 구축: 코드는 이 사양 기준으로 새로 작성한다(기존 구현 없음).

## Why — 코드만 봐선 모를 결정
- 랭킹은 별도 집계 테이블 없이 `submissions.submitted_at`로 직접 집계한다. (user, problem)당 **마지막 제출만** 점수 반영.
- 점수는 항상 소수점 2자리로 유지한다.
- API 응답은 항상 `{ data, error, status }` 형태로 통일한다.
- OpenAI/Judge0 키가 없으면 **데모 모드**로 전체 플로우가 동작한다(외부 호출 없이).
- 월간 랭킹은 4번째 주 일요일에만 공개(그 외 잠금+D-day). 일요일은 출제 없이 열람만.

## How — 빌드 / 실행 / 검증
### 명령어 (클로드가 추측 못 하는 것)
- 프론트(React+Vite+TS): `npm install` · `npm run dev`(:5173) · `npm run build` · `npm run preview`
- 백(Spring): `./gradlew bootRun`(:8080) · 마이그레이션 Flyway(`./gradlew flywayMigrate`)
- lint/test 명령은 프로젝트 셋업 시 확정해 여기 갱신(현재 미정).

### 워크플로
- 큰 변경은 Plan Mode로 승인 후 진행. 한 번에 하나의 task만.
- 코드 변경 후 변경 범위의 검증 게이트를 통과시킨다 → @docs/testing.md. 못 돌렸으면 "안 돌림" 명시.
- 이력/되돌리기는 git 커밋 + `/rewind`.

## 코드 스타일 (언어 기본값과 다른 것만)
- 상세 규칙은 경로스코프로 자동 로드 → `@.claude/rules/`.
- 요약: Java/Spring(클래스 PascalCase·메서드 camelCase, 생성자 주입) / React camelCase·컴포넌트 PascalCase / 점수 2자리.

## 경계 (Boundaries) — 건드리지 말 것
- **IMPORTANT**: API 키/시크릿 절대 하드코딩 금지. `.env`만 사용. 노출 금지(@.claude/rules/secrets.md).
- **YOU MUST**: 외부 API(OpenAI·Judge0)는 키 없을 때 데모 모드로 동작시킨다(실호출 강제 금지).
- 요청/현 task 범위 밖 구현·추상화·문서 확장 금지(스코프 크리프).
- 작성한 코드는 현재 task 범위 밖에서 임의 리팩터하지 않는다.

## 포인터 (Pointers) — 상세는 링크로
- 도메인 상세(스케줄/점수/랭킹/주간주제): @docs/domain.md
- 아키텍처 상세: @docs/architecture.md
- 검증 게이트: @docs/testing.md
- 언어 규칙: @.claude/rules/
- 환경변수 (키 이름만 — 값은 `.env`):
  - 시크릿: `DATABASE_URL`, `OPENAI_API_KEY`, `JUDGE0_API_KEY`, `SECRET_KEY`
  - 모델 기본값(여기 1곳만 기록): `OPENAI_MODEL_GENERATION`=gpt-5.4-mini · `OPENAI_MODEL_INSTANT_FEEDBACK`/`OPENAI_MODEL_ROUND_FEEDBACK`=gpt-5.4-nano · `OPENAI_MODEL_WEEKLY_FEEDBACK`/`OPENAI_MODEL_MONTHLY_FEEDBACK`=gpt-5.4-mini
  - 기타: `ADMIN_EMAIL` 외 `.env.example` 참조

## 사람 확인 (런타임/통합 — 클로드가 검증 불가)
- AI 문제 생성 실패 시 관리자 알림 발송 확인.
- 마감 10분 전 알림(scheduler) 동작 확인.
- 외부 API 키는 사람이 `.env`에 제공.
