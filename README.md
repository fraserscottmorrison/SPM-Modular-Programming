# Swift Package Manager Modular Programming

<img width="200" height="200" alt="SPM Modular Programming" src="https://github.com/user-attachments/assets/ab698fd0-b1bb-45b3-8903-80160e096d7b" />

In an era where features can be rapidly added to projects a scalable modular architecture is vital to support this growth

# Concept
 - The project is kept extremely thin; < 10 lines of code total!
 - Rely on SPM packages for everything, from featues to shared code and compnents
 - 

# Benefits
 - SPM Modular Programming handles the inter-package architecture while you keep your preferried intra-package architcture eg MVVM or unidirectional architecture
 - Only a single .xcodeproj file to maintain and no .xcworkspace 


# Example Project
Give SPM Modular Programming a text drive with the example project; features include
 - SwiftUI, MVVM-C intra package architecture
 - NavigationStacks needs to be setup in a particular manner for inter package routing. See how to do it here
 - Xcode Templates to quickly generate new packages and views
 - Full agentic harness, for efficent and accurate agentic code contributions, leveraging the Xcode Templates


# Limitations
Every architecture has it's downsides. If an author isn't making them clear they're not being honest or doesn't know it deeply enough
 - If you have a widget extension, most of the code can be in a package, but certain classes must unfortunately be kept in the main project eg Widget, WidgetBundle, WidgetConfigurationInntent, AppIntentTimelineProvider
 - Packages without assets do not generate a bundle. I like to have a standard interface for the bundle of every package so as a workaround I add a dummy asset
