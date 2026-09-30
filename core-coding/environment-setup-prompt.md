# Reusable prompt: environment setup

Copy-paste the block below into any AI coding agent to bootstrap a development
environment from scratch - every dependency installed, every tool configured,
first build verified.

Keywords: environment setup, dev setup, local development, dependencies, bootstrap, toolchain

---

Set up a complete development environment for this repository from scratch.
The goal: a new contributor can clone the repo and be productive in minutes,
not hours.

## Steps

1. **Read the existing docs** - Check README.md, CONTRIBUTING.md, Makefile,
   docker-compose.yml, .tool-versions, .nvmrc, .python-version, or any
   setup-related files. Understand what the project expects before guessing.
2. **Install dependencies** - Run the actual install commands for the language
   runtime, package manager, and all dependencies. Use version managers (nvm,
   pyenv, rbenv, asdf) where the repo specifies them. Pin versions to match
   the repo's lockfiles.
3. **Configure tooling** - Set up linters, formatters, pre-commit hooks, and
   editor configs as the repo defines them. Verify each tool runs without
   errors.
4. **Set up services** - Start any required databases, caches, message brokers,
   or emulators (via docker-compose, local installs, or cloud sandboxes).
   Verify they accept connections.
5. **Build and run** - Execute the full build pipeline (compile, transpile,
   bundle). Run the application and confirm it starts without errors. Hit a
   health endpoint or open the UI to verify it works.
6. **Run the test suite** - Execute the full test suite. Fix any environment-
   related failures (missing env vars, wrong versions, unconfigured services).
   All tests should pass on a fresh setup.
7. **Document gaps** - If anything required manual intervention, undocumented
   steps, or workarounds, update the README or CONTRIBUTING with the fix.

## Rules

- Never skip steps or assume "the user will figure it out" - do every step
  end-to-end.
- Never install global packages that conflict with the repo's pinned versions.
- If the setup instructions in the README are wrong or incomplete, fix them
  rather than working around them.
- Verify every tool and service actually works, not just that it installed
  without error.
