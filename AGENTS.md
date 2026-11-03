# Crystal Columns - Agent Instructions

## Scope and project context

- Repository: `ChristianEngel19820128/Crystals`.
- Project: Crystal Columns (repository name: Crystals), developed with AppGameKit Studio.
- Use `README.md` and the current source code as primary evidence. Do not assume undocumented behavior is a defect.
- These instructions apply to code analysis, reviews, and coding-agent tasks that load this file.

## Default mode: read-only investigation

**The default authorization is analysis only.** A bug report, review request, suggested fix, or automatically prepared task is **not** permission to change code.

Unless the repository owner explicitly authorizes a specific implementation task:

- Do not edit, create, delete, format, or rename repository files.
- Do not generate or apply patches or diffs intended as implementation artifacts.
- Do not create commits, branches, pull requests, issues, releases, or tags.
- Do not run commands that alter repository state, dependencies, configuration, or remote services.
- Do not automatically fix a reported problem, even if the fix seems obvious.
- Explain potential corrections in prose only and await explicit approval.

If a task asks for a fix without clear owner authorization, report the finding and ask for approval before implementation. Higher-priority platform instructions may supersede this file; it is not a technical permission boundary.

## Review method

1. Read the relevant code and trace the affected execution path.
2. Distinguish observed behavior, source-code evidence, and hypotheses.
3. Compare findings against intended behavior documented in `README.md` and the code.
4. Identify file paths, functions, line numbers, and commit SHA when verifiable.
5. Provide concrete reproduction steps or a proposed verification test; do not claim tests were run unless they were actually executed.
6. Assess user impact and severity; mention uncertainty and missing information.
7. Check for duplicates against the available central bug register, if accessible. Do not invent register contents or IDs.
8. Describe a minimal, behavior-preserving correction without implementing it.

## Game behavior to preserve

The README describes these intended mechanics:

- Matching three or more crystals of the same color horizontally, vertically, or diagonally clears them.
- Cascades increase scoring.
- The game ends when crystals reach the top or a new falling block cannot enter.
- Random crystals rise from the bottom every tenth level.
- Rainbow crystals act as wildcards; Magic crystals remove crystals of the color they land on.
- Keyboard and gamepad controls, menu flow, and difficulty selection must be considered before labeling behavior defective.

Treat these as documented expectations, not proof that the implementation is correct. Verify exact edge cases in source code.

## Bug reporting format

Write reports in German. For each distinct finding include:

- **ID:** Use an existing `CC-###` ID only when confirmed from the central register; otherwise write `Noch nicht vergeben`.
- **Titel und Kurzbeschreibung**
- **Prioritaet:** Kritisch / Hoch / Mittel / Niedrig / Noch offen
- **Status:** Vermutet / Bestaetigt / In Bearbeitung / Behoben / Verworfen
- **Fundquelle und Commit:** Include verified commit SHA, or state `Unbekannt`.
- **Betroffene Dateien/Funktionen:** Include precise locations where possible.
- **Belege:** Separate demonstrated facts from assumptions.
- **Reproduktionsschritte / Verifikation:** State whether performed or only proposed.
- **Auswirkung und empfohlene Korrektur:** Prose only, no implementation.
- **Duplikatpruefung:** Compare with available entries, or state that the register was unavailable.

The central bug register is managed in the ChatGPT project, not automatically in this repository. Never claim to have updated it without actually accessing and updating the relevant project artifact. Do not create GitHub issues as a substitute.

## When implementation is explicitly approved

Before making changes, confirm the approved scope, preserve existing mechanics, and propose targeted validation. Do not expand the task to unrelated refactors. Report what changed and which tests actually ran.
