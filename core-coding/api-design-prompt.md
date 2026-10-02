# Reusable prompt: API design

Copy-paste the block below into any AI coding agent to design a well-structured
REST API - with conventions, validation, and an OpenAPI spec, not ad-hoc routes.

Keywords: api design, endpoints, contracts, versioning, interface design, resource naming

---

Design a REST API for `[feature / domain]`. The goal: a consistent, documented,
and validated API that other developers can understand and integrate with
confidently.

## Steps

1. **Understand the domain** - Read the existing codebase, data models, and any
   existing API routes. Identify the resources, their relationships, and the
   operations needed. Do not design in a vacuum - ground the API in what the
   code already does.
2. **Define resources and routes** - Use noun-based URLs for resources
   (`/users`, `/projects`), HTTP verbs for operations (GET, POST, PUT, PATCH,
   DELETE), and consistent nesting depth (max 2 levels). Follow the existing
   API conventions in the codebase.
3. **Design request/response schemas** - Define typed request bodies, query
   parameters, and response shapes. Use consistent error response formats
   across all endpoints. Include pagination for list endpoints.
4. **Add validation and error handling** - Specify input validation rules,
   meaningful error messages, and proper HTTP status codes. Document edge
   cases: what happens on conflict, not-found, or unauthorized.
5. **Write the OpenAPI spec** - Produce a valid OpenAPI 3.x YAML/JSON spec
   covering all endpoints, schemas, and error responses. Include examples for
   each endpoint.
6. **Verify** - Check the spec validates cleanly (use `swagger-cli validate` or
   equivalent). Confirm routes don't collide and naming is consistent
   throughout.

## Verification

- [ ] Every endpoint maps to real data or an operation that exists in the codebase; none were invented.
- [ ] URLs are noun-based, HTTP verbs carry the operation, and nesting stays at two levels or fewer.
- [ ] Pagination and the error response format are identical across every list endpoint.
- [ ] Each error case names its status code, with conflict, not-found, and unauthorized all covered.
- [ ] The spec validates cleanly with the repo's own validator, with the output shown.

## Rules

- Never invent endpoints that don't map to actual data or operations in the
  codebase.
- Never use verb-based URLs (e.g. `/getUser`) - use HTTP verbs instead.
- Keep the API consistent: if one list endpoint uses `?page=`, all should.
- If the codebase already has API conventions, follow them exactly - do not
  introduce a parallel style.
