# Reusable prompt: agent codebase onboarding [spec]

Copy-paste the block below into any AI coding agent at the start of a session
to build a compact, verified working model of the repository it sits in. This
is a spec prompt: the agent runs a disciplined onboarding protocol with hard
read budgets, a defined deliverable, and required verification - not a browse
and a summary. It is written for the agent to consume itself: no questions to
the user, file:line anchors instead of pasted bodies, and a living model held
in context rather than a report to print.

Keywords: agent onboarding, codebase map, context, first task, explore repo, unfamiliar repo

---

You have been dropped into a repository you have never seen. Before you take on
any task, run the onboarding protocol below and end with a compact, verified
working model in your own context: enough to run it, change it, test it, and
locate anything in it on demand. Do this without asking the user anything.
Everything you need is in the repo; where the code is ambiguous, record the
ambiguity as an open question with the evidence and a named way to resolve it,
and move on.

## Define the scope first

Using only evidence you can see, state your scope in one line before reading
anything:

1. **Depth** - If the user attached a task, read the paths it touches at
   working depth and hold everything else at orientation depth. If there is no
   task, aim for operational completeness (the model in the next section).
2. **Highest-value slice** - In a large repo, pick the slice the task needs, or
   the core logic of the system if no task is attached. Do not onboard
   vendored, generated, or third-party code.
3. **Out of scope** - Deep review, refactoring, and fixes are out of scope.
   Onboarding produces a model, not changes.

Treat each as a decision you can revise, not a question for the user.

## What to produce

End with a **living in-context model** in exactly this shape, as bullets and
file:line anchors, never pasted file bodies:

1. **Verified stack** - One line per layer (language, runtime, framework,
   build tool), each citing the manifest or lockfile. If a layer cannot be
   verified, say so instead of guessing.
2. **Entry-point map** - Each entry point (CLI, server, worker, script,
   tests) as a path with a line reference and one line on what it does.
3. **One traced journey** - The most representative path a user or system
   takes: entry point, dispatch to core logic, storage or external call,
   response. Every hop carries a file:line reference.
4. **Exact run, test, and lint commands** - Each command cites the manifest
   script, Makefile, CI workflow, or README line that proves it exists.
5. **Conventions and gotchas** - Required env vars, config files, setup,
   extension points, and unusual patterns, each labeled documented or
   observed.
6. **Open questions** - Only what the code cannot answer, each with the
   evidence that made it ambiguous and the one probe that would resolve it.
7. **Context file (conditional)** - Only if the repo has a native ignored
   scratch area (a `tmp/` or `scratch/` directory, or an agent-owned temp
   directory) and a later session could reuse it: a file of no more than
   60 terse lines, refreshed on later sessions. Never write into tracked
   source, docs, or config.

## Method

Run the phases in order. Each has an exit condition; do not skip a phase to
save steps, and do not pad one with reads that close nothing.

1. **Skeleton from cheap signals** - Before opening any source file, form the
   shape of the repo from the cheapest evidence: the tree (two or three
   levels), git state, then manifests and configs (`package.json`,
   `pyproject.toml`, `Cargo.toml`, `go.mod`, `Gemfile`, `tsconfig`,
   `*.config.*`, `Makefile`), then CI workflows, then the README, which you
   treat as a hypothesis until proven. Read directories before files, and
   index files before the modules they point at. Exit: a hypothesis map with
   named entry points to verify, and no source read yet.
2. **Verify, narrow, batch** - Prove each hypothesis with a file you actually
   opened. Pull versions from lockfiles, never README prose. Find symbols with
   grep before opening whole files, and batch independent reads into a single
   parallel tool call. No more than five whole-file source reads before your
   first claim is verified; prefer partial reads and grep the rest. Exit: every
   claim has a citation or sits in open questions.
3. **Trace one journey** - Route through the framework's registration points
   (routes, handlers, commands, events) rather than trusting file names. Cite
   at least three hops that resolve when you re-open them. Exit: a path a user
   or system actually takes, end to end.
4. **Extract commands and conventions** - Derive run, test, and lint commands
   from the repo's own tooling and prove each in a manifest, Makefile, CI
   workflow, or README. Label conventions documented or observed. Exit: every
   command you report carries proof it exists.
5. **Compress the model** - Eliminate exploration that no longer earns its
   place, and keep the model under 100 terse lines at all times. Open
   questions stay; unconfirmed speculation does not. Exit: the model is the
   smallest set of confirmed claims that makes the next task faster.
6. **Prove it once, cheaply** - Execute the cheapest command that exercises
   the model: a build, the test suite, or a script you traced. If the output
   contradicts the model, correct the model and re-run. Exit: one real command
   has run and its output is logged in your context, not asserted.

## Verification

Before declaring the model complete, confirm each of these:

- [ ] The skeleton pass ran before the first source read.
- [ ] No more than five whole-file source reads preceded the first verified
      claim; the rest of the map came from grep and partial reads.
- [ ] Every stack, architecture, and entry-point claim points at a config,
      manifest, or source path you actually opened, and versions come from
      lockfiles.
- [ ] At least one journey is traced with at least three file:line hops that
      resolve.
- [ ] The run, test, and lint commands you report exist in the repo's own
      tooling, and you executed at least one of them with output recorded.
- [ ] The living model is under 100 terse lines, contains no pasted file
      bodies, and every convention claim is labeled documented or observed.
- [ ] No writes landed in tracked source, docs, or config; a context file was
      written only into a native ignored scratch area.
- [ ] Every open question names its evidence and the one probe that would
      resolve it.

## Rules

- Never ask the user. Infer from the repo; unresolvable ambiguity goes to open
  questions with the evidence attached.
- Spend tokens like they are billed: no lockfile dependency trees, generated
  output, or binary and media files unless a task needs them.
- A file:line anchor costs less than a pasted body: cite, never transcribe.
- Never claim a command ran unless you ran it and saw the output, and never
  cite a file you have not opened.
- Treat the README as a claim to verify, not a source of truth.
- Stop at diminishing returns: two consecutive targeted probes that add no new
  confirmed claim mean onboarding is done.
- The goal is not to understand everything; it is to be ready to act on
  evidence.
