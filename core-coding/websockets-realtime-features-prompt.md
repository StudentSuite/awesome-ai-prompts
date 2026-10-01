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

1. **Choose the transport and say why** - Compare WebSockets, SSE, and long
   polling for this specific feature on three axes: direction (server to client
   or bidirectional), message size, and reconnect cost. Pick one and record the
   reason; a one-way notification stream does not need a bidirectional socket.
2. **Define the message contract** - Specify every message as a typed envelope
   with a name, a version, a correlation id, and a payload schema. Cover the
   error and close cases too. Publish the schema so client and server are
   checked against the same source rather than a comment.
3. **Handle the connection lifecycle** - Authenticate during the handshake (not
   in the first message, where it is already too late to reject), send
   heartbeats with a timeout that closes dead connections, and send a correct
   close code with a reason on a clean shutdown.
4. **Make reconnect survivable** - The client reconnects with exponential
   backoff plus jitter, not a fixed interval that synchronizes every client
   into a thundering herd. After reconnecting it resumes from a cursor, sequence
   number, or subscription request so it can detect and recover the gap rather
   than silently continuing with stale state.
5. **State the delivery guarantee explicitly** - Write down whether a message
   is at-most-once, at-least-once, or ordered-per-key, and design to that. If
   messages are duplicated, the consumer needs an idempotency key and dedupe.
   Do not promise ordering across keys unless the transport and backend actually
   provide it.
6. **Scale fan-out across instances** - When more than one server instance
   exists, a connection on instance A cannot see an event raised on instance B.
   Put a shared bus (Redis pub/sub, Postgres LISTEN/NOTIFY, or similar) behind
   the socket layer, and document that pub/sub delivery is at-most-once so you
   know what a dropped subscriber message means.
7. **Decide the slow-client policy** - Bound the per-connection send buffer.
   When a client cannot keep up, choose one documented outcome: drop, coalesce,
   or disconnect with a reason code. Show the queue bound you set and the code
   path that enforces it.
8. **Verify the failure modes** - Run and paste: a client that stops reading
   until the buffer fills, a mid-stream network drop, a reconnect with messages
   produced while offline, two instances with the event raised on one, and a
   heartbeat timeout on a half-open connection.

## Rules

- Never authenticate after the handshake accepts the connection.
- Never use a fixed reconnect interval, and never reconnect without jitter.
- Never claim a delivery guarantee you have not written down and designed for.
- Never let one slow client grow a send buffer without bound.
- Never assume a single server instance. If it will scale, wire the bus now.

## Verification

Paste the message schema, the reconnect parameters (max backoff, jitter, the
cursor strategy), the delivery guarantee statement, the send-buffer bound and
the code path that enforces it, and the results of every step 8 case. Confirm
the reconnect case recovers the messages produced while the client was away.
