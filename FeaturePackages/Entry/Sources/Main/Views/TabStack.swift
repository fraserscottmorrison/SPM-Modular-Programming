// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools
import Detail
import DetailConcurrent

/// Displays tab items and their independent navigation stacks.
public struct TabStack: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State internal var viewModel: ViewModel
    @State private var refreshIds: [Int: String] = [:]

    public init(router: Binding<Router<EntryRoute>>) {
        _viewModel = State(initialValue: ViewModel(router: router))
    }

    var selectedPath: NavigationPath {
        return viewModel.tabPaths[selectedTabIndex]
    }

    func getPath(index: Int) -> Binding<NavigationPath> {
        return $viewModel.tabPaths[index]
    }

    public var body: some View {
        Group {
            if shouldUseTabBar {
                tabBarLayout
            } else {
                splitViewWithTabsAsSidebarLayout
            }
        }
        .tint(.red)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var isRegularWidth: Bool {
        horizontalSizeClass == .regular
    }

    private var shouldUseTabBar: Bool {
        return isRegularWidth == false || TabStack.iPadTabBarEnabled
    }

    private var selectedTabIndex: Int {
        index(for: viewModel.selectedTab)
    }

    private var selectedTab: Binding<ViewModel.Tab> {
        Binding {
            viewModel.selectedTab
        } set: { tab in
            viewModel.selectedTab = tab
            viewModel.selectedTabIndex = index(for: tab)
        }
    }

    private var selectedSidebarTab: Binding<ViewModel.Tab?> {
        Binding {
            viewModel.selectedTab
        } set: { tab in
            guard let tab else { return }
            viewModel.selectedTab = tab
            viewModel.selectedTabIndex = index(for: tab)
        }
    }

    private var tabItems: [(offset: Int, element: ViewModel.Tab)] {
        Array(ViewModel.Tab.allCases.enumerated())
    }

    @ViewBuilder private var tabBarLayout: some View {
        TabView(selection: selectedTab) {
            ForEach(tabItems, id: \.element) { index, tab in
                tabContent(for: tab, index: index)
                    .tabItem {
                        Label(tab.rawValue, systemImage: tabIconName(for: index))
                    }
                    .tag(tab)
            }
        }
    }

    @ViewBuilder private var splitViewWithTabsAsSidebarLayout: some View {
        NavigationSplitView {
            List(selection: selectedSidebarTab) {
                ForEach(tabItems, id: \.element) { index, tab in
                    Label(tab.rawValue, systemImage: tabIconName(for: index))
                        .tag(tab)
                }
            }
        } detail: {
            navigationStackLayout(for: viewModel.selectedTab, index: selectedTabIndex)
        }
    }

    @ViewBuilder private func tabContent(for tab: ViewModel.Tab, index: Int) -> some View {
        if isRegularWidth && tab.isSplitView {
            splitViewLayout(for: tab, index: index)
        } else {
            navigationStackLayout(for: tab, index: index)
        }
    }

    @ViewBuilder private func splitViewLayout(for tab: ViewModel.Tab, index: Int) -> some View {
        NavigationSplitView {
            Label(tab.rawValue, systemImage: tabIconName(for: index))
        } detail: {
            navigationStackLayout(for: tab, index: index)
        }
    }

    @ViewBuilder private func navigationStackLayout(for tab: ViewModel.Tab, index: Int) -> some View {
        NavigationStack(path: getPath(index: index)) {
            DetailCoordinator(path: getPath(index: index), initialRoute: .initialRoute(index))
                .id(refreshIds[index] ?? "\(index)")
        }
        .ignoresSafeArea()
    }

    private func index(for tab: ViewModel.Tab) -> Int {
        return ViewModel.Tab.allCases.firstIndex(of: tab) ?? 0
    }

    private func tabIconName(for index: Int) -> String {
        return "\(index + 1).circle"
    }
}

#if DEBUG
#Preview {
    TabStack(router: PreviewRouter<EntryRoute>().routerBinding)
}
#endif
