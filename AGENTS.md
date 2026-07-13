# FuturamaInvadersNew Agent Harness

Swift 6.2 modular SwiftUI workspace with local Swift packages and separate native app targets for iOS, macOS, and visionOS.

## Harness Purpose

This repository uses `Harness/` as the durable guidance library for agents. Load this file first, then load only the focused harness document that matches the task. Live source is the authority when a harness file, template, or older chat summary disagrees with code.

## Live Topology

- App entrypoint: `App/ModularProgrammingApp.swift` imports `Entry` and launches `EntryStack()`.
- Feature packages: `FeaturePackages/Entry` and `FeaturePackages/Detail`.
- Shared package: `SharedPackages/Tools`.
- Dependency direction: app targets -> `Entry`; `Entry` -> `Detail` + `Tools`; `Detail` -> `Tools`; `Tools` has no package dependencies.
- Package platforms: iOS 26, macOS 26, tvOS 26, watchOS 26, and visionOS 26.
- Xcode app targets: `FuturamaInvadersNew` for iOS-family builds, `FuturamaInvadersNew-macOS` for native macOS, and `FuturamaInvadersNew-visionOS` for native visionOS.
- Current UI architecture: SwiftUI, route enums, coordinators, `Router`, `NavigationStack`, Swift Observation ViewModels, and package-owned resources.

## Load Order

1. Read this file for the task map and non-negotiable project facts.
2. Load the smallest matching harness file from the category map.
3. Read the live source files that own the behavior before editing.
4. Prefer live package manifests, project settings, and templates over stale notes.

## Category Map

| Category | File | When To Load |
| --- | --- | --- |
| Inter-module architecture | [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md) | Package, dependency, target, module-boundary, or app-entry work. |
| Intra-module architecture | [Harness/intra_module_architecture.md](Harness/intra_module_architecture.md) | SwiftUI screen, ViewModel, state/action, file-structure, or module-internal work. |
| Navigation pattern | [Harness/navigation_pattern.md](Harness/navigation_pattern.md) | Route enum, coordinator, router, tab, sheet, full-screen, or `NavigationStack` work. |
| UI components | [Harness/ui_components.md](Harness/ui_components.md) | Shared SwiftUI wrappers, modifiers, preview helpers, or reusable UI utilities. |
| Brand/assets | [Harness/brand_assets.md](Harness/brand_assets.md) | Asset catalogues, app icons, launch assets, colors, typography, audio, or package resources. |
| Coding standards | [Harness/coding_standards.md](Harness/coding_standards.md) | Swift style, naming, comments, Observation, access control, previews, lint, or logging. |
| Platform configuration | [Harness/platform_configuration.md](Harness/platform_configuration.md) | Xcode project, schemes, SPM manifests, deployment targets, templates, or resource bundling. |
| QA/testing | [Harness/qa/qa_testing.md](Harness/qa/qa_testing.md) | Unit tests, view tests, ViewModel tests, package tests, or build validation. |
| Data storage | [Harness/data_storage.md](Harness/data_storage.md) | Persistence, caching, high scores, file storage, UserDefaults, SwiftData, or migrations. |

Compatibility entrypoints exist for older references: [Harness/components.md](Harness/components.md), [Harness/concurrency.md](Harness/concurrency.md), [Harness/coordinator-routing.md](Harness/coordinator-routing.md), [Harness/mvvm.md](Harness/mvvm.md), [Harness/package-based-development.md](Harness/package-based-development.md), and [Harness/standards.md](Harness/standards.md). Keep real rules in the owner files above.

## Task Dispatch

| Task | Load |
| --- | --- |
| Add or change an SPM package, product, target, or dependency | [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md) + [Harness/platform_configuration.md](Harness/platform_configuration.md) |
| Add or modify a SwiftUI screen or ViewModel | [Harness/intra_module_architecture.md](Harness/intra_module_architecture.md) + [Harness/coding_standards.md](Harness/coding_standards.md) |
| Change routes, coordinators, tabs, sheets, or navigation stacks | [Harness/navigation_pattern.md](Harness/navigation_pattern.md) |
| Use or extend shared SwiftUI infrastructure | [Harness/ui_components.md](Harness/ui_components.md) |
| Change assets, app icons, package resources, or launch surfaces | [Harness/brand_assets.md](Harness/brand_assets.md) + [Harness/platform_configuration.md](Harness/platform_configuration.md) |
| Change package platforms, Xcode targets, schemes, or templates | [Harness/platform_configuration.md](Harness/platform_configuration.md) + [Harness/inter_module_architecture.md](Harness/inter_module_architecture.md) |
| Add or change tests | [Harness/qa/qa_testing.md](Harness/qa/qa_testing.md) |
| Add persistence | [Harness/data_storage.md](Harness/data_storage.md) |
| Task not matched above | [Harness/coding_standards.md](Harness/coding_standards.md) + this file |

## Current Validation Commands

- Project list: `xcodebuild -list -project FuturamaInvadersNew.xcodeproj`
- iOS app: `env -u IS_RELEASE xcodebuild build -project FuturamaInvadersNew.xcodeproj -scheme SPM-Modular-Programming -destination 'generic/platform=iOS Simulator'`
- Native macOS app: `env -u IS_RELEASE xcodebuild build -project FuturamaInvadersNew.xcodeproj -scheme FuturamaInvadersNew-macOS -destination 'platform=macOS'`
- Native visionOS app: `env -u IS_RELEASE xcodebuild build -project FuturamaInvadersNew.xcodeproj -scheme FuturamaInvadersNew-visionOS -destination 'generic/platform=visionOS'` after installing the visionOS platform component in Xcode.
- Local package smoke build: run `env -u IS_RELEASE swift build` inside `SharedPackages/Tools`, `FeaturePackages/Detail`, or `FeaturePackages/Entry`.

## Unknowns And Assumptions

- The app has no implemented persistence layer. Treat high scores, caches, SwiftData, UserDefaults, and migrations as unconfirmed until source or a user request defines them.
- There is no live dedicated `Components` package. Use `SharedPackages/Tools` for domain-neutral shared infrastructure only.
- There is no live DI container, logger, feature flag system, permission flow, or remote API client beyond mock/data-store scaffolding in `ToolsConcurrent`.
- tvOS, watchOS, and visionOS platform builds require the matching Xcode platform components to be installed locally.

## Rules

- Keep package dependencies flowing toward `Tools`; never introduce cycles.
- Keep native macOS and native visionOS as separate app targets; do not turn the iOS target into Catalyst or “Designed for iPad on Mac” unless explicitly requested.
- Do not add secrets, credentials, tokens, or private user data to source, tests, docs, or generated harness files.
- Do not edit Xcode user data unless the task explicitly concerns user scheme state or Xcode UI state.
