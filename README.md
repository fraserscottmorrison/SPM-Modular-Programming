# Swift Package Manager Modular Programming

<img width="200" height="200" alt="SPM Modular Programming" src="https://github.com/user-attachments/assets/ab698fd0-b1bb-45b3-8903-80160e096d7b" />

In an era where features can be rapidly added to projects a scalable modular architecture is vital to support this growth

## Concept
 - The project is kept extremely thin; < 10 lines of code total!
 - Rely on SPM packages for everything, from featues to shared code and compnents
 - Do not us the Project->Package Dependencies UI for adding Packages as this modifies the xcodeproj file making source control more difficult. Instead just drag the local feature packages into the Project Navigator and use its Package.swift to pull in local common packages
 - Try to manage all dependencies via Package.swift files and for 3rd party libraries pin to an exact version to ensure all developers, and CI/DC, builds the same code
 - For Structured Concurrency: Feature Packages have a Main target and a Concurrent target to have a clear division of MainActor code vs concurrent code

## Project Structure
``` 
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
``` 
Package
├── Package.swift
├── Sources
│   ├── Concurrent/
│   │    ├── Models/ (Sendable)
│   │    └── Service.swift (actor)
│   │ 
│   └── Main/ (all MainActor)
│        ├── Views/
│        ├── PackageCoordination.swift
│        └── PackageRoute.swift
└──  Tests
```

## Benefits
 - SPM Modular Programming handles the inter-package architecture while you keep your preferried intra-package architcture eg MVVM or unidirectional architecture
 - Modular design for scaling large projects
 - Only a single .xcodeproj file to maintain and no .xcworkspace
 - Designed for agents. Say goodbye to vibe coding and welcome in efficient and accurate agentic contribution thanks to the well defined archtecture and optimised harness
 - 

## Example Project
Give SPM Modular Programming a test drive with the example project; features include
 - SwiftUI, MVVM-C intra package architecture
 - NavigationStacks needs to be setup in a particular manner for inter package routing. See how to do it here
 - Xcode Templates to quickly generate new packages and views
 - Full agentic harness, for efficent and accurate agentic code contributions, leveraging the Xcode Templates


## Limitations
Every architecture has it's upsides and downsides. If an author isn't making them both clear they're not being honest or doesn't know it deeply enough
 - If you have a widget extension, most of the code can be in a package, but certain classes must unfortunately be kept in the main project eg Widget, WidgetBundle, WidgetConfigurationInntent, AppIntentTimelineProvider
 - As mentioned above NavigationStacks needs to be setup in a particular manner for inter package routing. The example project demonstrates how
 - Packages without assets do not generate a bundle. I like to have a standard interface for the bundle of every package so as a workaround I add a dummy asset
 - Packages used to be limited to DEBUG and RELEASE based on a poorly documented "heuristics" system. This can be worked with, but Swift has added support for traits to improve this
 - Apple, if you're reading this, please consider addressing these limitations 
