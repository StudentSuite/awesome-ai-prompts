# Reusable prompt: frontend state management

Copy-paste the block below into any AI coding agent to untangle or design
client state - the right home for each kind of state, minimal moving parts,
no sync bugs.

Keywords: state management, store, client state, server state, global state, re-renders

---

Design or refactor the client-side state management for this frontend app.
The goal: each piece of state has exactly one home and one owner, derived
data is computed rather than stored, and no component syncs state by hand.

## Steps

1. **Inventory existing state** - Find all state: component-local, lifted or
   context-based, global stores, URL, server cache. For each: who reads it,
   who writes it, and does it duplicate something else?
2. **Classify by kind** - Server data (fetched, cacheable - belongs in a
   query/cache library or equivalent, not hand-rolled stores), URL state
   (filters, tabs, pagination - belongs in the URL so it's shareable), true
   client state (form drafts, UI toggles), and derived values (compute during
   render via selectors - never store).
3. **Assign one home each** - Move server state out of manual stores into the
   cache layer; push shareable view state into the URL; keep local UI state
   local until two distant components genuinely need it. Delete duplicated
   copies and their sync effects.
4. **Simplify the toolkit** - Prefer the fewest mechanisms that work:
   built-in primitives first, then a store library only for genuinely global
   client state. Removing a library is a valid outcome.
5. **Handle the edges** - Loading/error states per query, optimistic updates
   with rollback, races on rapid refetches (cancel or supersede stale
   responses), persistence where required.
6. **Verify by behavior** - Walk the critical flows (filter, fetch, paginate,
   edit, refresh): state survives reload where expected, no stale renders, no
   double fetches, no lost updates. Prove with tests on the trickiest flows.

## Rules

- Stored derived state is a defect waiting to desync - compute it instead.
- Two sources of truth for the same fact must be merged, or one deleted.
- Any state you add must answer: who owns it, who may write it, and when is
  it invalidated?
