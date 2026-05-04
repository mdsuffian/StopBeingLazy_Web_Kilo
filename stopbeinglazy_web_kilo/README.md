# SmartWeb Mode v8.0.0 — Kilo Code Agent

**Structural anti-laziness architecture. Mechanical gates beat Smart Mode when the underlying model is dumb or lazy.**

Previous versions (v3-v7) focused on INPUT-side forcing: mandatory webfetch before any action. This failed because a lazy model does a half-hearted fetch and still produces lazy output. v8.0.0 inverts the approach: quality gates on the OUTPUT side make thoroughness mechanically inescapable.

## Why v8.0.0 Beats Smart Mode for Lazy Models

| Problem | Smart Mode (code) | SmartWeb v6-v7 | SmartWeb v8.0.0 |
|---|---|---|---|
| Lazy model classifies everything as S1 | Trusts model judgment → abused | Irrelevant (webfetch runs regardless) | **S1 GATE: 3 objective checks lock S1 unless truly trivial** |
| Lazy model writes vague plans | "1. Fix bug" passes S2 | Same problem | **Vague bullets trigger forced S3 escalation** |
| Lazy model skips edge cases | No enforcement | No enforcement | **COMPLETENESS CHECK: 3 questions after every task** |
| Lazy model declares "done" prematurely | No gate | No gate | **All 3 checks must pass or task is not done** |
| Lazy model skips web search for stale knowledge | No enforcement | Wastes tokens on trivial tasks too | **Trigger-based webfetch: required for knowledge gaps, skipped for fundamentals** |

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   SMARTWEB MODE v8.0.0                        │
│                                                               │
│  PHASE 0: S1 GATE (runs first, before any tool)              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 3 objective checks. ALL must pass to use S1.          │   │
│  │ 1. Exactly 1 tool call for COMPLETE answer?           │   │
│  │ 2. Zero design choice or ambiguity?                   │   │
│  │ 3. ≤5 lines of code in single file?                   │   │
│  │ If ANY fails → S1 locked, proceed to Phase 1          │   │
│  └──────────────────────┬───────────────────────────────┘   │
│                         │ S1 locked → decision tree           │
│                         ▼                                     │
│  PHASE 1: STRATEGY DECISION TREE                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Q1→S1 | Q2→(Q2a→S4 | S2) | S3                        │   │
│  └──────────────────────┬───────────────────────────────┘   │
│                         │                                     │
│  S1 / S2 / S3 / S4 — each with built-in anti-laziness rules │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ S2: mandates specific file paths + actions            │   │
│  │ S3: requires evidence (file:line citations)           │   │
│  │ S4: delegation mandatory, no DIY                      │   │
│  │ WEB SEARCH: trigger-based (knowledge gaps), not ritual│   │
│  └──────────────────────┬───────────────────────────────┘   │
│                         │                                     │
│                         ▼                                     │
│  COMPLETENESS CHECK (runs after EVERY strategy)               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. Production-ready? No stubs, TODOs, placeholders?   │   │
│  │ 2. Edge cases handled? (empty, null, error, boundary) │   │
│  │ 3. Self-contained? No follow-up needed to use it?     │   │
│  │ ALL 3 must pass → task is done                        │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## Comparison: Old vs New

| Dimension | v6-v7 (fetch-first) | v8.0.0 (output-gated) |
|---|---|---|
| Primary defense | Web search before acting | Quality gates after acting |
| Blocks lazy S1 abuse | No (web search runs regardless) | Yes (S1 GATE with objective criteria) |
| Blocks lazy plans | No | Yes (vague bullets → forced S3) |
| Blocks lazy completion | No | Yes (COMPLETENESS CHECK) |
| Token waste on trivial tasks | High (mandatory fetch) | Low (fetch only on triggers) |
| Catches missing edge cases | No | Yes (CHECK question 2) |
| Self-contained output enforced | No | Yes (CHECK question 3) |
| Lazy thought detection | Partial (5 thoughts) | Comprehensive (7 thoughts with corrections) |
| Web search intelligence | Task-type-based (blunt) | Information-gap-based (precise) |
| Lines | 147 | 156 |

## The S1 GATE

The critical innovation. In Smart Mode, a lazy model can route ANY task to S1 by claiming it's "trivial." The S1 GATE uses 3 objective questions the model cannot fudge:

1. **1 tool call for complete answer?** — Not "1 step" but "1 tool call." Reading a file + editing it = 2 calls = NOT S1.
2. **Zero design choice?** — Any decision between valid approaches = NOT S1.
3. **≤5 lines in single file?** — Any real code change exceeds this. Renames and value changes pass.

A lazy model defaults to S1. This gate forces S2 minimum on anything nontrivial — and S2 has its own anti-laziness enforcement (vague bullets → S3).

## WEB SEARCH: Trigger-Based, Not Ritual

| Trigger | Action |
|---|---|
| Package/API/library with version-specific behavior | MUST fetch official docs |
| Error message code inspection can't explain | MUST fetch |
| "Latest", "current", year-specific info | MUST fetch |
| Function/syntax unused in 6+ months | MUST fetch |
| Complex security-sensitive pattern | MAY fetch |
| Pure logic, fundamentals, mechanical tasks | SKIP fetch |

## LAZY THOUGHT DETECTOR

7 specific lazy thoughts with correction instructions. If the model catches itself thinking any of these, it must stop and course-correct:

- "This is probably fine" → Verify. "Probably" means you didn't check.
- "I'll keep it simple" → Simple is fine. Incomplete is not.
- "They can figure out the rest" → No. Produce the complete output.
- "That's good enough" → Is it COMPLETE? "Good enough" ≠ "done."
- "I don't need to check that" → If you thought about checking it, check it.
- "This doesn't need investigation" → Did it pass S1 GATE? If not → investigate.
- "The fix is obvious" → Write it. Then verify it.

## Installation

### Windows (PowerShell)
```powershell
.\installer\install.ps1 [-Global] [-Project "C:\path\to\project"]
```

### macOS / Linux
```bash
chmod +x installer/install.sh
./installer/install.sh [--global] [--project /path/to/project]
```

### Cross-platform (Node.js)
```bash
node installer/install.js [--global] [--project /path/to/project]
```

## Project Structure

```
stopbeinglazy_web_kilo/
├── .kilo/agent/smartweb.md   ← v8.0.0 structural anti-laziness agent
├── installer/
│   ├── install.ps1
│   ├── install.sh
│   └── install.js
├── kilo.json
└── README.md
```

## Version History

- **v8.0.0** — Structural anti-laziness: S1 GATE (3 objective checks), COMPLETENESS CHECK (post-execution 3-question gate), trigger-based webfetch (not ritual), LAZY THOUGHT DETECTOR (7 thoughts), S2 vague-bullet escalation to S3, S3 evidence requirement, S4 delegation enforcement. Removed SWIPE layer (bloat), removed mandatory webfetch (waste). 156 lines.
- **v7.0.0** — SWIPE Layer: Intent-Aware Prompt Enhancement preprocessor. (Deprecated — bloat, lazy models skipped it.)
- **v6.3.0** — Four-layer protocol with iterative improvement search. (Deprecated — over-engineered.)
- **v6.2.0** — Three-layer architecture with deep research.
- **v6.1.0** — Creative addon search layer.
- **v6.0.0** — Fetch-first, anti-laziness table, binary verification.
- **v5.0.0** — Checkbox-driven checklist enforcement.
- **v4.0.0** — Proportional +WEB strategy variants.
- **v3.0.0** — Always-on web search (failed).
