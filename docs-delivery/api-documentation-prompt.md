# Reusable prompt: API documentation

Copy-paste the block below into any AI coding agent to generate accurate API
documentation from existing code - OpenAPI specs, endpoint references, or SDK
guides that match what the code actually does.

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
   Follow the existing format; if none exists, propose OpenAPI 3.x.
3. **Document each endpoint** - Method and path, description, every parameter
   (path, query, header, body) with types and constraints, the success
   response, each error response with when it occurs, authentication
   requirements, and rate limits where applicable.
4. **Add examples** - Realistic request and response examples per endpoint,
   using data shapes from the code rather than placeholder values, for both
   success and error cases.
5. **Verify accuracy and integrate** - Cross-check every documented parameter,
   response field, and status code against the code, running the endpoint or
   reading its tests. Confirm the docs render in whatever site or generator the
   repo uses, and validate a generated spec.

## Verification

- [ ] Every documented endpoint was traced from route definition through
      handler, so none is invented.
- [ ] Every parameter, response field, and status code was cross-checked
      against the code that produces it.
- [ ] Each endpoint has realistic request and response examples, taken from
      actual output where possible.
- [ ] Error cases the code handles, including specific error codes, are
      documented.
- [ ] The docs were generated or validated with whatever tool the repo already
      uses, and the output is clean.
- [ ] Where docs and code disagreed, the code won and the docs were corrected.

## Rules

- Never document endpoints that don't exist in the code.
- Never document parameters or response fields that the code doesn't actually
  use or return.
- If the code handles an edge case (e.g. a specific error code), document it -
  don't omit it because it's uncommon.
- If the existing docs and the code disagree, the code wins and the docs need
  fixing.
