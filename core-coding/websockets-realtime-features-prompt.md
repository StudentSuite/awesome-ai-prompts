# Reusable prompt: WebSockets and realtime features

Copy-paste the block below into any AI coding agent to build a realtime feature
that survives disconnects, reconnects, and horizontal scaling - with a message
contract, an explicit delivery guarantee, and a slow-client policy.

Keywords: websocket, realtime, heartbeat, reconnection, backpressure, fan-out

---

Build the realtime feature `[what: live dashboard / chat / notifications /
collaborative editing]` in this repository. The rule: **every connection is
temporary and every message can be lost or duplicated**. Own the lifecycle,
state the delivery guarantee in writing, and decide what happens to a client
that cannot keep up.

## Steps

1. **Choose the transport and say why** - Compare WebSockets, SSE, and long polling on direction, message size, and reconnect cost. A one-way notification stream does not need a bidirectional socket.
2. **Define the message contract** - Every message is a typed envelope with a name, version, correlation id, and payload schema, covering the error and close cases too. Publish the schema so client and server are checked against one source.
3. **Own the connection lifecycle** - Authenticate during the handshake, where it is still possible to reject. Heartbeat with a timeout that closes dead connections, and send a correct close code with a reason on clean shutdown.
4. **Make reconnect survivable** - Exponential backoff plus jitter, never a fixed interval that synchronizes every client into a thundering herd. Resume from a cursor or sequence number so the client detects and recovers the gap instead of continuing with stale state.
5. **State the delivery guarantee and fan out** - Write down at-most-once, at-least-once, or ordered-per-key and design to it; if duplicates are possible, give the consumer an idempotency key. With more than one instance, put a shared bus behind the socket layer, and record that pub/sub is at-most-once.
6. **Bound slow clients, then verify** - Bound the per-connection send buffer and pick one documented outcome when a client stalls: drop, coalesce, or disconnect with a reason code. Then run and paste a client that stops reading until the buffer fills, a mid-stream drop, a reconnect with messages produced while offline, two instances with the event raised on one, and a heartbeat timeout on a half-open connection.

## Verification

- [ ] The message schema is pasted, covering error and close cases as well as payload.
- [ ] Authentication happens in the handshake, before any message is accepted.
- [ ] Reconnect uses exponential backoff with jitter, and the resume strategy recovers the messages produced while the client was away.
- [ ] The delivery guarantee is written down and matches what the transport and backend actually provide.
- [ ] The send-buffer bound and the code path that enforces it are both shown.
- [ ] All five step 6 failure cases ran, with results pasted.

## Rules

- Never authenticate after the handshake accepts the connection.
- Never use a fixed reconnect interval, and never reconnect without jitter.
- Never claim a delivery guarantee you have not written down and designed for.
- Never let one slow client grow a send buffer without bound.
- Never assume a single server instance. If it will scale, wire the bus now.
