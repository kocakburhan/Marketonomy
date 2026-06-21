# Fundraising Readiness Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an investor-document production system to the Marketing Agent.

**Architecture:** Add one specialist playbook, one fundraising pipeline, and four focused local skills. Keep the main agent responsible for workspace checks, marketer decisions, output filing, final approval, and evidence/data integrity.

**Tech Stack:** Markdown playbooks, Codex local skill frontmatter, PowerShell release manifest and compatibility checks.

---

### Task 1: Add Fundraising Playbooks

**Files:**
- Create: `marketing-agent/agents/investor-readiness-advisor.md`
- Create: `marketing-agent/pipelines/fundraising-readiness.md`
- Modify: `marketing-agent/agents/orchestrator.md`

- [ ] Add an investor-readiness specialist that defines the document set, decision gates, data requirements, legal boundary, and workspace contract.
- [ ] Add a fundraising pipeline that sequences context, traction, financials, documents, data room, legal drafts, review, final approval, and weekly planning.
- [ ] Route fundraising, pitch deck, data room, investor update, board deck, financial model, cap table, term sheet, and SHA requests through the new specialist and pipeline.

### Task 2: Add Local Skills

**Files:**
- Create: `marketing-agent/skills/investor-documents/SKILL.md`
- Create: `marketing-agent/skills/investor-documents/agents/openai.yaml`
- Create: `marketing-agent/skills/fundraising-financials/SKILL.md`
- Create: `marketing-agent/skills/fundraising-financials/agents/openai.yaml`
- Create: `marketing-agent/skills/investor-data-room/SKILL.md`
- Create: `marketing-agent/skills/investor-data-room/agents/openai.yaml`
- Create: `marketing-agent/skills/investment-legal-drafts/SKILL.md`
- Create: `marketing-agent/skills/investment-legal-drafts/agents/openai.yaml`

- [ ] Make each skill self-contained with valid `name` and `description` frontmatter.
- [ ] Include Turkish user-facing output guidance, evidence ledger, raw-vs-normalized data handling, assumptions, and approval gates.
- [ ] Add valid Codex UI metadata for each skill.

### Task 3: Update Contracts And Validation

**Files:**
- Modify: `mvp/mvp.md`
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/SKILLS.md`
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [ ] Add investor and financial report folders to the project workspace contract.
- [ ] Add fundraising to the agent output routing and LLM-wiki relationship memory scope.
- [ ] Increase the expected local skill count from 41 to 45.
- [ ] Add compatibility assertions for the fundraising specialist, pipeline, and skills.

### Task 4: Verify Release

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [ ] Run `.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot (Resolve-Path .\marketing-agent).Path`.
- [ ] Run `marketing-agent/scripts/test_mvp_compatibility.ps1`.
- [ ] Run `marketing-agent/scripts/healthcheck.ps1`.
- [ ] Run `scripts/test_marketing_agent_install_update.ps1`.
