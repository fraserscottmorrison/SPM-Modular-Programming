# Data Storage

## Goal

Document what is currently known about persistence and prevent agents from inventing storage rules.

## When To Load

- Adding persistence, cache, high-score storage, file storage, UserDefaults, SwiftData, Keychain, or migration code.
- Implementing user-requested feature requirements that mention saved state.

## Live State

- Live Swift source has no `UserDefaults`, SwiftData, Core Data, FileManager persistence, or Keychain usage.
- There is no repository/service abstraction for durable storage yet.
- No app-wide session store or persistence container exists.

## Storage Selection Rules

- Do not add persistence unless the user request or live feature surface requires durable state.
- For simple local settings or scores, confirm the intended storage mechanism before coding unless the user explicitly delegates the choice.
- If sensitive data is introduced, do not use plain `UserDefaults`; require an approved secure storage approach.
- Keep storage implementation inside the owning feature package unless it is shared across multiple packages.

## Access Pattern

- Prefer a small protocol-backed repository/service so ViewModels can be tested.
- Inject storage dependencies through initializers or feature-level boundaries.
- Keep ViewModels from directly owning raw persistence APIs when a repository boundary is practical.

## Accuracy Contracts

### Do

- Mark storage choices as needing project confirmation when live source does not define the mechanism.
- Namespace persistence keys if UserDefaults is confirmed.
- Add test cleanup so persistent stores do not leak state across test runs.

### Do Not

- Do not silently choose SwiftData over UserDefaults or the reverse for high scores.
- Do not store credentials, tokens, private user data, or secrets in generated docs, fixtures, or source.
- Do not add migrations before there is a persisted schema to migrate.

## Expected Output Shape

- New repository/service protocol plus implementation in the owning package.
- Unit tests for ordering, max-count limits, persistence round trip, reset/cleanup, and corrupt/empty data handling where relevant.

## Verification

- Search live source for the chosen storage API before adding a second mechanism.
- Run focused tests that use a fresh store/key and clean it up after each test.
