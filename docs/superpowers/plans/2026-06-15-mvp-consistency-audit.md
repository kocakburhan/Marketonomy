# PersonalAutonomy MVP Consistency Audit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `mvp/mvp.md` a single internally consistent and implementation-ready MVP specification aligned with the approved audit design.

**Architecture:** Preserve the existing 13-section document, but align every section to one shared role, workspace, identity, Drive ownership, workflow, notification, and agent update model. Apply changes from foundational folder definitions toward dependent web app and daily flows, then rewrite the final decision and run deterministic text/Markdown checks.

**Tech Stack:** Markdown, PowerShell-oriented filesystem specification, Google Drive, Codex App, PWA/Web Push, Git text validation

---

### Task 1: Align the System Introduction and Drive/User Folder Model

**Files:**
- Modify: `mvp/mvp.md:1-151`

- [ ] **Step 1: Replace the top-level user assumption**

State explicitly that only marketers receive personal Drive workspaces, while coder-only users receive access solely to projects they join. Keep invited-user registration and the PWA as first-class system components.

- [ ] **Step 2: Replace the shared folder tree**

Use this authoritative shape:

```text
PersonalAutonomy/
  shared/
    agent-releases/
    tools/
      create-evaluation.ps1
      create-project.ps1
      update-all-agents.ps1
    templates/
    logs/
  marketers/
    <kullanici>/
      idea-workspace/
      projects/
```

Remove `update-project-agent.ps1` and `shared/idea-evaluations/`. Define `shared/logs/` as Burhan Kocak-only and state that coder-only users have no personal folder under `marketers/`.

- [ ] **Step 3: Define the two marketer workspace roots**

Explain that `idea-workspace/` is for pre-project evaluations and `projects/` is for accepted projects. Both contain isolated Codex roots; neither is a generic cross-workspace execution root.

- [ ] **Step 4: Verify forbidden legacy structure is absent from the edited range**

Run:

```powershell
rg -n "update-project-agent|shared/idea-evaluations|coder.*kendi.*klasor" mvp/mvp.md
```

Expected: no legacy folder/tool match that asserts the removed model.

### Task 2: Define the Evaluation Workspace and Project Identity Model

**Files:**
- Modify: `mvp/mvp.md:153-674`

- [ ] **Step 1: Add the evaluation workspace structure**

Before the project workspace description, define:

```text
marketers/<kullanici>/idea-workspace/<fikir-id>-<kisa-baslik>/
  AGENTS.md
  DEGERLENDIRME.md
  DURUM.md
  RAPOR.md
  kaynaklar/
  ciktilar/
  .pa/agent/
  .pa/evaluation/state.json
```

Describe the purpose and ownership of each file and make the workspace an independent Codex root/thread.

- [ ] **Step 2: Add immutable web app identifiers to project files**

Require `project_id` and `idea_id` in `PROJE.md` and `.pa/project/state.json`. State that these values are created by the web app and cannot be changed by project overrides or normal users.

- [ ] **Step 3: Expand Codex root rules to both workspace types**

Allow only these real work roots:

```text
marketers/<kullanici>/idea-workspace/<fikir-id>-<kisa-baslik>
marketers/<host>/projects/<proje-klasoru>
```

Keep `idea-workspace/` and `projects/` parent roots limited to listing and script-backed creation.

- [ ] **Step 4: Specify `create-evaluation.ps1`**

Require `idea_id`, short title, and marketer identity; validate the safe folder name; prevent duplicate workspace creation for the same marketer/idea; stage creation in a temporary folder; copy the current agent package; write templates and state; verify the complete structure; atomically publish; and produce friendly errors.

- [ ] **Step 5: Revise `create-project.ps1` parameters and duplicate detection**

Require immutable `project_id`, `idea_id`, project name, and Drive host marketer identity. State that only the recorded Drive host marketer may initiate creation. Before name checks, scan valid project state files for the same `project_id`; if found, do not create a duplicate and direct the user to the existing path.

- [ ] **Step 6: Preserve the empty current-week template rule**

Keep current ISO week generation, no automatic starter tasks, and onboarding guidance. Clarify that activation triggers collaborative completion of the remaining days in the first week.

### Task 3: Align Agent Distribution, Updates, and Project Customization

**Files:**
- Modify: `mvp/mvp.md:676-1038`

- [ ] **Step 1: Generalize agent distribution**

State that both evaluation and project workspaces receive independent `.pa/agent` copies from the same validated release.

- [ ] **Step 2: Generalize workspace discovery in `update-all-agents.ps1`**

Require scanning both:

```text
marketers/*/idea-workspace/*
marketers/*/projects/*
```

Define separate validity markers for evaluation workspaces and project workspaces. Keep invalid folders untouched.

- [ ] **Step 3: Generalize backup and result reporting**

Use a user-level `.pa-update-work/` outside both workspace roots. Report updated/skipped/rolled-back counts by workspace type while retaining the existing release validation, hash, retry, atomic replacement, rollback, and critical-stop behavior.

- [ ] **Step 4: Clarify customization scope**

Keep `.pa/project/overrides.md` project-only. State that evaluation workspaces use their evaluation template/state and cannot modify platform workflow, immutable IDs, role rules, publication visibility, or agent update protections.

### Task 4: Correct Web App Registration, Evaluation, and State Machine Rules

**Files:**
- Modify: `mvp/mvp.md:1040-1284`

- [ ] **Step 1: Replace open registration with invitations**

Require a Burhan Kocak-created invitation for an exact e-mail address. The invitation defines allowed roles. The user selects only among those roles at first login; later role changes are admin-only.

- [ ] **Step 2: Add role removal invariants**

Prevent removing the Marketer role while the user has an active positive evaluation or Drive host responsibility. Require evaluation change and/or explicit host transfer first.

- [ ] **Step 3: Correct administrator evaluation behavior**

Keep administrator evaluations readable and equal as opinion records, but state that an administrator `Denenmeye Deger` result never creates a Project Pool record or marketer membership. Only a marketer result can perform the project-creation transaction.

- [ ] **Step 4: Remove `Marketer Bekliyor`**

Remove the status and all transitions involving it. A newly created project begins in `Drive Kurulumu Bekliyor` because its creating marketer is already a member and Drive host.

- [ ] **Step 5: Define frozen `Yeniden Degerlendiriliyor` behavior**

When no positive marketer remains, remove normal editing rights, prohibit new coder membership and forward status transitions, preserve read visibility and history, and show that Drive permissions are not automatically changed. A new positive marketer rejoins the existing project and restores the previous valid state if Drive setup remains valid, otherwise `Drive Kurulumu Bekliyor`.

- [ ] **Step 6: Make actor-inclusive notifications explicit**

Delete the self-notification exception. State that every listed event is sent to all active users, including the actor, through Web Push and the in-app notification center.

### Task 5: Correct Drive Report Publication and Host Transfer Rules

**Files:**
- Modify: `mvp/mvp.md:1286-1444`

- [ ] **Step 1: Remove the shared evaluation report directory**

Replace it with marketer-owned evaluation files. Optional published reports remain in the marketer's `idea-workspace` and are shared manually as Viewer with system users; the web app stores the validated Drive link.

- [ ] **Step 2: Add report publication limitations**

State that the web app cannot verify Viewer permissions without Drive API/OAuth. The publishing marketer confirms access, and inaccessible links are corrected through workflow warnings rather than automatic permission changes.

- [ ] **Step 3: Separate Drive host from evaluation membership**

The first positive marketer becomes Drive host. Changing that evaluation to negative does not remove host responsibility. Only the current host or Burhan Kocak can transfer it, and the target must be an active project marketer.

- [ ] **Step 4: Correct host departure behavior**

Require explicit transfer before removing the host's Marketer role. If the project is frozen because no positive marketer remains, the old host and existing Drive permissions may remain; the web app must not claim the folder is read-only.

### Task 6: Rewrite Daily Flows and the Final Decision

**Files:**
- Modify: `mvp/mvp.md:1446-end`

- [ ] **Step 1: Rewrite first login**

Start from an administrator invitation, allowed-role selection, PWA installation, Web Push permission, and access to visible workflow data. Explicitly note that coder-only users receive no personal Drive workspace.

- [ ] **Step 2: Add evaluation workspace creation before evaluation**

The marketer opens their `idea-workspace` parent, asks Codex to start the specified idea evaluation, and Codex runs `create-evaluation.ps1`. The marketer then opens the generated folder as a new Codex root/thread, performs the analysis, and publishes the result to the web app.

- [ ] **Step 3: Rewrite positive project creation**

Use the web app-created `project_id` and `idea_id`; record the first positive marketer as Drive host; run `create-project.ps1` only from that marketer's `projects` parent; complete the activation checklist; then open the project root/thread.

- [ ] **Step 4: Add evaluation reversal and freeze flow**

Describe automatic marketer removal, host responsibility retention until explicit transfer, frozen web app behavior when no positive marketer remains, and reactivation by a later positive marketer.

- [ ] **Step 5: Correct weekly planning cadence**

On initial activation, complete the current week's empty template for the remaining days. Starting with the next week, prepare plans every Monday. Preserve explicit user completion confirmation.

- [ ] **Step 6: Rewrite `Nihai MVP Karari`**

Summarize the invitation model, marketer-only personal Drive areas, evaluation/project workspace separation, immutable IDs, marketer-only project promotion, Drive host responsibility, coder project-only access, frozen-project behavior, actor-inclusive notifications, dual-workspace agent updates, and MVP exclusions without contradicting Sections 1-12.

### Task 7: Run Deterministic Consistency Checks

**Files:**
- Verify: `mvp/mvp.md`

- [ ] **Step 1: Check section sequence and Markdown fences**

Run a PowerShell check confirming headings `1..13`, one final decision heading, and an even code-fence count.

- [ ] **Step 2: Check removed concepts**

Run:

```powershell
rg -n "Marketer Bekliyor|shared/idea-evaluations|update-project-agent|Kullanici kendi yaptigi islem icin push almaz" mvp/mvp.md
```

Expected: no matches.

- [ ] **Step 3: Check required concepts**

Run searches confirming `create-evaluation.ps1`, `idea-workspace`, `project_id`, `idea_id`, invitation-only registration, actor-inclusive push, Drive host transfer, frozen project rules, and both update scan roots are present.

- [ ] **Step 4: Check cross references and encoding**

Search all `Bolum N` references and verify their target sections exist. Search for mojibake byte patterns and accidental non-ASCII additions inconsistent with the file.

- [ ] **Step 5: Run Git whitespace validation**

Run:

```powershell
git diff --check -- mvp/mvp.md
git diff --stat -- mvp/mvp.md
git status --short
```

Expected: no whitespace errors; only intended existing workspace changes remain.
