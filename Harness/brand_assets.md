# Brand Asset Index

## Goal

Keep asset, color, typography, and audio changes aligned with the current resource layout.

## When To Load

- Adding or renaming images, colors, app icons, launch assets, package resources, typography styles, or audio files.
- Porting assets from `Docs/` into app or package bundles.

## Applicability Evidence

- `App/Assets.xcassets` currently contains the app icon set only.
- `Packages/Detail`, `Packages/Entry`, and `Packages/Tools` each contain package resource asset catalogues with placeholder color sets.
- `Docs/` contains legacy `.aif` audio and Java applet assets, but those files are not bundled resources.

## Guidance

### colour_tokens

- No app-level semantic color token is currently present in `App/Assets.xcassets`.
- `dummyColorSetToGenerateBundle.colorset` appears in package resource catalogues and exists to ensure bundle generation; do not treat it as a design token.
- `String.toHashColor()` generates deterministic placeholder colors from text and is not a brand palette.

### image_icon_assets

Current app asset families in `App/Assets.xcassets`:

| Family | Examples |
| --- | --- |
| App icon | `AppIcon` |

Package asset catalogues currently contain only `dummyColorSetToGenerateBundle.colorset` placeholders for bundle generation.

### typography_styles

- Live views use SwiftUI system fonts directly, such as `.largeTitle`, `.semibold`, and `.title3`.
- No custom font files or typography token system was found.

### dynamic_text_scaling

- SwiftUI text styles scale by default, but no project-specific large-text rules are documented in source.
- When adding controls, ensure labels fit compact iPhone widths and dynamic type sizes.

### screen_size_adaptation

- Live views use SwiftUI layout primitives such as `ZStack`, `VStack`, `Spacer`, and `.frame(maxWidth:maxHeight:)`.
- No explicit size class or orientation policy was found in live code.

## Accuracy Contracts

### Do

- Add app-wide visual assets to `App/Assets.xcassets` unless a package explicitly owns the resource.
- Add package-owned resources under `Packages/<Package>/Sources/Main/Resources/` and ensure `Package.swift` processes them.
- Preserve existing asset names used by live Swift code.

### Do Not

- Do not hard-code new image filenames that are not present in an asset catalogue or package resource bundle.
- Do not treat `dummyColorSetToGenerateBundle` as a usable color or brand asset.
- Do not add audio resource guidance as live implementation unless audio files are copied into a bundled resource path.

### Expected Output Shape

- New app image: `App/Assets.xcassets/<name>.imageset/Contents.json` plus image file.
- New package resource: package resource path plus `resources: [.process("Resources")]` in the target when needed.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `App/Assets.xcassets` | Current app icon asset set. |
| `Packages/*/Sources/**/Resources/Assets.xcassets` and `Packages/Tools/Sources/Resources/Assets.xcassets` | Package resource catalogue locations. |
| `Docs/` | Legacy audio and source-artifact context only. |

## Needs Project Confirmation

- Whether audio should remain in `Docs/` or be bundled into a package resource path.
- Whether there is an intended brand typography or color-token system.

## Verification

- Confirm asset names compile through Xcode asset symbol generation.
- Inspect the package `resources` setting before referencing package bundle assets.
