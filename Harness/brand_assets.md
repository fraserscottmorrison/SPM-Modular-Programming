# Brand Asset And Resource Index

## Goal

Keep asset, color, typography, launch, icon, and bundled resource changes aligned with the current app and package layout.

## When To Load

- Adding or renaming images, colors, app icons, launch assets, package resources, typography styles, or audio files.
- Fixing asset catalog build errors.
- Moving resources between app and packages.

## Live Asset Surface

| Surface | Path | Notes |
| --- | --- | --- |
| App asset catalog | `App/Assets.xcassets` | Contains `AccentColor`, `AppIcon`, and `LaunchIcon`. |
| iOS launch storyboard | `App/LaunchScreen.storyboard` | iOS-only resource. Do not include in macOS or visionOS app targets. |
| Tools resources | `SharedPackages/Tools/Sources/Main/Resources/Assets.xcassets` | Contains dummy color set for bundle generation. |
| Entry resources | `FeaturePackages/Entry/Sources/Main/Resources/Assets.xcassets` | Contains dummy color set for bundle generation. |
| Detail resources | `FeaturePackages/Detail/Sources/Main/Resources/Assets.xcassets` | Contains dummy color set for bundle generation. |
| Mock responses | `*/Sources/Mocks/Responses` | Processed by mock targets. |

## Color And Typography

- `AccentColor` is the app-level accent color asset.
- `dummyColorSetToGenerateBundle` exists only to force package bundle generation; do not use it as a semantic color token.
- `String.toHashColor()` creates deterministic placeholder colors from text; it is not a brand palette.
- Live views use SwiftUI system text styles such as `.largeTitle`, `.body`, and `.title3`; no custom font bundle exists.

## Icons And Launch Assets

- `AppIcon` is the app icon asset catalog entry. Check platform-specific entries before enabling `ASSETCATALOG_COMPILER_APPICON_NAME` on a new target.
- `LaunchIcon` is a normal image set used by the iOS launch storyboard.
- App icon sets are not normal storyboard image resources; use an image set for launch storyboard images.
- Native macOS and visionOS targets should not compile `LaunchScreen.storyboard`.

## Resource Ownership

- App-wide visual assets belong in `App/Assets.xcassets`.
- Package-owned resources belong under the owning package's `Sources/Main/Resources` and require `resources: [.process("Resources")]` in that target.
- Mock-only resources belong under `Sources/Mocks/Responses` and require mock target processing.
- Do not hard-code image filenames when an asset catalog name is the intended API.

## Accuracy Contracts

### Do

- Preserve asset names used by live Swift or storyboard files.
- Keep package resource manifests in sync with added resource folders.
- Use complete asset catalog JSON entries; placeholder color entries should still include valid color components.

### Do Not

- Do not treat package dummy colors as design tokens.
- Do not add launch storyboard resources to non-iOS targets.
- Do not add audio or legacy assets unless they are copied into a bundled resource path and the package/target processes them.

## Verification

- Build the target that owns the asset catalog.
- For package resources, run the owning package build and the app target that consumes the package.
- For app icon changes, check the relevant platform target settings and asset catalog entries together.
