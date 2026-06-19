---
description: 새 task 문서를 Tasks/에 생성하고 PLANS.md 보드에 행을 추가한다
argument-hint: <task-이름>
---

`docs/TASK_WRITING.md` 규칙에 따라 새 task 문서를 만든다.

대상 이름: `$ARGUMENTS`

단계:

1. `Tasks/` 의 기존 파일을 확인해 다음 순번 `NN` 을 정한다 (없으면 `01`).
2. `Tasks/NN-$ARGUMENTS.md` 를 아래 골격으로 생성한다. What만 적고 How는 추측하지 않는다.
3. `docs/PLANS.md` 작업 보드에 이 task 행을 `예정` 상태로 추가한다.
4. 생성 결과를 사용자에게 보고한다. (구현은 시작하지 않는다.)

골격:

```markdown
# Task NN - $ARGUMENTS

## 설명
이 task가 달성해야 하는 결과를 한 문단으로 서술한다.

## 구현 항목
<!-- What만 적는다. How(내부 구현 방식)는 추측하지 않는다. -->
- [ ] [필요한 결과 1]
- [ ] [필요한 결과 2]

## 범위 밖
- [ ] [이번 task에 포함하지 않을 것]

## 사전 전제
<!-- 이전 단계 산출물이 필요할 때만 적는다. -->
- [ ] [전제로 사용하는 이전 산출물]

## 완료 조건

### 검증 명령 (docs/STACK.md)
- [ ] 변경 범위에 맞는 검증 명령 통과 (백엔드: ruff/mypy/pytest · 프론트: lint/tsc/vitest/build)

### 사람 확인
<!-- Claude가 검증 못 하는 런타임·통합 항목만. docs/STACK.md 도메인 절 인용. -->
1. [ ] [런타임/통합 확인 항목, 또는 placeholder]

## 참고
- 진행 순서 → docs/WORKFLOW.md
- 작성 규칙 → docs/TASK_WRITING.md
- 코딩 규칙 → docs/STYLEGUIDE.md + .claude/rules/
- 검증 기준 → docs/TESTING.md
```
