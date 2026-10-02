# Reusable prompt: RAG pipeline

Copy-paste the block below into any AI coding agent to build a
retrieval-augmented generation pipeline with evaluation built in - so answers
are grounded, cited, and measurably better than raw prompting.

Keywords: rag, retrieval, vector search, embeddings, chunking, context, semantic search

---

Build the requested retrieval-augmented generation (RAG) feature. The bar:
answers must be grounded in retrieved sources with citations, and quality must
be evaluated against a test set, not vibes.

## Steps

1. **Scope the corpus** - What documents, formats, languages, update frequency,
   size? Confirm you can parse them reliably (encoding, layout, tables) before
   designing anything downstream.
2. **Chunk deliberately** - Chunk by document structure (headings, paragraphs)
   rather than blind character splits; preserve titles and section paths as
   metadata; overlap only if evaluation shows it helps.
3. **Index with metadata** - Embeddings plus the metadata needed for filtering
   (source, date, permissions). Pick the simplest store that meets scale - do
   not reach for a dedicated vector database before a plain
   Postgres/pgvector-style setup proves insufficient.
4. **Retrieve well** - Start with hybrid retrieval (keyword + vector) if the
   corpus has proper nouns or IDs; rank and cap the context; apply permission
   filters at query time, not just ingest time.
5. **Generate with grounding rules** - The prompt must require: answer only
   from provided context, cite sources inline, say "I don't know" when context
   is insufficient. Never let the model silently fill gaps from its own memory.
6. **Evaluate before shipping** - Build a golden set of question/expected-
   source pairs (20+ to start). Measure retrieval hit rate and answer
   faithfulness; iterate chunking and retrieval against these numbers.
7. **Harden operations** - Track cost and latency per query, cache frequent
   retrievals, plan re-indexing for corpus updates, and log queries with
   citations for debugging.

## Verification

- [ ] Chunking follows document structure and preserves the title and section
      path as metadata.
- [ ] Retrieval numbers are reported on the golden set: hit rate and answer
      faithfulness.
- [ ] Permission filters are applied at query time, not only at ingest time.
- [ ] The prompt forbids answering from model memory and requires inline
      citations plus an explicit refusal when context is insufficient.
- [ ] Every answer traces to cited chunks; any uncited claim was treated as a
      defect.

## Rules

- No shipping without eval numbers on the golden set; report them.
- Permission checks happen at retrieval time - filtered search alone is not
  authorization.
- Every answer must trace to cited chunks; uncited claims are defects.
