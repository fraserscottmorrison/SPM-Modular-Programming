# Swift Package Manager Modular Programming

<img width="200" height="200" alt="SPM Modular Programming" src="https://github.com/user-attachments/assets/ab698fd0-b1bb-45b3-8903-80160e096d7b" />

In an era where features can be rapidly added to projects, a scalable modular architecture is vital to support growth.

## Concept

- Keep the project extremely thin — less than 10 lines of code in total.
- Rely on SPM packages for everything, from features to shared code and components.
- Do not use the **Project → Package Dependencies** UI to add packages, as this modifies the `.xcodeproj` file and can make source control more difficult. Instead, drag local feature packages into the Project Navigator and use their `Package.swift` files to pull in local common packages.
- Manage all dependencies through `Package.swift` files where possible. For third-party libraries, pin dependencies to exact versions to ensure all developers and CI/CD environments build the same code.
- For structured concurrency, feature packages contain a **Main** target and a **Concurrent** target, providing a clear separation between `MainActor` code and concurrent code.

## Project Structure

```text
Project
├── App
│   └── App.swift
├── Packages
│   ├── Feature Package
│   └── ...
└── Package Dependencies
    ├── Common Package (local or remote)
    ├── ...
    ├── 3rd Party Package
    └── ...
```

## Feature Package Structure
```text
Package
├── Package.swift
├── Sources
│   ├── Concurrent
│   │   ├── Models/ (Sendable)
│   │   └── Service.swift (actor)
│   │
│   └── Main (all MainActor)
│       ├── Views/
│       ├── PackageCoordination.swift
│       └── PackageRoute.swift
└── Tests
```
## Benefits
- SPM Modular Programming handles inter-package architecture while allowing you to use your preferred intra-package architecture, such as MVVM or a unidirectional architecture.
- Modular design that scales effectively for large projects.
- Only a single `.xcodeproj` file to maintain, with no `.xcworkspace` required.
- Designed for AI agents. Say goodbye to vibe coding and welcome efficient, accurate agentic contributions through a well-defined architecture and optimized development harness.

## Example Project
Give SPM Modular Programming a test drive with the example project. Features include:
- SwiftUI with an MVVM-C intra-package architecture.
- `NavigationStack`s configured for inter-package routing. See the example project for implementation details.
- Xcode Templates to quickly generate new packages and views.
- A complete agentic development harness for efficient and accurate AI-assisted code contributions, leveraging the provided Xcode Templates.

## Limitations
Every architecture has its strengths and weaknesses. If an author isn't clear about both, they either aren't being honest or don't understand the architecture deeply enough.
- If your app includes a widget extension, most of the code can live in a package. However, certain classes must remain in the main project, such as `Widget`, `WidgetBundle`, `WidgetConfigurationIntent`, `AppIntentTimelineProvider`, and related types.
- As mentioned above, `NavigationStack`s must be configured in a specific way to support inter-package routing. The example project demonstrates this approach.
- Packages without assets do not generate a bundle. I prefer every package to expose a consistent bundle interface, so I add a dummy asset as a workaround.
- Prior to Swift 6 packages were limited to `DEBUG` and `RELEASE` configurations through a poorly documented heuristics-based system. While this can be worked around, Swift now provides traits to improve the situation.
Apple, if you're reading this, please consider addressing these limitations
