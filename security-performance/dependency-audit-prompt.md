# Reusable prompt: dependency audit

Copy-paste the block below into any AI coding agent to audit dependencies for
vulnerabilities, license issues, and staleness - with actionable fix
recommendations, not just a wall of warnings.

Keywords: dependency audit, vulnerabilities, supply chain, lockfile, transitive

---

Audit the dependencies of this repository. The goal: identify security risks,
license concerns, and stale packages, then provide a prioritized fix plan.

## Steps

1. **Run the vulnerability scanner** - Use the repo's native tooling:
   `npm audit`, `pip-audit`, `cargo audit`, `bundler-audit`, `govulncheck`,
   or `gh extension security`. Capture the full output. If no scanner is
   configured, set up the appropriate one for the stack.
2. **Check licenses** - Identify all dependency licenses using the repo's
   package manager or a license checker. Flag any copyleft licenses (GPL,
   AGPL) or licenses incompatible with the project's own license. List
   permissive licenses (MIT, BSD, Apache) as clean.
3. **Assess staleness** - For each direct dependency, check: when it was
   last published, how many versions behind it is, and whether it has been
   deprecated or archived. Flag packages with no release in over a year.
4. **Classify risk** - For each finding, assess:
   - **Critical/High** - Known exploitable vulnerability, active in the
     dependency tree
   - **Medium** - Vulnerability with mitigating factors or transitive
     dependency
   - **Low** - Outdated but no known vulnerability, or dev-only dependency
   - **License** - Incompatible license that may have legal implications
5. **Provide fix recommendations** - For each finding: the recommended
   version to upgrade to, whether the upgrade is semver-compatible (safe) or
   a major version (requires migration), and any breaking changes to watch
   for. Group fixes by effort level: drop-in replacements first, then minor
   migrations, then major rewrites.
6. **Verify fixes** - After applying recommended upgrades, re-run the
   vulnerability scanner and test suite to confirm the fixes work without
   regressions.

## Rules

- Never upgrade dependencies blindly without checking the changelog for
  breaking changes.
- Never ignore a critical vulnerability because "it's probably not
  exploitable in our context" - document the risk assessment instead.
- Never add new dependencies to fix audit findings without checking if the
  existing dependency has a safe version.
- If a dependency is abandoned with no maintained fork, flag it for
  replacement rather than continuing to use it.
