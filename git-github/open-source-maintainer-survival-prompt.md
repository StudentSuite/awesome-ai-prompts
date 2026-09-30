# Reusable prompt: open source maintainer survival

Copy-paste the block below into any AI coding agent to harden an open source
project's maintenance practices so it keeps moving without burning out its
maintainers: clear contribution guidelines, automation for the tedious
parts, kind ways to say no, and a bus factor that is not one person.

Keywords: maintainer, burnout, sustainability, community management, scope, say no

---

Review this project's maintenance setup and produce a plan that keeps it
sustainable: less noise, more automation, documented boundaries, and a path
for others to take over. Recommend changes that are actionable in this repo,
not generic advice.

## Steps

1. **Read the current setup** - Read CONTRIBUTING, issue and PR templates,
   workflows, and recent maintainer activity. Understand what pulls the
   project's attention today and what is manual.
2. **Audit the noise** - Find the repetitive sources of maintainer work:
   unlabeled issues, duplicate questions, stale PRs, and unclear
   contribution expectations. Quantify what you can (for example, issues
   submitted without the template filled in).
3. **Make guidelines filter, not block** - Amend CONTRIBUTING.md so a new
   contributor knows exactly what a good issue or PR looks like, what needs
   reproducing, and what types of change will be declined. Write decline
   reply templates that are respectful and specific, and reuse them.
4. **Automate the tedious parts** - Propose concrete automations that exist
   today: stale-bot or label automation, CI gates that check the cheap
   stuff, release and version tooling, and dependency updates. Wire them
   into the repo's actual CI files, not hypothetical ones.
5. **Set expectations publicly** - Produce a short roadmap or maintenance
   policy that says what is accepted, what is not, and how fast anything
   gets reviewed. Communication that sets expectations reduces repeated
   asks.
6. **Reduce the bus factor** - Identify every task and document that only one
   person can do. Produce an ownership map: which areas need another named
   person or at least written ownership notes, who can merge, and what a
   successor needs to run a release.

## Verification

- [ ] Every recommended automation maps to a change in this repo's CI or
      config files, not a generic suggestion.
- [ ] CONTRIBUTING changes cover the top noise sources found in step 2.
- [ ] Decline templates are written and stored where contributors will see
      them (a templates dir, or linked from CONTRIBUTING).
- [ ] The bus-factor audit names at least one single-owner area and what the
      fix is.
- [ ] No recommendation depends on the maintainer working more hours - every
      one reduces or redistributes load.

## Rules

- Never propose automation you have not verified exists; mark custom
  automations as "needs a custom action" if so.
- Never add process that costs more than the noise it removes.
- Never write a decline template that is curt or dismissive.
- Keep recommendations scoped to this repo; do not drift into how to run
  every open source project ever.
