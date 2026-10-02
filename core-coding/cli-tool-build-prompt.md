# Reusable prompt: CLI tool build

Copy-paste the block below into any AI coding agent to build a command-line
tool that behaves the way real CLI users expect: documented flags, typed exit
codes, safe pipe and TTY handling, and a logic core that is easy to test
without spawning subprocesses.

Keywords: cli, command line tool, terminal app, flags, subcommands, argument parsing

---

Build a command-line tool for `[what the tool does]` in this repository. The
goal: a CLI a seasoned user can run without surprises - correct exit codes, a
clean `--help`, sane behavior under pipes and scripts, and a test suite that
covers the logic directly.

## Steps

1. **Read the project's CLI conventions** - Check for an existing CLI framework
   (argparse, click, cobra, commander, clap) and entry points, and mirror how
   options are declared, errors printed, and the tool installed.
2. **Design the interface first** - Write down flags and arguments before
   coding: required vs optional, defaults, aliases, conflict rules. Prefer a
   small surface and explicit flags over positional magic, so each thing has
   one obvious way.
3. **Separate parse from run** - Structure as parse, run, render so the core
   logic lives in a plain function a test can call. The entry point is a thin
   wrapper that maps failures to exit codes.
4. **Be defensive about input** - Read stdin only when the interface says so,
   and never block on a pipe the user never opened. Handle missing files,
   invalid values, empty input, and non-UTF8 data with a clear message instead
   of a traceback.
5. **Make exit codes meaningful** - Exit 0 on success, a distinct non-zero code
   per failure class (usage, runtime, input), each documented. Honor `SIGPIPE`
   so a closed pipe does not surface as an error.
6. **Respect TTY vs pipe** - Detect a TTY before printing colors, spinners, or
   progress bars, and degrade to plain text otherwise. Never write control
   characters or ANSI escapes into a piped stream.
7. **Verify** - Run against real and edge inputs: empty stdin, large input,
   invalid flags, missing arguments, unicode paths. Confirm exit codes,
   `--help`, and clean piping into another command, then run the suite and
   linters.

## Verification

- [ ] Every exit code is documented and reachable from a test.
- [ ] Piping output into another command works and does not hang or error on a
      closed pipe.
- [ ] A bad flag or missing argument prints a usage message, never a traceback.
- [ ] The core logic is covered by tests that call the function directly, not
      only through subprocesses.

## Rules

- Never print a raw traceback to the user; format errors as `tool: message`.
- Never use global mutable state; keep the run function pure and injectable.
- Never add a flag you cannot document and test.
- Match the repo's existing CLI conventions over your preference.
