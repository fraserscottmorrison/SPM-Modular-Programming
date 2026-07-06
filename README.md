# Swift Package Manager: Modular Programming

<p align="center">
<img width="200" height="200" alt="SPM Modular Programming" src="https://github.com/user-attachments/assets/ab698fd0-b1bb-45b3-8903-80160e096d7b" />
</p>

In an era where features will be rapidly added to projects, a scalable, modular architecture is vital to support growth.

## Concept

- Keep the project extremely thin — less than 10 lines of code in total.
- Rely on SPM packages for everything, from features to shared code and components.
- Packages are self contained - mocks and unit tests (and even UI tests) are all contained within their package
- Do not use the **Project → Package Dependencies** UI to add packages, as this modifies the `.xcodeproj` file and will make source control more difficult. Instead, drag local feature packages into the Project Navigator and use their `Package.swift` files to declare dependencies with local common and 3rd party packages.
- Manage all dependencies through `Package.swift` files where possible. For third-party libraries, pin dependencies to exact versions to ensure all developers and CI/CD environments build the same code.
- For structured concurrency, feature packages contain a **Main** target and a **Concurrent** target, providing a clear separation between `MainActor` code and concurrent code.

## Project Structure
```text
Xcode Project
├── App/
│   └── App.swift
├── Packages/
│   ├── Feature Packages
│   └── ...
├── Package Dependencies/
│   ├── Common Packages (local or remote)
│   ├── ...
│   ├── 3rd Party Packages
│   └── ...
├── AGENTS.md
└── Harness/
```

## Feature Package Structure
```text
Package/
├── Package.swift
├── Sources/
│   ├── Concurrent/
│   │   ├── Models/ (Sendable)
│   │   └── Service.swift (actor)
│   │
│   └── Main/ (all MainActor)
│       ├── Views/
│       ├── PackageCoordinator.swift
│       └── PackageRoute.swift
└── Tests/
```

## Benefits
- SPM Modular Programming handles inter-package architecture while allowing you to use your preferred intra-package architecture, such as MVVM or a unidirectional architecture.
- Modular design that scales effectively for large projects.
- Independent packages allows CI to run tests only for changed and affected packages
- Only a single `.xcodeproj` file to maintain and no need for a `.xcworkspace` file.
- Designed for agents. Say goodbye to vibe coding and welcome efficient, accurate agentic contributions through a well-defined architecture and optimized development harness.

## Reference Project
Give SPM Modular Programming a test drive with the reference project. Features include:
- SwiftUI with an MVVM-C intra-package architecture.
- `NavigationStack`s configured for inter-package routing. See the reference project for implementation details.
- Xcode Templates to quickly generate new packages and views.
- A complete agentic development harness for efficient and accurate agentic code contributions, leveraging the provided Xcode Templates.

## Harness
The reference project include agentic harness documentation optimised for agents to accurately contribute features.

## Limitations
Every architecture has its strengths and weaknesses. If an author isn't clear about both, they either aren't being honest or they don't understand the architecture deeply enough.
- If your app includes a widget extension, most of the code can live in a package. However, certain classes must remain in the main project, such as `Widget`, `WidgetBundle`, `WidgetConfigurationIntent`, `AppIntentTimelineProvider`, and related types.
- As mentioned above, `NavigationStack`s must be configured in a specific way to support inter-package routing. The reference project demonstrates this approach.
- Packages without assets do not generate a bundle. I prefer every package to expose a consistent bundle interface, so I add a dummy asset as a workaround.
- Prior to Swift 6 packages were limited to `DEBUG` and `RELEASE` configurations through a poorly documented heuristics-based system. While this can be worked around, Swift now provides traits to improve the situation - thank you Swift team
- Apple, if you're reading this, please consider addressing these limitations
