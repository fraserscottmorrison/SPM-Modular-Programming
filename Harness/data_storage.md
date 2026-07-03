# Data Storage

## Goal

Document what is currently known about persistence and prevent agents from inventing storage rules.

## When To Load

- Adding persistence, cache, high-score storage, file storage, user defaults, SwiftData, Keychain, or migration code.
- Implementing user-requested feature requirements that mention saved state.

## Applicability Evidence

- Live Swift source has no `UserDefaults`, `SwiftData`, `CoreData`, `FileManager`, or Keychain usage.
- `Docs/Highscores.txt` exists as legacy input data.

## Guidance

### supported_storage_types

- No storage mechanism is implemented in live packages.
- Treat high-score persistence as planned but unimplemented until source exists.

### storage_selection_rules

- Do not add persistence unless the user request or live feature surface requires durable state.
- For simple high-score lists, confirm the intended storage mechanism before coding.
- If sensitive data is introduced, do not use plain `UserDefaults`; require an approved secure storage approach.

### storage_access_patterns

- Prefer a small protocol-backed repository/service for persistence so ViewModels can be tested.
- Keep storage implementation inside the owning feature package unless it is shared across multiple packages.
- Tests should cover ordering, limits, round-trip persistence, and empty/corrupt data handling.

## Accuracy Contracts

### Do

- Mark storage decisions as `Needs project confirmation` when live source does not show the intended mechanism.
- Keep persistence keys namespaced if `UserDefaults` is confirmed.
- Add test cleanup for persistent stores so tests do not leak state across runs.

### Do Not

- Do not silently choose SwiftData over UserDefaults or the reverse for high scores.
- Do not store private user data, credentials, or tokens in generated docs or test fixtures.
- Do not make ViewModels talk to storage APIs directly when a repository boundary is practical.

### Expected Output Shape

- New repository/service protocol plus implementation in the owning package.
- Unit tests for ranking, max-count limits, persistence round trip, and reset/cleanup.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| Live Swift source search | Absence of implemented storage. |

## Needs Project Confirmation

- Whether high scores should use SwiftData, UserDefaults, or another storage mechanism.
- Whether legacy `Docs/Highscores.txt` should seed initial high scores.

## Verification

- Search live source for the chosen storage API before adding a second mechanism.
- Add unit tests that create a fresh store/key and clean it up after each test.
