# Data & AI

Prompts for data and AI work: pipelines, slow queries, retrieval, model evaluation, and agents.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#data--ai) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#data--ai) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [data-pipeline-prompt.md](data-pipeline-prompt.md) - build ETL pipelines that fail loudly, resume cleanly, and prove their output.
- [sql-query-optimization-prompt.md](sql-query-optimization-prompt.md) - make slow queries fast with plans before/after and justified indexes.
- [rag-pipeline-prompt.md](rag-pipeline-prompt.md) - build retrieval-augmented generation with citations and eval numbers before shipping.
- [llm-feature-eval-prompt.md](llm-feature-eval-prompt.md) - evaluate LLM features with a held-out test set and pre-committed thresholds.
- [ai-agent-build-prompt.md](ai-agent-build-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - design and build an LLM agent: tool contracts, context strategy, guardrails, eval set, cost and latency budget.
- [csv-spreadsheet-wrangling-prompt.md](csv-spreadsheet-wrangling-prompt.md) - clean messy CSV/spreadsheet exports with encoding detection, explicit type overrides, and a validation report.
- [responsible-web-scraping-prompt.md](responsible-web-scraping-prompt.md) - scrape within robots.txt/ToS with resilient selectors, checkpointed crawls, and politeness budgets.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
