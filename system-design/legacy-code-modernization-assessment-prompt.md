# Reusable prompt: legacy code modernization assessment [spec]

Copy-paste the block below into any AI coding agent to decide whether a
legacy system should be modernized at all, and if so in what order. This
is the heavy format for work where a wrong answer ships a regression, so
the deliverable is an evidence-backed verdict, not a rewrite.

Keywords: legacy code, modernization, assessment, strangler fig, end of life

---

Assess whether `[system or module]` should be modernized, and in what
order, in this repository. The rule: assessment before rewrite. The
deliverable is a recommendation with evidence, a risk-ranked sequence,
and stop conditions. "Leave it alone, here is why" is a valid outcome.

## Define the scope first

Decide these before any work starts; no code is read until scope is set.

1. **The system or module** - Name the one system, service, or package
   in scope and its boundary. Assessment of the whole org is not this.
2. **The environments** - Name which environments exist and which you
   may read (production, staging, local). Default to read-only.
3. **The running version** - State the version actually deployed, not
   the manifest version, and where you read each one.
4. **Inputs and outputs** - Inputs: code, lockfiles, a production
   version probe, vendor support pages. Outputs: the artifacts below.
5. **Out of scope** - A big-bang rewrite is out of scope, and so is any
   production code change during the assessment.

## What to produce

1. **Inventory table** - One row per framework, language, runtime,
   datastore, and build/deploy tool: the version actually running, its
   end-of-life date, and the source that states the date.
2. **Vulnerability findings** - Each finding with a file:line, the
   dependency or runtime it comes from, and a rank of whether it is
   exploitable in this codebase.
3. **Value-versus-risk matrix** - Every module scored on business value
   against change risk (coupling, coverage, migration difficulty,
   unknowns), with the evidence behind each score.
4. **Strangler-fig seam per module** - The interface where a new
   implementation can replace the old: an HTTP or event boundary, a
   shared read, or a thin contract. No seam means a rewrite plan.
5. **Characterization-test plan** - The tests that pin current behavior
   before anything moves: golden-master or snapshot tests for risky
   paths, contract tests at each seam, and a module regression suite,
   each naming the behaviors to pin and the fixture source.
6. **Sequenced steps** - Ordered by dependency, not by size, where each
   step leaves the system deployable and names its rollback. Show which
   steps can run in parallel.
7. **The verdict** - One of: modernize incrementally, replace one
   bounded module, or leave it. Include the estimate and the unknowns
   the estimate depends on.
8. **What could not be assessed** - Every unknown, with the evidence
   that would settle it. Hiding unknowns is more dangerous than naming
   them.

## Method

Run these phases in order; each has an exit condition.

1. **Baseline the running system** - Record the deployed version and
   vendor support status, plus any incident or coverage data you can
   measure. Exit: every inventory row has a version and a cited source.
2. **Scan for vulnerabilities** - Check dependencies and runtime for
   known advisories. Exit: each finding carries a file:line and an
   exploitability rank.
3. **Score value against risk** - Split the system into modules and
   score each from coverage, coupling, migration difficulty, and
   unknowns. Exit: the matrix covers every module.
4. **Find the seam per module** - Name the boundary and the contract
   that crosses it. Exit: each module in scope has a named seam.
5. **Pin behavior before change** - Specify the characterization tests
   and confirm they pass against the current code. Exit: the tests are
   specified with fixtures and pass before any change.
6. **Sequence by dependency** - Order the steps so each leaves the
   system deployable and has a rollback. Exit: a step table where no
   step depends on a later step.
7. **Issue the verdict** - Choose one of the three outcomes, state the
   evidence, the estimate, its unknowns, and the stop conditions. Exit:
   a single verdict tied to the evidence above.

## Verification

- [ ] The inventory names the version actually running, not the manifest,
      and the source for each row.
- [ ] Every end-of-life date cites a vendor source, not memory.
- [ ] Every vulnerability finding carries a file:line and an
      exploitability rank for this codebase.
- [ ] The value-risk matrix covers every module, with the evidence
      behind each score.
- [ ] Every module slated for change has a named strangler-fig seam and
      the contract that crosses it.
- [ ] Characterization tests are specified for each module to change,
      with fixture sources, and they pass before any change.
- [ ] Each sequenced step leaves the system deployable, does not depend
      on a later step, and names its rollback and trigger.
- [ ] The verdict is one of the three outcomes, backed by evidence,
      with the estimate and its unknowns.
- [ ] Stop conditions are stated in advance: the point to halt and keep
      the old system.
- [ ] What could not be assessed is listed with the evidence that would
      settle it.
- [ ] The assessment changed no production code.

## Rules

- Never recommend a big-bang rewrite; every step must leave the system
  deployable.
- Never recommend modernization on version age alone; tie it to support
  status, a file:line vulnerability, or a named business cost.
- Never start changing code before the characterization tests for that
  module exist.
- Never present an estimate without naming the unknowns it depends on.
- Never skip the "leave it alone" option because it is inconvenient.
- Never claim support status, an end-of-life date, or exploitability
  without a cited source or file:line.
- Never let a step leave the system undeployable, even temporarily.
