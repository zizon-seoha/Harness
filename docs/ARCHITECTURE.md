# 아키텍처 상세 — 소마 코드배틀

CLAUDE.md에서 `@docs/architecture.md`로 참조.

## 디렉토리 (모노레포: 루트 아래 frontend/ + backend/)
- 프론트(React+Vite+TS): `frontend/src/` — `components/`(공통) · `pages/` · `api/`(호출) · `store/`(Context 전역상태) · `utils/`
- 백(Spring): `backend/src/main/java/<pkg>/` 아래 `controller/`(API) · `service/`(비즈니스) · `repository/`(JPA) · `entity/`(DB) · `dto/` · `config/`(설정/스케줄러). 마이그레이션 `backend/src/main/resources/db/migration/`(Flyway).

## 중요 컴포넌트 (Spring)
- 스케줄러 컴포넌트(`@Scheduled`) — 자동 출제/피드백.
- 회차/요일/주제 판정 유틸 — isSunday/isFourthSunday 동등 로직.
- 문제 생성 서비스 — 3단계 필터.
- 피드백 서비스 — 즉시/기간.
- 랭킹 서비스 — 집계.
- 설정 — `application.yml`(환경변수/datasource).
- `frontend/src/utils/dateUtils` — isSunday/isFourthSunday.

## 변경 시 함께 확인 (영향도)
- 출제 스케줄 변경 → 스케줄러 컴포넌트 + 요일/회차 유틸.
- 점수 규칙 변경 → 제출 서비스(점수 계산) + `docs/domain.md`.
- 랭킹 규칙 변경 → 랭킹 서비스 + `docs/domain.md`.
- 환경변수 키 추가 → `application.yml` + `.env`(또는 환경) + CLAUDE.md 포인터.
