# Reusable prompt: internationalization (i18n)

Copy-paste the block below into any AI coding agent to internationalize an app
properly - strings extracted, formats localized, layouts resilient, RTL
handled.

Keywords: i18n, localization, translation, plural forms, right to left, strings, pseudo locale

---

Internationalize this application so adding a new language is a translation
task, not a code task. Extract everything locale-dependent; verify with a
pseudo-locale before writing real translations.

## Steps

1. **Extract every user-facing string** - Move hardcoded UI labels, error
   messages, dates, and numbers into the message catalog. Language names,
   dates, and numbers inside content count as strings.
2. **Localize formatting, not just text** - Dates, times, numbers, currency,
   names, and addresses go through the platform's formatter and the correct
   locale, never hand-assembled from a template.
3. **Handle plurals properly** - Use ICU plural and select syntax so the target
   language chooses the right form. Concatenating translated fragments produces
   broken sentences wherever word order differs.
4. **Make layout resilient** - German and Finnish run roughly 35% longer than
   English, and some scripts need more vertical space. Design for expansion
   rather than the shortest language.
5. **Set up the plumbing** - Locale detection and negotiation (URL prefix or
   `Accept-Language`), fallback chain, and per-locale formatting defaults.
6. **Verify with pseudo-localization** - Render in a pseudo-locale with
   accented and expanded characters, and in the longest supported language.
   This surfaces untranslated strings and clipping that a locale you speak will
   not reveal.

## Verification

- [ ] A grep for hardcoded user-facing strings comes back empty.
- [ ] No sentence is built by concatenating translated fragments; plurals use
      ICU syntax.
- [ ] Dates, times, numbers, currency, and names go through the platform
      formatter with the correct locale.
- [ ] The longest supported language was rendered and nothing clips or
      truncates.
- [ ] The fallback chain and locale negotiation were exercised, including an
      unknown locale.
- [ ] A pseudo-locale render was checked for untranslated strings and overflow.

## Rules

- Zero hardcoded user-facing strings may remain - grep to prove it.
- Never build sentences by concatenating translated fragments.
- Language names, dates, and numbers inside content count as strings: extract
  them too.
