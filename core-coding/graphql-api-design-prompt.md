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

1. **Model the schema from the domain, not the tables** - Write the SDL for
   the types this feature exposes. Name fields for what the client needs, keep
   mutations coarse-grained (one mutation, one business operation), and mark
   every field nullable or non-null deliberately: a non-null field that throws
   nulls out to its parent, so a resolver failure can blank an entire response.
2. **Decide connection conventions up front** - Pick one pagination style
   (Relay connections with cursor, or a documented offset/limit) and apply it to
   every list field. A bare `[Type]` with no arguments invites unbounded
   queries; require a `first`/`last` bound with a documented maximum on each.
3. **Plan for N+1 before writing resolvers** - Walk the schema and mark every
   nested selection that crosses an object boundary, for example
   `Query.posts -> Post.author`. Each is a second query unless batched. Choose
   the batching strategy per boundary (DataLoader-style request-scoped
   batching, a joined SQL query, or a single dataloader that accepts IDs) and
   write down why.
4. **Authorize at field and object level** - Decide, per field, whether access
   depends on the viewer. Enforce it where the data is resolved, not in a
   top-level guard that a nested field can bypass. Decide and document what a
   field does when the viewer lacks access: hide it, return null, or raise a
   typed error, and be consistent about it.
5. **Bound what a client can ask for** - Add query depth limits, field-count or
   complexity limits, and disable introspection in production if that matches
   policy. Set the numbers from what the app actually needs, not from the
   example query.
6. **Standardize errors** - Give errors a stable shape (an `errors` array with
   a machine-readable `code`, a message safe to show a user, and a request
   identifier for logs). Never leak stack traces, SQL, or internal type names.
   Decide how partial success is signalled.
7. **Define the evolution rules** - State how the schema changes without
   breaking clients: additive-only by default, deprecation via
   `@deprecated(reason:)`, and a stated sunset process. This is what stops the
   API becoming the thing that blocks every other change.
8. **Verify against real queries** - Write and run the queries that break
   designs: a deep nested query, a list without arguments, a query for a field
   the viewer must not see, and a mutation that fails halfway. Count the
   database queries each one actually issues and show the numbers.

## Rules

- Never expose a database column or table shape as the schema. The schema is a
  contract, not a mirror.
- Never resolve a nested object field with a query per parent. If the N+1 is
  unresolved, say so in the design rather than shipping it.
- Never return an unbounded list. Every list field takes a maximum.
- Never rely on a top-level auth check to protect a nested field.
- Never ship without the depth and complexity limits set to concrete numbers.

## Verification

Paste the SDL, the batching plan per nested boundary, the depth and complexity
limits, and the query counts measured for each case in step 8. Confirm the
unauthorized-field case returns the documented behavior rather than the data.
