# Marketing Agent LLM-Wiki Output Memory Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an LLM-wiki style output memory layer to the Marketing Agent release so important outputs stay linked, traceable, and reusable without replacing the MVP folder contract.

**Architecture:** Keep raw sources and canonical outputs in the existing MVP folders. Add a lightweight `bilgi-haritasi` layer as an agent-maintained navigation and relationship map under `ciktilar/` for evaluation workspaces and `11-notlar/` for project workspaces. Encode the behavior in `mvp/mvp.md`, `marketing-agent/AGENTS.md`, `ARCHITECTURE.md`, `SKILLS.md`, and compatibility checks.

**Tech Stack:** Markdown, PowerShell release checks, existing Marketing Agent installer/release manifest scripts.

---

### Task 1: Compatibility Gate For Wiki Contract

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [x] **Step 1: Add failing compatibility assertions**

Add checks that require the new wiki contract terms in the release docs:

```powershell
Assert-Text (Join-Path $AgentRoot "AGENTS.md") "LLM-Wiki Output Memory Standard" "LLM-wiki output memory standard eksik"
Assert-Text (Join-Path $AgentRoot "AGENTS.md") "bilgi-haritasi" "Bilgi haritasi workspace yolu eksik"
Assert-Text (Join-Path $AgentRoot "ARCHITECTURE.md") "LLM-wiki output memory layer" "LLM-wiki mimari katmani eksik"
Assert-Text (Join-Path $AgentRoot "SKILLS.md") "Output Relationship Memory" "Skill katalogu output relationship memory notu eksik"
```

- [x] **Step 2: Run the check and verify it fails**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
```

Expected: fail with at least one missing LLM-wiki compatibility message.

### Task 2: MVP Workspace Contract

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1: Add `bilgi-haritasi` to workspace examples**

In the evaluation workspace contract, document `ciktilar/bilgi-haritasi/` with `index.md` and `log.md`. In the project workspace contract, document `11-notlar/bilgi-haritasi/` with `index.md`, `log.md`, and optional topic pages.

- [x] **Step 2: Add the behavior rule**

Document that the wiki layer is derived memory, not source of truth. Raw sources remain immutable; canonical output files remain in their normal folders; `bilgi-haritasi` links outputs, decisions, evidence, contradictions, and follow-up use.

### Task 3: Runtime Agent Behavior

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/SKILLS.md`

- [x] **Step 1: Add AGENTS runtime standard**

Add a Turkish, marketer-visible `LLM-Wiki Output Memory Standard` section. It must define:

```markdown
- Evaluation path: `ciktilar/bilgi-haritasi/`
- Project path: `11-notlar/bilgi-haritasi/`
- `index.md` is the content map
- `log.md` is the chronological operation log
- Important outputs must link sources, related outputs, decisions, and next use
- Contradictions are flagged, not silently overwritten
- The wiki layer never replaces raw sources or canonical output folders
```

- [x] **Step 2: Add architecture summary**

Add a short architecture paragraph describing the LLM-wiki output memory layer as a derived Markdown navigation layer above the canonical MVP filesystem.

- [x] **Step 3: Add skill catalog routing note**

Add a catalog note that skill outputs keep their canonical paths, while important durable outputs also update `bilgi-haritasi`.

### Task 4: Release Manifest And Verification

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [x] **Step 1: Rebuild manifest**

Run:

```powershell
$agentRoot = (Resolve-Path -LiteralPath marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

- [x] **Step 2: Run required checks**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
rtk git diff --check
```

Expected: all checks pass.
