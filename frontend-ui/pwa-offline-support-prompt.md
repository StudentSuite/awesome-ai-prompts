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

1. **Map every request the app makes** - The app shell, hashed JavaScript and
   CSS, images, fonts, and every API call, with which are safe to cache and
   which are per-user.
2. **Version the cache and the worker together** - One cache name per release,
   with the previous names listed and deleted on activate, so a new worker
   never mixes chunks from an old release.
3. **Give each resource type a strategy and a reason** - App shell and hashed
   assets cache-first; navigation requests get a cached shell fallback; API
   calls go network-first or stale-while-revalidate as appropriate.
4. **Design every offline state in the UI** - What the user sees for offline,
   slow, stale, and partial data, each with copy and a recovery path rather
   than an error toast.
5. **Queue mutations and decide the conflict rule** - Offline writes are queued
   with a client-generated id so retries are idempotent, and the conflict rule
   is written down before the first queued write ships.
6. **Test offline the way a user hits it** - A repeatable check that loads the
   app, then kills the network, then exercises navigation and a write.
7. **Run the audits** - Lighthouse PWA category, plus an audit for the failing
   offline case that must stay fixed.

## Verification

- [ ] Every cache name is versioned, and each version has a deletion path.
- [ ] No POST, partial response, or auth-varying response is ever written to a
      shared cache.
- [ ] Each offline, slow, stale, and partial state has designed copy and a
      recovery path.
- [ ] Queued writes carry a client id and the conflict policy is written down.
- [ ] The repeatable offline test runs: load, kill the network, then navigate
      and write.
- [ ] The Lighthouse PWA audit passes, and a cached shell never mixes releases.

## Rules

- Every cache name is versioned, and every version has a deletion path.
- No POST, no partial response, and no auth-varying response in a shared cache.
- Offline is a designed state with copy and a recovery path, not an error
  toast.
- Queued writes carry a client id and an explicit, written conflict policy.
- A cached shell never mixes with chunks from another release.
