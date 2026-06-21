# International Market Expansion Agent Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an orchestrator-routed specialist and pipeline that guides marketers through country-by-country international market expansion.

**Architecture:** Keep the existing single main Codex agent model. Add one specialist playbook under `marketing-agent/agents/`, one pipeline under `marketing-agent/pipelines/`, and route requests from `agents/orchestrator.md`; update release documentation and compatibility checks so the new behavior is packaged and verified.

**Tech Stack:** Markdown playbooks, PowerShell compatibility tests, release manifest generation.

---

### Task 1: Add Compatibility Coverage

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [ ] Add assertions for `agents/market-expansion-advisor.md`, `pipelines/international-market-expansion.md`, orchestrator routing text, and required evidence sections.
- [ ] Run `powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent`.
- [ ] Confirm the test fails because the new files and routing text are missing.

### Task 2: Add Specialist And Pipeline

**Files:**
- Create: `marketing-agent/agents/market-expansion-advisor.md`
- Create: `marketing-agent/pipelines/international-market-expansion.md`

- [ ] Write the specialist playbook with country expansion intake, beachhead scoring, localization, channel, compliance, technical readiness, and 90-day test guidance.
- [ ] Write the pipeline with evidence collection, candidate-market scoring, technical globalization checks, demand test design, and output contracts for evaluation and project workspaces.

### Task 3: Wire Routing And Documentation

**Files:**
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/SKILLS.md`
- Modify: `marketing-agent/skills/list.md`

- [ ] Add the specialist to the specialist table.
- [ ] Add routing for country expansion, global GTM, beachhead market selection, localization, and demand testing.
- [ ] Document that the specialist uses existing local skills and Codex web/Browser/Chrome capabilities when visible.

### Task 4: Refresh Release Manifest And Verify

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [ ] Run `.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot (Resolve-Path -LiteralPath marketing-agent).Path`.
- [ ] Run compatibility, healthcheck, and install/update regression scripts.
- [ ] Inspect `git diff --check` and `git status --short`.
