# Reusable prompt: threat modeling

Copy-paste the block below into any AI coding agent to threat-model a feature
or system before or while building it - structured, specific, and ranked by
real risk.

Keywords: threat model, attack surface, trust boundaries, abuse cases, assets, mitigations

---

Threat-model the specified feature or system in this repository. Produce a
ranked list of realistic threats with mitigations - not a generic checklist.

## Steps

1. **Diagram the trust boundaries** - Components, data flows, and every
   boundary where an attacker can inject influence (user input, third-party
   APIs, webhooks, file uploads, admin surfaces). Apply STRIDE per boundary:
   Spoofing, Tampering, Repudiation, Information disclosure, Denial of
   service, Elevation of privilege.
2. **Enumerate threats concretely** - For each element: what could an
   attacker with that vantage point do? Name the actor (anonymous user,
   authenticated peer, compromised dependency, insider) and the asset at
   risk. Vague threats ("input might be malicious") are rejected; specific
   ones ("the webhook endpoint accepts unsigned payloads, so anyone can forge
   events") are the goal.
3. **Rate realistically** - Impact times likelihood with a one-line
   justification each. Consider exploitability, not just severity if
   exploited.
4. **Mitigate in order** - For each accepted threat: the control (validation,
   signature verification, authz check, rate limit, encryption), where it
   lives in the code, and how to verify it works. Mark residual risk after
   mitigation.
5. **Turn top findings into work** - Concrete tasks and tests: the negative
   test that proves the control rejects the attack, and the regression that
   keeps it fixed.

## Output

A threat model table (threat, actor, asset, STRIDE category, risk,
mitigation, verification) plus the top three mitigations to implement first.

## Rules

- Ground every threat in the actual architecture - read the code, routes, and
  config first; flag assumptions explicitly.
- Do not implement mitigations unprompted; propose them.
- A security control without a verification step does not count as mitigated.
