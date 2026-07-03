# SPM-Modular-Programming - Agent Harness

Swift 6.2 package workspace, SwiftUI app target, iOS 26 deployment surface.

## Harness Purpose

This repository uses `Harness/` as the durable guidance library for agents. Load it before making project changes so edits follow the live package layout instead of stale generated plans.

## Scope

- Harness target: SPM-Modular-Programming repository root
- Source root: repository root
- Platform: iOS
- Structure mode: preserve existing `Harness/` structure tracked by Git.

## Source Evidence Summary

- App entrypoint: `App/ModularProgrammingApp.swift` launches `EntryStack()`.
- Live packages: `Packages/Tools`, `Packages/Detail`, and `Packages/Entry`.
- Dependency direction: app target -> `Entry`; `Entry` -> `Detail` + `Tools`; `Detail` -> `Tools`; `Tools` has no declared package dependencies.
- UI pattern: SwiftUI views with nested `@MainActor` ViewModels, route enums, coordinators, `Router`, and `NavigationStack`.
- Assets: `App/Assets.xcassets` contains sprites, backgrounds, launch/app icons, and the accent color. Each package also has a minimal resource asset catalogue.
- Tests: Swift Testing in `Tools`; XCTest in `Entry` and `Detail`; Xcode project has `SPM-Modular-ProgrammingTests` and `SPM-Modular-ProgrammingUITests` targets.
- Existing prior art: root `AGENTS.md` and Xcode templates.
- Inventory caveat: project inventory may include `.build` and `.agents/skills` artifacts; ignore Factory demo assets, optimiser test mocks, and i18next/MSW signals unless they appear in live app or package source.

## Load Order

1. Read this file for the category map, source evidence summary, and unknowns.
2. Load only the category docs whose `When To Load` guidance matches the task.
3. Prefer live source files over templates or older generated artifacts when they conflict.

## Category Map

| Category | Status | File | When To Load |
| --- | --- | --- | --- |
| `inter_module_architecture` | applicable | [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md) | Package, target, dependency, module-boundary, or app-entry work. |
| `intra_module_architecture` | applicable | [Harness/intra_module_architecture.md](Harness/intra_module_architecture.md) | Screen, ViewModel, state/action, DI, or file-structure work inside a package. |
| `api_networking` | not-applicable | none | No live API, HTTP client, request model, or remote data-source evidence. |
| `navigation_pattern` | applicable | [Harness/navigation_pattern.md](Harness/navigation_pattern.md) | Route enum, coordinator, router, tab, sheet, or `NavigationStack` work. |
| `ui_components` | applicable | [Harness/ui_components.md](Harness/ui_components.md) | Shared SwiftUI utilities, preview router, modifiers, or reusable view work. |
| `brand_assets` | applicable | [Harness/brand_assets.md](Harness/brand_assets.md) | Asset catalogue, image, color, typography, audio, or resource work. |
| `coding_standards` | applicable | [Harness/coding_standards.md](Harness/coding_standards.md) | Naming, comments, concurrency annotations, previews, lint, or framework-choice work. |
| `qa_testing` | applicable | [Harness/qa/qa_testing.md](Harness/qa/qa_testing.md) | Unit, view, ViewModel, package, or Xcode test work. |
| `mocks` | not-applicable | none | No live project mock directory or mock framework evidence. Ignore mocks inside `.agents/skills/.../tests/`. |
| `prompts` | needs-confirmation | none | Packages set `defaultLocalization`, but no live localisation or prompt files were found. |
| `user_permissions` | not-applicable | none | No permission APIs or privacy declaration evidence found. |
| `feature_enablement_flags` | not-applicable | none | No build-time or runtime feature flag system found. |
| `data_storage` | needs-confirmation | [Harness/data_storage.md](Harness/data_storage.md) | Persistence work, especially high score storage not present in live source. |
| `platform_configuration` | applicable | [Harness/platform_configuration.md](Harness/platform_configuration.md) | Xcode project, schemes, SPM manifests, templates, deployment target, or resource bundling work. |

## Task Dispatch

| Task | Load |
| --- | --- |
| Add or change an SPM package, target, or dependency | [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md) + [Harness/platform_configuration.md](Harness/platform_configuration.md) |
| Add or modify a SwiftUI screen or ViewModel | [Harness/intra_module_architecture.md](Harness/intra_module_architecture.md) + [Harness/coding_standards.md](Harness/coding_standards.md) |
| Add or change routes, coordinators, tabs, sheets, or navigation stacks | [Harness/navigation_pattern.md](Harness/navigation_pattern.md) |
| Use or extend shared views, modifiers, or utilities | [Harness/ui_components.md](Harness/ui_components.md) |
| Add or change asset catalogues, colors, images, typography, audio resources, or generated asset symbols | [Harness/brand_assets.md](Harness/brand_assets.md) |
| Add or change local persistence | [Harness/data_storage.md](Harness/data_storage.md) |
| Add or change tests | [Harness/qa/qa_testing.md](Harness/qa/qa_testing.md) |
| Change build settings, schemes, templates, deployment targets, or resources | [Harness/platform_configuration.md](Harness/platform_configuration.md) |
| Task not matched above | [Harness/coding_standards.md](Harness/coding_standards.md) + this file |

## Existing Documentation Incorporated

| Source | Used In | Notes |
| --- | --- | --- |
| `AGENTS.md` | all generated docs | Root index, load-order rules, and category dispatch. |
| `Xcode Templates/` | `inter_module_architecture`, `intra_module_architecture`, `platform_configuration` | Aligned with the current `Tools`-only module and `ObservableObject` ViewModel patterns. |
| Live Swift package files | all generated docs | Primary source of truth. |

## Unknowns And Assumptions

- Needs project confirmation: whether deleted or absent feature and `Components` packages should be restored or ignored.
- Needs project confirmation: whether `Factory` DI and the missing screen-history service should be restored or removed from live `Tools` source.
- Needs project confirmation: the intended local persistence implementation for high scores; live source has none.
- Needs project confirmation: preferred CI/build command and simulator destination.

## Drift Controls

- Module ownership and dependency direction live in [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md).
- Screen/ViewModel structure lives in [Harness/intra_module_architecture.md](Harness/intra_module_architecture.md).
- Router and presentation rules live in [Harness/navigation_pattern.md](Harness/navigation_pattern.md).
- Build commands, package manifests, and template caveats live in [Harness/platform_configuration.md](Harness/platform_configuration.md).
- Testing rules live only in [Harness/qa/qa_testing.md](Harness/qa/qa_testing.md).

## Rules

- Treat `Needs project confirmation` sections as blockers for automated edits that depend on the unknown.
- Do not infer missing modules, scripts, prompts, flags, storage rules, or permission flows from generic Swift or iOS practice.
- Do not write secrets, credentials, tokens, or private user data into source, tests, docs, or generated harness files.
