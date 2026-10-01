# Reusable prompt: mobile app project setup

Copy-paste the block below into any AI coding agent to bootstrap a new mobile
app from an empty repository - with a justified stack choice, a runnable
navigation skeleton, and a clean iOS and Android build you can reproduce.

Keywords: mobile setup, project scaffold, ios, android, app store, builds

---

Set up a new mobile app project in this repository for `[what the app does and
who it is for]`. The rule: **the stack choice must be argued before the first
file is generated**, and the setup is not done until both platforms build from a
clean clone on CI.

## Steps

1. **Choose the stack and write down the tradeoffs** - Compare React Native,
   Flutter, and native Swift/Kotlin for this app specifically: does it need
   custom native modules, heavy animation, background work, or an existing team
   skill set? Weights like reuse of a web codebase and hiring pool count as
   reasons. Record the decision with the two strongest reasons against your
   choice, so the decision can be revisited when it turns out wrong.
2. **Bootstrap without a generator's assumptions** - Create the project, then
   immediately check in the config that matters: the SDK version pins, the
   package manifest with exact versions, the build settings for both
   platforms, and the ignore files. A generated project that will not build on
   a clean machine is not a setup.
3. **Establish the project structure** - Organize by feature rather than by
   platform, with the shared layer (types, API client, theme) clearly separated
   from platform-specific code. Explain the layout in the README so the next
   person does not reorganize it. State where a shared module stops being worth
   sharing.
4. **Build the navigation skeleton** - Wire the real screen hierarchy with
   typed route parameters, a root navigator, and the back behavior on both
   platforms. Deep linking is part of this step if the app has shareable
   screens, because retrofitting it means rewriting the navigator. No dead
   placeholder screens beyond what proves the flow works.
5. **Prove both platforms build from scratch** - Run the iOS and Android builds
   and the app on a simulator for each. Paste the output. Resolve the first
   failure rather than noting it as a known issue; a setup task that ends with
   a broken build has moved the problem, not solved it.
6. **Add CI builds** - Configure CI to install, build, and test both platforms
   on every push, with dependency and SDK versions pinned. Cache the build
   directories but never the toolchain version. A CI badge that is red on the
   first run is worse than no CI.
7. **Plan device testing, not just simulator testing** - Simulators do not
   reproduce real signal, real permissions, low memory, or a real keyboard.
   List the devices and OS versions to test on, and the specific risks (safe
   area, notch, permission prompts, keyboard overlap, back gesture) to check.
   Say how a physical device gets the build without a manual IDE ritual.
8. **Handle the store listing basics** - Set the bundle identifier and version
   code correctly and explain how they must increase with every upload, add the
   required privacy manifest and permission usage strings, and note the app icon
   and splash requirements per store. Note what signing needs that a public
   repo must never contain.

## Rules

- Never generate a project and stop before both platforms build.
- Never pick a stack without naming the strongest reasons against it.
- Never commit signing keys, keystores, or provisioning profiles.
- Never call simulator-only verification sufficient. Name the device risks you
  have not covered.
- Never leave a generator's sample content in the repository.

## Verification

Paste the stack decision with its tradeoffs, the folder layout, the iOS and
Android build output from a clean checkout, the CI run URL, and the device test
plan with its named risks. Confirm the version and bundle identifier setup and
that no signing material is tracked.
