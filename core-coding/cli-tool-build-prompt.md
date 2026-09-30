# Reusable prompt: CLI tool build

Copy-paste the block below into any AI coding agent to build a command-line
tool that behaves the way real CLI users expect: documented flags, typed
exit codes, safe pipe and TTY handling, and a logic core that is easy to
test without spawning subprocesses.

Keywords: cli, command line tool, terminal app, flags, subcommands, argument parsing

---

Build a command-line tool for `[what the tool does]` in this repository.
The goal: a CLI a seasoned user can run without surprises - correct exit
codes, a clean `--help`, sane behavior under pipes and scripts, and a test
suite that covers the logic directly.

## Steps

1. **Read the project's CLI conventions** - Check whether the repo already
   uses a CLI framework (argparse, click, cobra, commander, clap) and which
   entry points already exist. Mirror the existing style: how options are
   declared, how errors are printed, how the tool is installed and run.
2. **Design the interface first** - Write down the flags and arguments
   before coding: required vs optional, defaults, aliases, and conflict
   rules. Prefer a small surface and explicit flags over positional magic.
   There should be one obvious way to do each thing.
3. **Separate parse from run** - Structure the code as parse -> run -> render
   so the core logic lives in a plain function a test can call directly. The
   entry point is a thin wrapper: parse argv, call the function, print the
   result, map failures to exit codes.
4. **Be defensive about input** - Read stdin only when the interface says so;
   never block waiting on a pipe the user never opened. Handle missing files,
   invalid values, empty input, and non-UTF8 data with a clear user-facing
   message instead of a traceback.
5. **Make exit codes meaningful** - Exit 0 on success. Use a distinct
   non-zero code per failure class (usage, runtime, input) and document each.
   `--help` and `--version` exit 0; an unknown flag exits with the platform's
   usage-error code where one exists. Honor `SIGPIPE` so a closed pipe does
   not surface as an error.
6. **Respect TTY vs pipe** - Detect a TTY before printing colors, spinners,
   or progress bars, and degrade to plain text when stdout is not a terminal.
   Never write control characters or ANSI escapes into a piped stream.
7. **Verify** - Run the tool against real and edge inputs: empty stdin, very
   large input, invalid flags, missing arguments, unicode paths. Check that
   exit codes match the spec, `--help` renders correctly, and piping into
   another command terminates cleanly. Run the repo's test suite and
   linters.

## Verification

- [ ] Every exit code is documented and reachable from a test.
- [ ] Piping output into another command works and does not hang or error on
      a closed pipe.
- [ ] A bad flag or missing argument prints a usage message, never a traceback.
- [ ] The core logic is covered by tests that call the function directly, not
      only through subprocesses.

## Rules

- Never print a raw traceback to the user; format errors as `tool: message`.
- Never use global mutable state; keep the run function pure and injectable.
- Never add a flag you cannot document and test.
- Match the repo's existing CLI conventions over your preference.
