# Reusable prompt: browser extension development [spec]

Copy-paste the block below into any AI coding agent to build or review a
Manifest V3 extension with justified permissions, clean context splits, and a
local iteration loop. Use the heavy format when a rejected review or a leaked
permission is expensive: store-bound extensions and anything touching user
pages or remote data.

Keywords: browser extension, manifest v3, content script, service worker, csp

---

Build or review `[what the extension does, in one sentence]` as a Manifest V3
extension for `[target browsers]`. Treat every permission, every entry point,
and every cached remote value as something a reviewer will interrogate. Return
a file tree, a manifest with written permission justifications, and the typed
message contracts between contexts.

## Define the scope first

State each decision in one line before touching the manifest or any context.
Treat them as decisions you can revise, not questions for the user.

1. **Browsers and surfaces** - Name the target browser or browsers and the
   exact surfaces in scope: popup, options page, content script, background
   service worker, devtools panel. State which surfaces are out of scope.
2. **Single purpose** - Write in one sentence what the user invokes the
   extension to do. If the sentence needs "and", split the scope or cut it.
3. **Inputs and outputs** - Inputs: the pages, origins, and messages the
   extension reads. Outputs: the storage schema, the message contracts, and
   the packaged artifact.
4. **Out of scope** - Native messaging, enterprise policy, cross-browser
   polyfills, and any remote backend this pass does not build.

## What to produce

1. **Manifest V3 with justified permissions** - Every `permissions` and
   `host_permissions` entry annotated with the code that reads it, the feature
   that breaks without it, and why the narrower form fails. This is the matrix
   a store reviewer checks.
2. **Context split** - A table putting each function in exactly one of:
   background service worker (long-lived state, network, alarms, no DOM),
   content script (reads and writes the page, per matched origin, isolated
   from page script), or UI surface (short-lived, talks only to the worker).
3. **Storage and messaging contracts** - The storage API per data class
   (`storage.local`, `storage.sync`, `storage.session`), one typed message
   union, one handler per context, and one schema migration function.
4. **CSP and no-remote-code statement** - Bundled code only: no `eval`, no
   `new Function`, no runtime-fetched script or wasm, no CDN import, and no
   inline handler. Cite the build step that inlines every dependency.
5. **Local iteration loop** - The exact steps to load the unpacked build,
   where the worker log and content-script errors surface, and how to inspect
   the injected script in the page's element panel.
6. **Store review checklist** - A privacy policy naming every field collected,
   a per-permission justification, a single purpose statement, an uninstall
   that deletes stored data, and icons and a description present.

## Method

1. **Inventory the extension or scaffold** - Read the manifest and existing
   contexts and list every permission with the file that uses it. Exit: a
   file:line map of permissions to code, before any new permission.
2. **Cut scope to one purpose** - Resolve the single purpose and delete
   anything that does not serve it. Exit: a one-sentence purpose and the
   out-of-scope list.
3. **Split the contexts** - Move each function into exactly one context and
   route cross-context calls through the worker. Exit: a context table with no
   function listed twice.
4. **Type the messaging** - Declare the discriminated union and a single
   handler per context, handling a sleeping worker, a closed page, and a
   content script that is not injected. Exit: every message has a type and a
   failure branch.
5. **Persist with the right API** - Choose `storage.local`, `storage.sync`, or
   `storage.session` per data class and add one migration function. Exit: one
   state owner, with no duplicate state in page local storage.
6. **Enforce the CSP** - Remove every remote or dynamic code path and prove
   the bundle builds offline. Exit: a build from a clean clone with no network
   fetch at runtime.
7. **Load unpacked and iterate** - Follow the developer-mode steps, reload the
   extension, and exercise one action per context while watching the console.
   Exit: a console log with no errors or warnings from the extension.
8. **Walk the review checklist** - Run the permission-removal pass and the
   store checklist. Exit: each item verified or explicitly listed as
   unverified.

## Verification

- [ ] The scope names the browser or browsers, every surface in scope, the
      single purpose, and the out-of-scope list.
- [ ] Every manifest permission has a written justification and a file:line
      that reads it; no broad host permission covers a narrower need.
- [ ] Each function lives in exactly one context, and the context table lists
      no function twice.
- [ ] All cross-context calls go through the worker and use the typed message
      union; a sleeping worker and a closed page are handled.
- [ ] Storage APIs match the data class, one migration function exists, and no
      page context holds durable state.
- [ ] The extension contains no `eval`, `new Function`, remote script, wasm, or
      inline handler, and it builds from a clean clone without a runtime fetch.
- [ ] The extension loads unpacked with no console errors in the worker, the
      content script, or a UI surface.
- [ ] A permission-removal pass removes each optional permission in turn and
      changes nothing user-visible; anything it breaks is listed.
- [ ] The store checklist covers the privacy policy, permission justification,
      single purpose, uninstall data deletion, icons, and description.
- [ ] Every checklist item not verified is named, with the reason.

## Rules

- No permission ships without a named feature and a written justification next
  to it; a wildcard host match is never the default.
- No remote code, no `eval`, no `new Function`, no inline script, no CDN
  import, and no build step that fetches at runtime.
- The worker owns long-lived truth; no state in a page context outlives the
  page.
- Every message is typed and fails without crashing the worker or leaving the
  UI waiting forever.
- Treat content read out of a page as untrusted input, never as data to act on
  without validation.
- Loading, testing, and packaging must work offline from a clean clone.
