# Reusable prompt: internationalization (i18n)

Copy-paste the block below into any AI coding agent to internationalize an
app properly - strings extracted, formats localized, layouts resilient, RTL
handled.

Keywords: i18n, localization, translation, plural forms, right to left, strings, pseudo locale

---

Internationalize this application so adding a new language is a translation
task, not a code task. Extract everything locale-dependent; verify with a
pseudo-locale before writing real translations.

## Steps

1. **Extract user-facing strings** - Move every hardcoded string (UI labels,
   errors, emails, aria-labels, dates in templates) into message catalogs
   with stable keys that describe intent, not wording. No concatenating
   fragments across messages - full sentences per message with interpolation.
2. **Localize formatting, not just text** - Dates, times, numbers, currency,
   and percentages via the platform's Intl/i18n APIs; store timestamps in
   UTC and render local; use locale-aware collation for sorting and search.
3. **Handle plurals properly** - Use ICU plural/select syntax instead of
   adding an "s"; cover all plural forms the target languages need (many
   languages have more than one/other).
4. **Make layout resilient** - German and Finnish run ~35% longer; Thai has
   no spaces: no fixed widths on text containers, wrapping/ellipsis allowed,
   buttons sized by content. Mirror layout for RTL languages (logical CSS
   properties, direction-aware icons and arrows).
5. **Set up the plumbing** - Locale detection/negotiation (URL prefix or
   header/cookie per project convention), explicit locale switching, a
   fallback chain (region to base language to default), and HTML `lang`/`dir`
   attributes kept correct.
6. **Verify with pseudo-localization** - Render in a pseudo-locale (accented,
   ~40% longer text) to flush out truncation, overflow, missed extractions,
   and concatenation bugs. Then add one real translation and run the full
   flows in it.

## Rules

- Zero hardcoded user-facing strings may remain - grep to prove it.
- Never build sentences by concatenating translated fragments.
- Language names, dates, and numbers inside content count as strings:
  extract them too.
