# Reusable prompt: GraphQL API design

Copy-paste the block below into any AI coding agent to design a GraphQL schema
that scales past the demo: batching, field-level authorization, bounded
complexity, and resolvers that do not turn one query into fifty queries.

Keywords: graphql, schema, resolver, n plus 1, dataloader, query complexity, authz

---

Design the GraphQL API for `[feature or domain]` in this repository. The rule:
**the client drives the query shape, so the server must own the cost**. Design
schema-first, authorize per field, and make an expensive query fail on purpose
rather than in production.

## Steps

1. **Model from the domain, not the tables** - Write the SDL for the types this feature exposes, name fields for what the client needs, and keep mutations coarse-grained. Mark nullability deliberately: a non-null field that throws nulls out to its parent and can blank an entire response.
2. **Fix connection conventions first** - One pagination style everywhere, Relay cursor or a documented offset/limit. A bare `[Type]` with no arguments invites unbounded queries, so every list field takes `first`/`last` with a documented maximum.
3. **Plan N+1 before writing resolvers** - Mark every nested selection that crosses an object boundary, for example `Query.posts -> Post.author`. Each is a second query unless batched. Choose the strategy per boundary (request-scoped DataLoader, a joined SQL query) and write down why.
4. **Authorize per field, not per query** - Enforce access where the data resolves, since a top-level guard does not protect a nested field. Decide and document what a field does for a viewer without access: hide it, return null, or raise a typed error, and be consistent.
5. **Bound and standardize** - Set depth and field-count limits from what the app actually needs, not from the example query. Give errors a stable shape: a machine-readable `code`, a user-safe message, and a request id. State the evolution rule, additive by default, `@deprecated(reason:)`, with a sunset process.
6. **Verify against real queries** - Run a deep nested query, an unbounded list, a field the viewer must not see, and a mutation that fails halfway. Count the queries each one issues and show the numbers.

## Verification

- [ ] The SDL is pasted, and no database column or table shape is exposed as the schema.
- [ ] Every list field takes a maximum, so no query is unbounded.
- [ ] The batching strategy is written per nested boundary, and any unresolved N+1 is called out rather than shipped.
- [ ] Depth and complexity limits are set to concrete numbers, not left at a default.
- [ ] The four step 6 queries ran, with the measured query count for each shown.
- [ ] The unauthorized-field case returns the documented behavior instead of the data.

## Rules

- Never expose a database column or table shape as the schema. The schema is a
  contract, not a mirror.
- Never resolve a nested object field with a query per parent. If the N+1 is
  unresolved, say so in the design rather than shipping it.
- Never return an unbounded list. Every list field takes a maximum.
- Never rely on a top-level auth check to protect a nested field.
- Never ship without the depth and complexity limits set to concrete numbers.
