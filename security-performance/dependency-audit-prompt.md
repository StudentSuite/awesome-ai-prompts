# Reusable prompt: dependency audit

Copy-paste the block below into any AI coding agent to audit dependencies for
vulnerabilities, license issues, and staleness - with actionable fix
recommendations, not just a wall of warnings.

Keywords: dependency audit, vulnerabilities, supply chain, lockfile, transitive

---

Audit the dependencies of this repository. The goal: identify security risks,
license concerns, and stale packages, then provide a prioritized fix plan.

## Steps

1. **Run the repo's scanners** - Use the native tooling: `npm audit`,
   `pip-audit`, `cargo audit`, `bundler-audit`, or `govulncheck`, plus
   `gh extension security` if the repo uses it. Capture the full output; set one
   up if the repo has none.
2. **Check licenses** - Inventory dependency licenses with the package manager
   or a license checker. Flag copyleft (GPL, AGPL) or anything incompatible
   with the project's own license; MIT, BSD, and Apache are clean.
3. **Assess staleness** - For each direct dependency, note the last publish
   date, how many versions behind it is, and whether it is deprecated or
   archived. Flag packages with no release in over a year.
4. **Classify risk** - Rank each finding: **Critical/High** - known exploitable
   vulnerability active in the tree; **Medium** - vulnerability with mitigating
   factors or transitive only; **Low** - outdated with no known vulnerability,
   or dev-only; **License** - incompatibility with legal implications.
5. **Recommend and verify fixes** - Give the target version, whether it is
   semver-compatible (safe) or a major bump (needs migration), and the breaking
   changes to watch, ordered drop-in first. Apply them, then re-run the scanner
   and the test suite and show the output clean.

## Verification

- [ ] The scan ran with the repo's own tooling and the output pasted.
- [ ] Every finding is classified by real exploitability, not by the scanner's
      severity label alone.
- [ ] Licenses are inventoried and any conflict or obligation is named.
- [ ] Each recommendation was checked against the changelog before being
      applied.
- [ ] The scanner was re-run after upgrades and now reports clean, with output
      shown.
- [ ] No new dependency was added to fix a finding without checking an existing
      one could not.
- [ ] An abandoned dependency with no maintained fork is flagged rather than
      silently ignored.

## Rules

- Never upgrade dependencies blindly without checking the changelog for
  breaking changes.
- Never ignore a critical vulnerability because "it's probably not exploitable
  in our context" - document the risk assessment instead.
- Never add new dependencies to fix audit findings without checking if the
  existing dependency has a safe version.
- If a dependency is abandoned with no maintained fork, flag it for replacement
  rather than continuing to use it.
