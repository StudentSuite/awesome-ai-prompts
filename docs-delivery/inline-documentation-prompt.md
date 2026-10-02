# Reusable prompt: inline documentation

Copy-paste the block below into any AI coding agent to add or improve inline
documentation - accurate JSDoc/docstrings that explain the "why", not ones that
restate the code.

Keywords: inline comments, docstrings, code comments, godoc, jsdoc, commenting style

---

Add or improve inline documentation (JSDoc, docstrings, comments) for
`[file / module / function]` in this repository. The goal: documentation that
helps a future developer understand the non-obvious decisions, not noise that
restates what the code already says.

## Steps

1. **Read the code first** - Trace what each function, class, and module
   actually does; note edge cases and non-obvious behavior. Never document
   from the signature alone.
2. **Follow the repo's conventions** - Check the existing docstring style:
   format (JSDoc, reST, Google, NumPy), level of detail, and where docs are
   used or deliberately omitted. Match it exactly.
3. **Document what matters** - Public functions and classes, non-obvious
   parameters (valid values, default behavior), non-self-explanatory returns,
   side effects and mutations, error conditions and when they are thrown, and
   "why" comments where the code surprises.
4. **Skip the obvious** - No docs for trivial getters and setters, one-line
   functions, clear private helpers, or self-evident parameters.
5. **Keep it concise** - One to three lines for most functions, a paragraph
   max for complex classes. Every sentence must add what the code does not
   already convey.
6. **Verify accuracy** - Read each doc back against the code and fix anything
   that describes behavior the implementation does not have.

## Verification

- [ ] The repo's existing docstring or JSDoc style was matched, including its
      format.
- [ ] Every doc comment was read back against the code and is accurate as
      written.
- [ ] No docstring merely restates the function name, parameter names, or the
      obvious.
- [ ] Public API, non-obvious logic, and every failure mode are documented;
      trivial getters and setters are not.
- [ ] Comments stay concise, and no TODO was left in place of a written doc.

## Rules

- Never write docstrings that restate the function name or parameter names
  ("this function takes a name and returns a greeting").
- Never add documentation just to hit a coverage target - quality over
  quantity.
- Never use TODO comments in documentation - either write the doc or remove the
  placeholder.
- If the code is too complex to document concisely, the code may need
  refactoring rather than longer docs.
