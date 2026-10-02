# Reusable prompt: mobile notifications and deep links

Copy-paste the block below into any AI coding agent to add push notifications or
deep-link handling to a mobile app: permissions, a single routing layer, and
verification on both platforms in every app state.

Keywords: mobile, push-notifications, deep-links, permissions, routing, verification

---

Add `[push notifications / deep-link routing / both]` to the mobile app in this
repository. Work from platform verification: every path is exercised on a real
device, not inferred from the simulator.

## Steps

1. **Confirm the mechanism** - Read the current app architecture, then decide
   local versus remote push and universal links versus URL schemes. Record the
   decision and the reason for it.
2. **Handle permissions** - Confirm the app requests notification permission at
   the right moment and handles denial. Never assume the grant.
3. **Build a routing layer** - Map every deep-link path to its screen in one
   place, with a path-to-destination table, and reference the file:line.
4. **Handle every app state** - Confirm the link resolves from killed,
   background, and foreground, and that the screen receives the right
   parameters in each case.
5. **Verify on both platforms** - Check the behavior on iOS and Android rather
   than one. Record a verification matrix of state by platform.
6. **Test with real links** - Tap an actual push notification and an actual
   email or message link, not a URL typed into the simulator.

## Verification

- [ ] A real notification tap opens the correct screen on a physical device.
- [ ] A real deep link from a message or email resolves on both platforms.
- [ ] The routing table covers every intended path with a file:line.
- [ ] Killed, background, and foreground launches were each tested.
- [ ] Permission denial was tested and leaves the app usable, not blocked.

## Rules

- Never hardcode a deep-link path in a view file; route through the single
  routing layer.
- Never show a notification before permission is requested and granted.
- Never verify on one platform and report the result as cross-platform.
- If an app state cannot be reproduced locally, say so instead of marking it
  verified.
