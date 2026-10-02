# Reusable prompt: website to mobile app [spec]

Copy-paste the block below into any AI coding agent to turn an existing
website into a mobile app, picking the adaptation strategy from the website's
actual architecture rather than a preferred toolkit. The choice must be
justified against the site's code, and the result proven on a real device.

Keywords: web to mobile, wrap a website, app shell, pwa, hybrid app, webview

---

Turn `[the website]` into `[the mobile app]`. Decide the adaptation strategy
from the website's actual architecture, then build and verify the app on the
declared platforms. The strategy is a decision, not a default.

## Define the scope first

1. **Read the website's architecture** - Stack and framework, server-rendered
   vs client-rendered, auth and session handling, API surface and contracts,
   state management, and how the UI is styled. Cite what you found.
2. **Then choose the approach, and justify it for this codebase, not in
   general**:
   - **Thin wrapper** - a native shell (WebView) around the existing
     responsive web UI, fitting a site that is server-rendered or already a
     working PWA and whose priority is reach on the store shelves.
   - **Shared-logic re-implementation** (React Native, Flutter, or native)
     keeping the API and data contracts while rebuilding UI in platform
     components, fitting a site whose offline, performance, or platform-feel
     demands are core.
   - **Native from the start** - when offline-first, push, and sensors are
     hard requirements; say which requirement broke the cheaper options.
   - A rejected option names the concrete mismatch from the architecture you
     read, not taste.
3. **Also decide the delivery** - app store on both platforms, one platform,
   or web-only install. State it; it changes what must be proven.

## What to produce

1. **The strategy decision** - The approach, the delivery, and the rationale
   grounded in the architecture you read.
2. **The app** - The shell, navigation, screens, and state for the mobile
   experience, following the chosen approach and the project's conventions.
3. **Auth and session** - Sign-in flows that survive the app's offline and
   background life cycle, consistent with the site's existing auth.
4. **Online and offline behavior** - What works offline, what degrades, and
   how state resolves when connectivity returns.
5. **Platform verification matrix** - A table of the app per platform, device,
   and OS: launch, happy path, offline, background and resume, and any
   platform-specific quirks found.

## Method

1. **Read the site before choosing an approach** - The architecture pass comes
   before any decision, and the decision cites it.
2. **Reuse what the site already solves** - API contracts, auth, data models,
   and existing responsive layout (in a wrapper). Do not reimplement what
   already exists.
3. **Define the mobile behaviors** - Offline, background, permission, and deep
   link behavior, as the chosen approach handles them. State them.
4. **Build the smallest thing that proves the approach** - The shell and one
   core flow verified on a device first, then the rest.
5. **Verify on each platform** - For each declared platform, run the app on a
   real device or emulator: launch, happy path, offline, background and
   resume.

## Verification

- [ ] The strategy decision cites the website's actual architecture with
      evidence, not generalities.
- [ ] The app runs on every declared platform, with a run log naming the OS
      and device.
- [ ] A core flow works offline (or explicitly degrades) and recovers when
      connectivity returns.
- [ ] Auth and session behave consistently with the site and survive an app
      restart.
- [ ] No expensive reimplementation rests on taste alone; rejected options
      name the concrete mismatch.
- [ ] The test suite passes.

## Rules

- Never pick the strategy before reading the website's architecture.
- Never reimplement what the site already solves without saying what it buys
  you.
- Never ship a platform you have not run.
- Never claim "works just like the website" for behaviors you did not verify
  offline and after background.
