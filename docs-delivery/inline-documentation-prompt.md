# Reusable prompt: inline documentation

Copy-paste the block below into any AI coding agent to add or improve inline
documentation - accurate JSDoc/docstrings that explain the "why", not ones
that restate the code.

Keywords: inline comments, docstrings, code comments, godoc, jsdoc, commenting style

---

Add or improve inline documentation (JSDoc, docstrings, comments) for
`[file / module / function]` in this repository. The goal: documentation that
helps a future developer understand the non-obvious decisions, not noise that
restates what the code already says.

## Steps

1. **Read the code first** - Understand what each function, class, and module
   actually does. Trace the logic, identify edge cases, and note any
   non-obvious behavior. Do not write docs from the function signature alone.
2. **Follow the repo's conventions** - Check the existing docstring/JSDoc style
   in the codebase: format (JSDoc, reST, Google, NumPy), level of detail,
   where they are used, and where they are omitted. Match the existing
   conventions exactly.
3. **Document what matters** - Add documentation to:
   - Public functions and classes that other developers will use
   - Non-obvious parameters (what are the valid values, what's the default
     behavior)
   - Return values that are not self-explanatory
   - Side effects, mutations, or state changes
   - Error conditions and when they are thrown
   - Comments explaining "why" when the code does something surprising
4. **Skip what's obvious** - Do not document: getters/setters that do exactly
   what their name says, trivial one-line functions, private helpers with
   clear names, or parameters whose types make their purpose obvious.
5. **Keep it concise** - One to three lines for most functions. A paragraph
   max for complex classes. Every sentence must add information the code
   doesn't already convey.
6. **Verify accuracy** - Read the docs you wrote against the actual code. If
   the docs describe behavior that doesn't match the implementation, fix the
   docs.

## Rules

- Never write docstrings that restate the function name or parameter names
  ("this function takes a name and returns a greeting").
- Never add documentation just to hit a coverage target - quality over
  quantity.
- Never use TODO comments in documentation - either write the doc or remove
  the placeholder.
- If the code is too complex to document concisely, the code may need
  refactoring rather than longer docs.
