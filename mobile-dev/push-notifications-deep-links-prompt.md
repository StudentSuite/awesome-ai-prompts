# Reusable prompt: mobile notifications and deep links

Implement push notifications and deep-link handling safely: permissions, state, deep-link routing, and verification on both platforms.

---

You are adding push notifications or deep-link support to a mobile app. Work with platform verification.

1. Confirm the mechanism - Read the current architecture; decide local vs remote push, universal links vs URL schemes.
2. Handle permissions - Confirm the app requests and respects notification permissions; do not assume granted.
3. Build routing - Map deep-link paths to screens with a clear routing table; reference file:line.
4. Handle state - Confirm the app opens correctly from killed, background, and foreground states.
5. Verify both platforms - Confirm behavior on iOS and Android, not just one; reference the verification matrix.
6. Test with real links - Confirm the link works from an actual message/email, not just the simulator.

Rules:
- Never hardcode deep-link paths in view files; use a routing layer.
- Confirm permissions are requested before any notification is shown.
- Use ASCII hyphens only; no em dashes anywhere.

Verification:
- Test on device from a real notification and a real deep link.
- Confirm the routing table covers all intended paths.
