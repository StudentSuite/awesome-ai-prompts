# Reusable prompt: mobile app project setup [spec]

Copy-paste the block below into any AI coding agent to bootstrap a new mobile
app from an empty repository: an argued stack choice, a feature-based
structure, a typed navigation skeleton, and clean builds on iOS and Android.
Failure here is expensive, so the stack is decided before any code is written.

Keywords: mobile app setup, project scaffold, ios, android, app store, builds

---

Set up a new mobile app project here for `[what the app does and who it is
for]`. Argue the stack before generating the first file, and finish only when
both platforms build from a clean clone on CI. Infer every decision from the
repository and the scope you write first.

## Define the scope first

1. **The app and its users** - One sentence on what `[the app]` does and who
   it is for. If the sentence needs an "and", split it or cut it.
2. **Target platforms** - iOS, Android, or both, and the minimum OS version
   for each. Name the exact devices and OS versions you will verify against.
3. **The team's existing skills** - Languages and mobile frameworks the team
   already ships, and the hiring or maintenance constraint that matters.
4. **Out of scope** - Backend services this app calls, ongoing store review
   work beyond the listing basics, analytics, i18n, and platform-specific
   workarounds for any platform not named above.

Treat each as a decision you can revise, not a question for the user.

## What to produce

1. **Stack decision** - Native (Swift and Kotlin), React Native, or Flutter,
   chosen for this app and team. Carry the two strongest reasons against the
   choice and the condition that reverses it. Evidence: the rejected options.
2. **Project structure** - A feature-based layout, with the shared layer
   (types, API client, theme) separated from platform code, plus a rule for
   when sharing a module stops paying. Evidence: the folder tree and README.
3. **Navigation skeleton** - The real screen hierarchy with typed route
   parameters, a root navigator, defined back behavior on both platforms, and
   deep-link routing if any screen is shareable. Evidence: the route table and
   the parameter types, cited file:line.
4. **Clean-checkout build evidence** - Install, build, and launch iOS and
   Android from a fresh clone; log toolchain and SDK versions per platform.
5. **CI configuration** - A workflow that installs, builds, and tests both
   platforms on every push with pinned dependency and SDK versions, caching
   build directories but never the toolchain. Evidence: the workflow file and
   a green run URL.
6. **Device test plan** - The devices and OS versions to test on, and the
   simulator blind spots each check closes: safe area and notch, permission
   prompts, low memory, keyboard overlap, the back gesture, real signal.
   Evidence: a device-by-risk matrix.
7. **Store listing basics** - Bundle identifier and version-code rules that
   increase with every upload, the privacy manifest, permission usage strings,
   and icon and splash requirements per store. Evidence: a value checklist.

## Method

Run the phases in order; each has an exit condition.

1. **Inventory the environment first** - Record the SDKs, package managers,
   and target OS versions already installed, plus the team skills from scope.
   Exit: a shortlist with the constraint that eliminates each rejected stack.
2. **Decide the stack, then write the counter-case** - Choose, then state the
   two strongest reasons against it and the trigger to revisit. Exit: a
   decision that names what it is trading away.
3. **Bootstrap without a generator's assumptions** - Create the project, then
   check in SDK version pins, exact dependency versions, and both platforms'
   build settings and ignore files; delete sample content. Exit: a clean tree.
4. **Lay out by feature** - Build the shared layer and the feature folders,
   and document where sharing stops paying. Exit: the README layout paragraph
   matches the tree on disk.
5. **Wire the navigation skeleton** - Real screens with typed params, a root
   navigator, back behavior, and deep-link routes. Exit: every declared route
   resolves on both platforms.
6. **Prove a clean checkout builds** - Clone into a fresh directory, install,
   build, and launch both platforms, and log the output. Resolve the first
   failure. Exit: run logs from a clone with no prior state.
7. **Add CI and make it green** - Configure the workflow, pin versions, cache
   build directories, and get one passing run before continuing. Exit: a green
   run URL.
8. **Write the device and store plans** - Name the devices, the risks
   simulators miss, and the listing values. Exit: the matrix and checklist
   exist and the repo tracks no signing material.

## Verification

Before declaring setup complete, confirm each of these:

- [ ] The stack decision names the two strongest reasons against it and the
      condition that would reverse it.
- [ ] Both platforms build and launch from a fresh clone, proven by a run log
      naming the toolchain and SDK versions.
- [ ] The navigation skeleton routes are typed, and every declared deep link
      resolves on both platforms.
- [ ] The CI workflow pins dependency and SDK versions, builds both platforms,
      and its latest run is green with a URL recorded.
- [ ] The device test plan covers safe area and notch, permission prompts, low
      memory, keyboard overlap, and the back gesture.
- [ ] The bundle identifier and version rules are configured, permission usage
      strings and the privacy manifest are present, and every value is cited.
- [ ] No signing keys, keystores, or provisioning profiles are tracked.
- [ ] No generator sample content remains, and the README structure paragraph
      matches the tree on disk.

## Rules

- Never generate a project and stop before both platforms build.
- Never pick a stack without naming the strongest reasons against it.
- Never commit signing keys, keystores, or provisioning profiles.
- Never call simulator-only verification sufficient, or ship a platform you
  have not run.
- Never leave a generator's sample content in the repository.
- Never end setup with red CI; a broken first run moves the problem, it does
  not solve it.
