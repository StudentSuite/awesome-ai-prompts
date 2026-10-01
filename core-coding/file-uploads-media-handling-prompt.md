# Reusable prompt: file uploads and media handling

Copy-paste the block below into any AI coding agent to build an upload path that
survives hostile files, huge files, and hostile networks - with validation,
storage, and progress you can actually verify.

Keywords: file upload, multipart, storage, streaming, path traversal, resumable

---

Build the upload flow for `[feature: profile photos / attachments / video
uploads]` in this repository. The rule: **the client is untrusted and the
network is unreliable**. Validate everything server-side, stream anything large,
and never let a filename reach the filesystem unchecked.

## Steps

1. **Fix the contract first** - State the accepted types with real MIME types
   (not extensions), the maximum size, the maximum count per request, and where
   files land after upload. Write these down before writing code; they become
   the validation layer in step 2.
2. **Validate server-side, always** - Enforce type and size on the server from
   the received bytes, not from the client header or filename. A `.png` that
   starts with a zip header is not a PNG: sniff magic bytes or run a real
   decode. Reject with a clear 4xx and a named reason rather than a generic
   failure.
3. **Never trust the filename for storage** - Generate the stored name yourself
   (UUID or content hash plus a server-chosen extension). Reject or strip any
   name containing `/`, `\`, `..`, a null byte, or a leading dot. Resolve the
   final path and assert it is still inside the upload root before writing;
   a traversal check on the input string alone is not enough.
4. **Stream instead of buffering** - Above a few megabytes, write to disk or
   object storage as bytes arrive rather than holding the whole file in memory.
   Enforce the size cap while streaming so an oversized upload is aborted
   instead of consuming a heap. Show the threshold you picked and why.
5. **Scan before it becomes reachable** - Run malware scanning or content
   validation as a distinct step, and hold new uploads in a pending state until
   it passes. A file that is downloadable before the scan finishes is a file
   that was never scanned.
6. **Make large uploads resumable** - For uploads above a few tens of
   megabytes, support chunked or multipart upload with a part size, a resumable
   session identifier, and a way to finish an interrupted transfer without
   restarting. Aborting a failed part must not corrupt the completed ones.
7. **Give the user honest progress** - Report bytes sent, not a fake
   indeterminate spinner. Support cancel, and define what happens server-side
   to a half-finished upload (expiry plus cleanup).
8. **Verify it end to end** - Write the adversarial cases and run them: wrong
   magic bytes, oversized stream aborted mid-flight, `../../etc/passwd` as the
   filename, an empty file, a duplicate name, an interrupted chunked upload
   resumed successfully, and a cancelled upload leaving nothing behind.

## Rules

- Never trust `Content-Type`, the file extension, or the filename from the
  client. All three are attacker-controlled.
- Never concatenate a user-supplied name into a storage path, even after
  "sanitizing" it, when a generated name works.
- Never buffer an arbitrarily large upload in memory, and never raise the size
  cap to make a test pass.
- Never expose an uploaded file before validation and scanning complete.
- No upload path ships without the traversal and oversized-stream tests in
  step 8 running green.

## Verification

Paste the output of the step 8 test run (each case and its result), the chosen
size threshold and streaming strategy, and the exact check that a resolved
storage path stays inside the upload root. Confirm no partially written file is
reachable after a cancel or a failed scan.
