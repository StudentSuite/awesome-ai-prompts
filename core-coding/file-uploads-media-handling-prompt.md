# Reusable prompt: file uploads and media handling [spec]

Copy-paste the block below into any AI coding agent to build an upload path
that survives hostile files, huge files, and hostile networks. Use this spec
when the upload surface is user-facing and reachable: validation, storage, and
scanning failures ship as incidents.

Keywords: file upload, multipart, storage, streaming, path traversal, resumable

---

Build the upload flow for `[feature: profile photos / attachments / video
uploads]` in this repository. The rule: **the client is untrusted and the
network is unreliable**. Validate everything server-side from the received
bytes, stream anything large, and never let a filename reach the filesystem
unchecked. Work only after scope is fixed, and produce the evidence below.

## Define the scope first

State each decision before writing code. Treat them as decisions you can
revise, not questions for the user.

1. **Feature and destination** - What is uploaded, where it is shown or served
   from, and who may download it. Name the route or entry point.
2. **Limits** - Maximum size per file, maximum count per request, accepted
   media types with their real signatures, and what happens at the boundary.
   State the smallest and largest file in scope.
3. **Storage backend** - Local disk, block store, or object storage; the
   bucket or root path; and how stored objects are addressed. Name the write
   and read paths.
4. **Out of scope** - List what this pass does not build (image transforms,
   CDN delivery, thumbnails, retention policy) and any upload path excluded
   from the pipeline.

## What to produce

1. **Validation contract** - A table of accepted types identified by magic
   bytes, the size cap, and the per-request count cap, with the file:line that
   enforces each. Type is decided by content, never by extension or the
   `Content-Type` header.
2. **Generated storage naming and traversal proof** - The naming rule (UUID or
   content hash plus a server-chosen extension) and the file:line that
   resolves the final path and asserts it stays inside the upload root.
   Deliver the log of a `../../etc/passwd` attempt being rejected.
3. **Streaming threshold decision** - The measured size boundary above which
   bytes stream to storage instead of buffering, with the memory numbers that
   justify it and the file:line that enforces the cap mid-stream.
4. **Scan pipeline and pending state** - The state a new file enters, the scan
   step that must pass before it becomes reachable, and the file:line that
   gates download on that state. Deliver the transition for pass and fail.
5. **Resumable upload protocol** - For large files, the part size, session
   identifier, and finish and abort calls, plus the session store schema. A
   failed part must not corrupt completed parts. Deliver the log of a resumed
   transfer.
6. **Adversarial test matrix** - A table of every case in Verification with the
   observed result and the log line that proves it.

## Method

Run the phases in order. Each has an exit condition; none may be skipped.

1. **Baseline memory and storage** - Measure or state the current upload
   path's peak memory and where files land today. This fixes the streaming
   threshold. Exit: recorded baseline numbers with file:line references.
2. **Write the contract first** - Lock types, size, count, naming, and storage
   backend before implementing. Exit: the validation table exists and every
   row has an enforcement point.
3. **Validate from bytes** - Enforce type by magic bytes and size from the
   stream, server-side. Exit: a renamed non-PNG is rejected with a named 4xx.
4. **Generate names and prove containment** - Never concatenate a client name
   into a path; resolve the final path and assert containment. Exit: the
   traversal case is logged as rejected.
5. **Stream above the threshold** - Wire streaming with a mid-stream size cap
   so an oversized upload aborts instead of filling a heap. Exit: an oversized
   stream aborts partway, logged.
6. **Scan behind a pending state** - Hold files pending until scanning passes
   and gate every download on the passed state. Exit: a pending file is
   unreachable and a failed scan is cleaned up.
7. **Add resumable upload for large files** - Implement parts, the session ID,
   finish, and abort, then resume an interrupted transfer. Exit: the resumed
   upload completes with intact parts.
8. **Run the adversarial matrix** - Execute every case in Verification and
   record results. Exit: the matrix is complete and every failure has a log.

## Verification

Run every case and attach the log. Confirm each box:

- [ ] A filename of `../../etc/passwd` is rejected and no file is written
      outside the upload root.
- [ ] An oversized stream is aborted mid-flight and leaves no partial file.
- [ ] A file whose bytes do not match its claimed type is rejected by magic
      bytes, not by extension or header.
- [ ] An empty file is handled by a stated rule (accepted or rejected) and
      never stored as a valid object.
- [ ] A duplicate name does not overwrite an existing object; generated names
      keep both.
- [ ] An interrupted chunked upload resumes from the last completed part and
      finishes without restarting.
- [ ] A cancelled upload leaves no partial file and its session is cleaned up.
- [ ] A file is unreachable until scanning passes its pending state.
- [ ] The streaming threshold and the containment check are each tied to a
      file:line and a run log.

## Rules

- Never trust `Content-Type`, the file extension, or the filename from the
  client; all three are attacker-controlled.
- Never concatenate a client-supplied name into a storage path when a
  generated name works, even after "sanitizing" it.
- Never buffer an arbitrarily large upload in memory, and never raise the size
  cap to make a test pass.
- Never expose an uploaded file before validation and scanning complete.
- Never ship an upload path without the traversal, oversized-stream, and wrong
  magic-byte cases running green.
- Never accept a traversal, streaming, or resume claim without the run log
  that proves it.
