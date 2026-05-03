# SmartWeb Mode v6.2.0 — Kilo Code Agent

**Three-layer research-driven web search enforcement for Strategy 2 planning.**

The S2 protocol now executes three distinct research passes before synthesizing a plan. Each layer adds a progressively deeper dimension: correctness (official docs), creativity (community sources), and safety (deep implications). The model doesn't just plan — it researches, validates, stress-tests, and security-audits the plan before a single line of code is written.

## S2: Three-Layer Research Architecture

```
STEP 0: MANDATORY BASELINE SEARCH (all strategies)
    └─ Official docs, package registries, API references

STRATEGY 2 PROTOCOL (6 steps):

Step 1: REVIEW BASELINE
    └─ Official docs establish the CORRECT API surface

Step 2: CREATIVE ADDON SEARCH (Layer 2)
    └─ Stack Overflow, Dev.to, GitHub Discussions, Medium, Patterns.dev
    └─ Discovers: alternative approaches, elegant patterns, community wisdom

Step 3: DEEP RESEARCH LAYER (Layer 3) ← NEW
    └─ GitHub Code Search, BundlePhobia, CanIUse, Snyk, GitHub Security
    └─ Discovers: reference implementations, performance, security, compatibility, deprecation risk

Step 4: SYNTHESIZE
    └─ Combine all 3 layers → enriched plan with correctness + creativity + safety

Step 5: EXECUTE WITH VERIFICATION
    └─ Validate each step against all 3 web layers

Step 6: POST-EXECUTION VALIDATION
    └─ Confirm: did I use the best approach from all 3 layers?
```

## Layer 3: Deep Research (What It Finds)

| Research Target | URL Template | What It Reveals |
|---|---|---|
| **Reference implementations** | `github.com/search?q={keywords}+language:{lang}&type=code` | Real open-source code patterns, error handling, edge cases |
| **Bundle size / perf** | `bundlephobia.com/package/{name}` | Tree-shaking viability, min+gz cost, dependency weight |
| **Package comparison** | `npmtrends.com/{pkg-a}-vs-{pkg-b}` | Download trends, community preference, alternatives |
| **Browser support** | `caniuse.com/?search={feature}` | Cross-browser compatibility, API coverage |
| **Security vulnerabilities** | `github.com/{owner}/{repo}/security/advisories` | Known CVEs, patched versions, severity |
| **Vulnerability DB** | `security.snyk.io/package/npm/{name}` | Active vulnerabilities with fix versions |
| **Changelog / deprecations** | `github.com/{owner}/{repo}/blob/main/CHANGELOG.md` | Breaking changes, migration paths, deprecation timelines |
| **Release history** | `github.com/{owner}/{repo}/releases` | Version notes, what changed when |
| **Community ratings** | `libhunt.com/r/{name}` | Alternatives comparison, community activity stats |

## All 36 URL Templates

| Category | Count | Sources |
|---|---|---|
| Official docs | 16 | npm, PyPI, crates.io, pkg.go.dev, React, Next.js, Tailwind, Vite, TypeScript, Node.js, Python, MDN, Docker, GitHub, error search, general |
| Creative sources | 10 | Stack Overflow, GitHub Discussions, Dev.to, Medium, Patterns.dev, CSS-Tricks, Smashing Magazine, Reddit, Hacker News, YouTube |
| Deep research | 10 | GitHub Code Search, BundlePhobia, npm trends, CanIUse, GitHub Security, npm audit, Changelog, Releases, Snyk, LibHunt |

## Anti-Laziness Table (15 rows)

5 new rows targeting deep research excuses:

| Model's thought | Refutation |
|---|---|
| "Creative ideas are enough, I don't need deep research" | Creative shows HOW. Deep research shows whether it's SAFE, FAST, and MAINTAINABLE. |
| "Performance doesn't matter for this" | Users abandon slow apps. Bundle size matters. Always check. |
| "I'll handle security later" | Security is not a layer. It is a property. Research it NOW. |
| "Reference implementations won't help" | Real code teaches more than documentation. Search GitHub. |

3 new banned phrases:
- "Deep research is unnecessary" / "Performance doesn't matter" / "Security can wait"

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
├── .kilo/agent/smartweb.md   ← v6.2.0 three-layer agent
├── installer/
│   ├── install.ps1           ← v6.2.0
│   ├── install.sh            ← v6.2.0
│   └── install.js            ← v6.2.0
├── kilo.json                 ← v6.2.0 config
└── README.md
```

## Version History

- **v6.2.0** — Three-layer research architecture. Layer 3 (Deep Research) added: reference implementations, performance, security, compatibility, deprecation. 10 new deep research URL templates (36 total). S2 expanded to 6-step protocol. Anti-laziness table at 15 rows.
- **v6.1.0** — Creative addon search. S2 5-step protocol with community-source enrichment. 10 creative URL templates (26 total).
- **v6.0.0** — Fetch-first, validate-later. Anti-laziness table. Binary verification.
- **v5.0.0** — Checkbox-driven checklist with triple enforcement.
- **v4.0.0** — Proportional +WEB strategy variants with Q1w gate.
- **v3.0.0** — Always-on web search. Failed.
- **v2.0.0** — Q0 merged into decision tree.
- **v1.x** — Discretionary approaches.
