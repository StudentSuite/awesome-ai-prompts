# Reusable prompt: browser extensions that survive review

Copy-paste the block below into any AI coding agent to build or review a
Manifest V3 extension with justified permissions, a clear split between the
background service worker, content scripts, and UI surfaces, and a local
iteration loop.

Keywords: browser extension, manifest v3, content script, storage, csp

---

Build or review `[what the extension does, in one sentence]` as a Manifest V3
extension for `[target browsers]`. Treat every permission, every entry point,
and every cached remote value as something a reviewer will interrogate. Return
a file tree, a manifest with written permission justifications, and the message
contracts between contexts.

## Steps

1. **Fix the single purpose** - State in one sentence what the user invokes
   the extension for. If the answer needs the word "and", split it or cut scope.
   One purpose is a store requirement, not a style preference, and it is what
   makes a permission list defensible.
2. **Draft the manifest and justify each permission** - For every entry under
   `permissions` and `host_permissions`, write one line: what code reads it,
   which feature breaks without it, and why the narrower form does not work.
   Prefer a request-time optional permission over a required one, and a single
   origin over a wildcard host match.
3. **Split the three contexts by purpose** - Background service worker: long
   lived state, network calls, alarms, no DOM. Content scripts: read and write
   the page, injected per matched origin, isolated from page JavaScript. Popup
   and options pages: short lived UI that talks to the worker and never to a
   content script directly. Put each function in exactly one place and say why.
4. **Type the messaging** - Declare message types as one discriminated union
   with a single handler per context, and route everything through the worker so
   there is one place that knows the truth. Handle the worker being asleep, the
   page being closed mid-request, and a content script that is not injected.
5. **Persist state deliberately** - Pick `storage.local` for real data,
   `storage.sync` only for small preferences inside the quota, and
   `storage.session` for per-tab scratch. Version the schema with one migration
   function. Do not keep a second copy of state in the page's local storage
   just to dodge the bridge.
6. **Stay inside the content security policy** - Bundled code only. No `eval`,
   no `new Function`, no runtime-fetched scripts or wasm, no CDN imports, no
   inline handlers. When something is blocked, the fix is a bundling change or
   a message round trip, never a policy exception.
7. **Load it unpacked and iterate** - Give the exact steps: developer mode on
   the extensions page, "Load unpacked" pointed at the build output directory,
   where the worker log and content script errors surface, and how to inspect
   the injected script in the page's elements panel.
8. **Walk the review checklist** - Single purpose, a privacy policy that names
   every field collected, permission justifications that survive scrutiny, no
   remote code, uninstall that deletes stored data, icons and a description
   present. List anything you could not verify.

## Rules

- No permission ships without a named feature and a written justification next
  to it in the manifest or its docs.
- No remote code, no eval, no inline script, no CDN import, no build step that
  fetches anything at runtime.
- Every message is typed, versioned where the shape can change, and fails
  without crashing the worker or leaving the UI waiting forever.
- The worker owns long lived truth; no state in a page context outlives the
  page.
- Loading, testing, and packaging must work offline from a clean clone.

## Verification

Paste the manifest with each permission annotated by the feature that needs it,
the message type union, the unpacked-load steps you actually followed, and the
console output from exercising the extension once in each of the three
contexts. State which checklist items you could not verify.
