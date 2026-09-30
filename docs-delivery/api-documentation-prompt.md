# Reusable prompt: API documentation

Copy-paste the block below into any AI coding agent to generate accurate API
documentation from existing code - OpenAPI specs, endpoint references, or
SDK guides that match what the code actually does.

Keywords: api documentation, openapi, reference docs, endpoint docs, examples, reference

---

Generate API documentation for `[endpoint / route group / service]` in this
repository. The goal: docs that accurately describe the real API, not an
idealized version that doesn't match the code.

## Steps

1. **Read the actual code** - Trace each endpoint from route definition through
   handler logic to response. Identify the request shape (params, body,
   headers, query), the response shape (status codes, body schema, headers),
   and error cases. Do not infer from route names alone.
2. **Identify the output format** - Check what the repo already uses: OpenAPI
   YAML/JSON, Markdown endpoint docs, JSDoc/OpenAPI annotations, or none.
   Follow the existing format. If none exists, propose OpenAPI 3.x as the
   standard.
3. **Document each endpoint** - For every endpoint, capture: HTTP method and
   path, description, all parameters (path, query, header, body) with types
   and constraints, success response (status code + schema), error responses
   (status codes + when they occur), authentication requirements, and rate
   limits if applicable.
4. **Add examples** - Include realistic request and response examples for each
   endpoint. Use actual data shapes from the code, not placeholder values.
   Show both success and error examples.
5. **Verify accuracy** - Cross-check every documented parameter, response
   field, and status code against the actual code. Run the endpoint (or read
   the tests) to confirm the documented behavior matches reality.
6. **Integrate** - If the repo uses an API documentation site, ensure the new
   docs render correctly. If generating an OpenAPI spec, validate it with a
   spec validator.

## Rules

- Never document endpoints that don't exist in the code.
- Never document parameters or response fields that the code doesn't actually
  use or return.
- If the code handles an edge case (e.g. a specific error code), document it -
  don't omit it because it's uncommon.
- If the existing docs and the code disagree, the code wins and the docs
  need fixing.
