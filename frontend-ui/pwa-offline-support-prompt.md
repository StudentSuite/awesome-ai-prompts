# Reusable prompt: offline-first that survives a new deploy

Copy-paste the block below into any AI coding agent to add explicit
offline-first behavior: cache versioning that a redeploy invalidates cleanly, a
chosen strategy per resource type, replayed mutations, and an offline test that
actually runs.

Keywords: pwa, offline first, service worker, cache versioning, lighthouse

---

Add offline support to `[app name, stack]` serving `[routes or feature]`.
Offline-first means every state of the network has a defined answer, not that a
cache happens to exist. Produce the service worker, the per-resource strategy
table, the queued mutation path with its conflict rule, and the offline test.

## Steps

1. **Map every request the app makes** - List the app shell, hashed JavaScript
   and CSS, images, fonts, and each API call. Tag each with how stale it may be
   served and whether serving it offline is safe at all.
2. **Version the caches and the worker together** - One cache name per release
   derived from a version string, plus an activate handler that deletes every
   cache whose name does not match the current version. Bump the version in the
   same commit as any change to the precache list, or old assets outlive the
   deploy that made them unreachable.
3. **Give each resource type a strategy and a reason** - App shell and hashed
   assets: precache on install, serve cache-first. Images and fonts:
   stale-while-revalidate, serve immediately, refresh in the background. API
   reads: network-first with a cached body and an explicit stale flag. Never
   cache anything that is not a GET, and never share a cache entry across
   differing authorization headers.
4. **Design every offline state in the UI** - Define what the user sees for
   first load with no cache, for cached data with the network down, and for a
   pending write. Each state needs its own component and copy. A spinner that
   never resolves is a defect, not a loading state.
5. **Queue mutations and decide the conflict rule** - Writes made offline go
   to an append-only queue in IndexedDB with a client-generated id and a
   timestamp. Replay on reconnect with backoff, and write down what happens on a
   conflict: discard, take the server value, or prompt for a merge. Surface
   that outcome in the UI rather than swallowing it.
6. **Update in place, never half** - Let a new worker take over as soon as it is
   installed, waiting only for a client that is mid-transaction. When a waiting
   worker exists, tell the app to prompt a reload instead of serving old HTML
   with new chunks. A shell and its assets must come from the same release.
7. **Test offline the way a user hits it** - Add a repeatable check that loads
   the app, cuts the network, and walks every route plus every mutation path,
   and a second case that flips a deploy mid-session. Run it headlessly in CI.
   A checklist in a document is not a test.
8. **Run the audits** - Lighthouse PWA category, an audit for a failing offline
   start URL, and a pass over the cache list looking for a version nothing ever
   deletes. Report the scores and the offline run output as they are.

## Rules

- Every cache name is versioned, and every version has a deletion path.
- No POST, no partial response, and no auth-varying response in a shared cache.
- Offline is a designed state with copy and a recovery path, not an error toast.
- Queued writes carry a client id and an explicit, written conflict policy.
- A cached shell never mixes with chunks from another release.

## Verification

Paste the strategy table with one row per resource type, the cache names plus
the version bump and the activate-time deletion logic, the headless offline run
showing every route rendered and every queued write replayed, and the Lighthouse
PWA scores before and after.
