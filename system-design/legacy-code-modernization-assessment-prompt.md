# Reusable prompt: legacy code modernization assessment

Copy-paste the block below into any AI coding agent to decide whether a legacy
system should be modernized at all - and if so, in what order, with a
characterization test safety net and explicit stop conditions.

Keywords: legacy code, modernization, assessment, strangler fig, characterization test, end of life

---

Assess whether `[system or module]` should be modernized, and in what order, in
this repository. The rule: **assessment before rewrite**. The deliverable is a
recommendation with evidence, a risk-ranked sequence, and stop conditions. If
the honest answer is "leave it alone, here is why", that is a valid outcome.

## Steps

1. **Inventory what is actually running** - List the frameworks and major
   versions, the language and runtime, the datastores, and the build and deploy
   tooling. For each, record its support status and end-of-life date from the
   vendor, not from memory. Note the version actually running in production, not
   the one in the manifest.
2. **Assess the security and support posture** - Check for known
   vulnerabilities in the current dependencies and runtime, whether the
   platform that runs this is still supported, and whether patches are still
   arriving. Rank the findings by whether they are exploitable in this codebase,
   with a file:line reference for each.
3. **Map value against risk per module** - Split the system into modules and
   score each on business value (what breaks or slows if it is unavailable or
   hard to change) against change risk (coupling, test coverage, data
   migration difficulty, unknowns). Put the result in a table. The high-value
   low-risk quadrant is the first work; high-value high-risk modules need the
   seams in step 4 before anything else.
4. **Find the seams for incremental replacement** - Identify the boundaries
   where a strangler-fig approach can work: an HTTP or event interface, a
   shared database that can be read by both systems, or a module boundary with a
   thin contract. Name the specific seam per module and what has to move behind
   it. A plan with no seam is a rewrite plan.
5. **Plan the characterization tests first** - For each module you intend to
   change, specify the tests that pin current behavior before anything moves:
   golden-master or snapshot tests for the risky paths, contract tests at each
   seam, and a regression suite for the module. Name the specific behaviors to
   pin and where the fixtures come from. Without these, every step is a guess.
6. **Sequence the work by dependency, not by size** - Produce an ordered list of
   steps where each one leaves the system working and deployable, and each step
   names its rollback. Show which steps can be parallelized and which cannot.
7. **Recommend, and say when to stop** - Give one of three verdicts with
   evidence: modernize incrementally, replace one bounded module, or leave it.
   Include the estimate and the reason it is worth it. Then state stop
   conditions in advance: the point at which you would halt the program and keep
   the old system (for example, no parity after N steps, or a data migration
   that cannot be proven reversible).
8. **Name what you could not assess** - List what you could not determine from
   the code, and what evidence would settle it. An assessment that hides its
   unknowns is more dangerous than one that lists them.

## Rules

- Never recommend a big-bang rewrite. Every step must leave the system
  deployable.
- Never recommend modernization on version-age alone. Tie it to support status,
  a vulnerability with a file:line, or a business cost you can name.
- Never start changing code before the characterization tests for that module
  exist.
- Never present an estimate without naming the unknowns it depends on.
- Never skip the "leave it alone" option because it is inconvenient to say.

## Verification

Paste the inventory table with end-of-life dates and the source for each, the
vulnerability findings with file:line, the value-risk table, the seam per
module, the characterization tests to write, the ordered steps with rollbacks,
the verdict, and the list of what you could not assess.
