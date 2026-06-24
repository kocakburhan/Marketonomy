# Projects Root Onboarding v5.5.0 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a persistent `Projects/` onboarding bootstrap, preserve rich marketer context, and publish a verified `v5.5.0` release.

**Architecture:** A dedicated root installer copies the canonical onboarding guide into
`Projects/onboarding-guide.md`, installs a thin `Projects/AGENTS.md`, and stores update metadata
under `.pa/`. Project creation remains separate and copies the reusable marketer profile into the
project workspace.

**Tech Stack:** PowerShell, Bash, Git, GitHub CLI/API, Markdown, JSON, SHA-256 manifests.

---

### Task 1: Lock Profile And Bootstrap Contracts

**Files:**
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/templates/workspace-bootstrap-AGENTS.md`
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] Add failing assertions for the seventh optional profile question, `Ek kullanıcı bağlamı`,
  exact profile copying, and the project bootstrap profile reference.
- [ ] Run compatibility and workspace-create tests and confirm the new assertions fail.
- [ ] Update the onboarding guide and project bootstrap.
- [ ] Run both tests and confirm they pass.

### Task 2: Add Projects Root Installer And Update Flow

**Files:**
- Create: `marketing-agent/templates/projects-root-bootstrap-AGENTS.md`
- Create: `marketing-agent/scripts/check-onboarding-update.ps1`
- Create: `marketing-agent/scripts/check-onboarding-update.sh`
- Create: `marketing-agent/scripts/update-onboarding.ps1`
- Create: `marketing-agent/scripts/update-onboarding.sh`
- Create: `scripts/install-projects-root.ps1`
- Create: `scripts/install-projects-root.sh`
- Create: `scripts/test_projects_root_onboarding.ps1`
- Modify: `scripts/test_marketing_agent_macos_scripts.ps1`

- [ ] Write a failing end-to-end test that installs into a temporary `Projects/` root.
- [ ] Assert bootstrap, canonical guide copy, metadata, update scripts, profile preservation,
  project preservation, invalid project-root rejection, and consent-gated update behavior.
- [ ] Run the test and confirm failure because the installer does not exist.
- [ ] Implement Windows install/check/update scripts with manifest verification and atomic staging.
- [ ] Implement Bash parity and static contract assertions.
- [ ] Run root onboarding and macOS contract tests until green.

### Task 3: Align Project Creation With Installed Root Metadata

**Files:**
- Modify: `scripts/create-project.ps1`
- Modify: `scripts/create-project.sh`
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] Add failing tests proving the root profile is copied byte-for-byte and root install metadata
  can supply the default repo URL/version when explicit values are absent.
- [ ] Run the workspace-create test and confirm failure.
- [ ] Implement metadata fallback without weakening explicit parameters.
- [ ] Run the workspace-create test and confirm success.

### Task 4: Update Contract And User Documentation

**Files:**
- Modify: `mvp/mvp.md`
- Modify: `README.md`
- Modify: `REHBER.md`
- Modify: `ilk kurulum.md`
- Modify: `yapılacaklar.md`
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/QUICKSTART.md`

- [ ] Document `Projects/AGENTS.md`, `Projects/onboarding-guide.md`, install metadata, official
  installer commands, profile freedom, and project profile copy behavior.
- [ ] Remove guidance that says only marketer-profile is created at the root.
- [ ] Use `v5.5.0` for the deterministic pilot path.

### Task 5: Version, Manifest, And Full Verification

**Files:**
- Modify: `marketing-agent/agent-version.json`
- Modify: `marketing-agent/skills/list.md`
- Regenerate: `marketing-agent/release-manifest.json`

- [ ] Change the version to `v5.5.0`.
- [ ] Rebuild the release manifest with the resolved absolute AgentRoot.
- [ ] Run compatibility, healthcheck, root onboarding, workspace create, install/update, macOS
  contract, UTF-8, stale-reference, and `git diff --check` validations.

### Task 6: Publish And Smoke Test v5.5.0

**Files:**
- Git commit, tag, and GitHub Release only.

- [ ] Commit the verified changes.
- [ ] Push `main`.
- [ ] Create and push annotated `v5.5.0`.
- [ ] Publish a non-draft, non-prerelease GitHub Release.
- [ ] Install a clean temporary Projects root and create `x-projesi` from the remote `v5.5.0`.
- [ ] Verify the GitHub API returns the release and tag at the expected commit.
