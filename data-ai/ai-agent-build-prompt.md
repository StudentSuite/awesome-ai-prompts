# Reusable prompt: AI agent build [spec]

Copy-paste the block below into any AI coding agent to design and build an
LLM-powered agent for this project. The agent's behavior and decisions must
be verifiable against an eval set with measured cost and latency - not
judged by vibes.

Keywords: ai agent, tool calling, agent loop, orchestration, llm agent, guardrails

---

Build `[the agent's job in one sentence]` as an LLM agent: a loop that plans,
calls tools, observes results, and decides the next step until the task is
done or it is safe to stop. Deliver a harness with named tool contracts,
guardrails, an eval set, and a cost/latency budget - and prove each one
works.

## Define the scope first

1. **What the agent does** - The exact task and its boundaries: what the
   agent must decide, what it may never do, and when it is allowed to stop.
   Write the success and failure case in one line each.
2. **Who operates it and how** - Human-in-the-loop, autonomous inside a
   sandbox, or batch job? State which, because it changes the guardrails.
3. **What is out of scope** - Anything the agent must not attempt, and
   anything this pass will not build (logging, billing, UI).

## What to produce

1. **Tool contracts** - Every tool the agent may call, with its input/output
   schema and failure behavior. No tool without a schema; no schema without a
   test fixture. Cite the files that implement each tool.
2. **Context strategy** - What goes into the model context, what stays out,
   how history is trimmed, and how long a session can run. Explain the
   memory-vs-cost trade-off you chose.
3. **The agent loop** - The concrete cycle (plan -> act -> observe -> decide)
   with exit conditions: success, max steps, error budget, safety stop.
   State how a stuck or repeating loop is interrupted or recovered.
4. **Guardrails** - Hard limits on destructive actions, secret handling,
   external calls, and confirmation requirements. Each guardrail must map to
   a real enforcement point in code, cited. Every tool call and its result
   is written to an audit log, stored out of band, so behavior can be
   replayed and reviewed.
5. **Eval set** - At least ten golden tasks covering success cases, edge
   cases, and expected failures, each with a scored rubric (correct output,
   tool misuse, wasted steps, refusing when it should refuse).
6. **Budget and limits** - Measured numbers for cost per run, tokens, and
   latency p50/p95, with a stated target and a rule for when to stop
   spending.

## Method

1. **Read the existing AI code** - Find the project's current LLM usage
   (prompts, clients, evals, RAG). Build on it rather than inventing a
   parallel stack.
2. **Design contracts before code** - Write the tool schemas and eval rubrics
   first; implement against them.
3. **Build the loop thin** - Prefer a small core loop with strict tool
   interfaces over one mega-function. Compose, don't entangle.
4. **Protect before optimizing** - Guardrails and failure handling land
   before prompting tricks or caching.
5. **Run the evals and record** - Execute the golden set, capture pass/fail,
   steps used, tokens, and cost, and write the numbers into the deliverable.

## Verification

- [ ] Every tool has a schema, a fixture, and a cited implementation.
- [ ] Guardrails are exercised by evals that try to violate them, and the
      agent stops or refuses as specified.
- [ ] At least one long-running and one failure-prone scenario is in the eval
      set, with a scored result.
- [ ] Cost and latency are measured on a real run, not estimated.
- [ ] A safety stop fires when max steps or the error budget is hit, proven
      by a recorded run.
- [ ] The audit log captures every tool call and result for a full run, in
      order, and is stored outside the model's context.

## Rules

- No claim about agent behavior without an eval result to back it.
- Never let the agent call a tool that is not in the contract.
- Never spend more than the stated budget; when the budget is hit, stop and
  report.
- If a task cannot be made safely autonomous, say so and propose the
  human-in-the-loop change instead of shipping an unsafe loop.
