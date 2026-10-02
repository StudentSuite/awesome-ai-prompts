# Reusable prompt: open source maintainer survival

Copy-paste the block below into any AI coding agent to harden an open source
project's maintenance practices so it keeps moving without burning out its
maintainers: clear contribution guidelines, automation for the tedious parts,
kind ways to say no, and a bus factor that is not one person.

Keywords: maintainer, burnout, sustainability, community management, scope, say no

---

Review this project's maintenance setup and produce a plan that keeps it
sustainable: less noise, more automation, documented boundaries, and a path for
others to take over. Recommend changes that are actionable in this repo, not
generic advice.

## Steps

1. **Read the current setup** - CONTRIBUTING, issue and PR templates,
   workflows, and recent maintainer activity: what pulls attention today and
   what is manual.
2. **Audit the noise** - Quantify the repetitive sources of maintainer work:
   unlabeled issues, duplicate questions, stale PRs, unclear contribution
   expectations, such as issues submitted with the template unfilled.
3. **Make guidelines filter, not block** - Amend CONTRIBUTING.md: what a good
   issue or PR looks like, what needs reproducing, what gets declined. Add
   respectful, specific decline reply templates and reuse them.
4. **Automate the tedious parts** - Propose automations that exist today:
   stale-bot or label automation, CI gates for the cheap checks, release
   tooling, dependency updates. Wire them into the repo's real CI files.
5. **Set expectations publicly** - A short roadmap or maintenance policy:
   what is accepted, what is not, how fast anything gets reviewed.
6. **Reduce the bus factor** - Identify every task and document only one
   person can do, then produce an ownership map: which areas need another
   named owner, who can merge, what a successor needs to run a release.

## Verification

- [ ] The current setup was read first: CONTRIBUTING, templates, and existing
      automation.
- [ ] The noise audit names concrete repeated requests with counts, not a
      general impression.
- [ ] Each CONTRIBUTING amendment maps to a noise source actually found in
      step 2.
- [ ] Every proposed automation is verified to exist, or marked custom and its
      cost stated.
- [ ] Decline templates are written in a tone that is not curt, and stored
      where contributors will see them.
- [ ] The bus-factor audit names at least one single-owner area and what
      happens if that person leaves.
- [ ] No recommendation assumes the maintainer works more hours.

## Rules

- Never propose automation you have not verified exists; mark custom
  automations as "needs a custom action" if so.
- Never add process that costs more than the noise it removes.
- Never write a decline template that is curt or dismissive.
- Keep recommendations scoped to this repo; do not drift into how to run every
  open source project ever.
