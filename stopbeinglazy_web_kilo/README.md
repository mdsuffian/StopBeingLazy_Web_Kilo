# SmartWeb Mode v6.3.0 — Kilo Code Agent

**Four-layer research-driven S2 protocol with post-completion iterative improvement search.**

Strategy 2 now executes four distinct research passes — from baseline correctness through to post-completion polish. The final layer searches for refinements after the solution is built: lessons learned, code review patterns, accessibility gaps, and upgrade readiness. SmartWeb doesn't just build solutions — it polishes them.

## S2: Four-Layer Research Architecture

```
STEP 0: MANDATORY BASELINE (all strategies)
    └─ Official docs, package registries, API references

STRATEGY 2 PROTOCOL (7 steps across 4 layers):

Step 1: REVIEW BASELINE
    └─ What is the CORRECT way to do this?

Step 2: CREATIVE ADDON SEARCH (Layer 2)
    └─ How does the COMMUNITY do it better?

Step 3: DEEP RESEARCH LAYER (Layer 3)
    └─ Is it SAFE, FAST, and FUTURE-PROOF?

Step 4: SYNTHESIZE (all 3 layers)
    └─ Combine into enriched plan

Step 5: EXECUTE WITH VERIFICATION
    └─ Validate each step against all 3 layers

Step 6: POST-EXECUTION VALIDATION
    └─ Confirm best approach was used

Step 7: ITERATIVE IMPROVEMENT SEARCH (Layer 4) ← NEW
    └─ Solution is built. Now: "What would make it even better?"
```

## Layer 4: Iterative Improvement (Step 7)

Runs AFTER the solution is drafted. Searches for refinements that only become visible after building:

| Research Target | URL | What It Reveals |
|---|---|---|
| **Lessons learned** | `dev.to/search?q={feature}+lessons+learned` | "After building X, here's what I'd do differently" |
| **Retrospectives** | `medium.com/search?q={feature}+improvements` | Post-mortems, refinement guides |
| **Optimization patterns** | Stack Overflow by tag + "improve" | Battle-tested optimizations |
| **Accessibility gaps** | `smashingmagazine.com/search/?q={feature}+accessibility` | Inclusive design, a11y improvements |
| **Upgrade readiness** | GitHub Issues: `breaking+change+v{next-version}` | Will this break next version? |
| **Code review lens** | GitHub Code Search: `code+review+best+practices` | What would a senior dev flag? |

**Step 7 actions (surgical, not restart):**
- Concrete improvement found → apply immediately (surgical refinement)
- Better pattern discovered → note as suggested follow-up
- Approach confirmed solid → output with confidence
- **1 fetch, seconds of research, hours of rework saved**

## All 42 URL Templates

| Category | Count | Sources |
|---|---|---|
| Official docs | 16 | npm, PyPI, crates.io, pkg.go.dev, React, Next.js, Tailwind, Vite, TypeScript, Node.js, Python, MDN, Docker, GitHub, error search, general |
| Creative sources | 10 | Stack Overflow, GitHub Discussions, Dev.to, Medium, Patterns.dev, CSS-Tricks, Smashing Magazine, Reddit, Hacker News, YouTube |
| Deep research | 10 | GitHub Code Search, BundlePhobia, npm trends, CanIUse, GitHub Security, npm audit, Changelog, Releases, Snyk, LibHunt |
| Iterative improvement | 6 | Dev.to lessons, Medium reflections, Stack Overflow refinements, Smashing a11y, GitHub future issues, Code Review guides |

## Anti-Laziness Table (18 rows)

3 new rows for Layer 4:

| Model's thought | Refutation |
|---|---|
| "I'm done, no need to search again" | Completion is when the solution is POLISHED, not just built. Step 7 is the polish pass. |
| "The user won't notice missing refinements" | Excellence is in the details. One extra search finds the details. |
| "Iterative improvement is over-engineering" | Step 7 is 1 webfetch. It takes seconds. It saves hours of future rework. |

3 new banned phrases:
- "I'm done searching" / "No more improvements needed" / "Iterative improvement is over-engineering"

## Full S2 Caps

| Phase | Fetches |
|---|---|
| Step 0 baseline | 1-2 |
| Step 2 creative addon | 1-2 |
| Step 3 deep research | 1-2 |
| Step 7 iterative improvement | 1 |
| **Total S2** | **4-7 max** |

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
├── .kilo/agent/smartweb.md   ← v6.3.0 four-layer agent
├── installer/
│   ├── install.ps1           ← v6.3.0
│   ├── install.sh            ← v6.3.0
│   └── install.js            ← v6.3.0
├── kilo.json                 ← v6.3.0 config
└── README.md
```

## Version History

- **v6.3.0** — Four-layer protocol. Layer 4: iterative improvement search (post-completion polish). 6 new URL templates (42 total). S2 = 7 steps. Anti-laziness at 18 rows.
- **v6.2.0** — Three-layer architecture. Layer 3: deep research (perf, security, compat).
- **v6.1.0** — Creative addon search. Layer 2: community sources.
- **v6.0.0** — Fetch-first, anti-laziness table, binary verification.
- **v5.0.0** — Checkbox-driven checklist enforcement.
- **v4.0.0** — Proportional +WEB strategy variants.
- **v3.0.0** — Always-on web search (failed).
- **v2.0.0** — Q0 merged into decision tree.
- **v1.x** — Discretionary approaches.
