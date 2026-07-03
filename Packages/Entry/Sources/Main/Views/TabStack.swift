import SwiftUI
import Tools
import Detail

/// Displays the Entry tabs and their independent navigation stacks.
public struct TabStack: View {

    @StateObject internal var viewModel: ViewModel
    @State private var refreshIds: [Int: String] = [:]

    public init(router: Binding<Router<EntryRoute>>) {
        _viewModel = StateObject(wrappedValue: ViewModel(router: router))
    }

    var selectedPath: NavigationPath {
        return viewModel.tabPaths[viewModel.selectedTabIndex]
    }

    func getPath(index: Int) -> Binding<NavigationPath> {
        return $viewModel.tabPaths[index]
    }

    public var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(Array(ViewModel.Tab.allCases.enumerated()), id: \.element) { index, tab in
                Group {
                    NavigationStack(path: getPath(index: index)) {
                        DetailCoordinator(path: getPath(index: index), initialRoute: .initialRoute(tab.rawValue))
                            .id(refreshIds[index] ?? "\(index)")
                    }
                    .ignoresSafeArea()
                }
                .tabItem {
                    Label(tab.rawValue, systemImage: "\(index + 1).circle")
                }
                .tag(tab)
            }
        }
        .tint(.red)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func tabSelection() -> Binding<Int> {
        Binding {
            return self.viewModel.selectedTabIndex
        } set: { tappedTab in



            if tappedTab == self.viewModel.selectedTabIndex {


                if self.selectedPath.isEmpty {
                    self.refreshIds[tappedTab] = UUID().uuidString

                } else {

                    self.selectedPathPopToRoot()
                }
            }

            self.viewModel.selectedTabIndex = tappedTab
        }
    }

    private func selectedPathPopToRoot() {
        viewModel.tabPaths[self.viewModel.selectedTabIndex] = NavigationPath()
    }
}

#if DEBUG
#Preview {
    TabStack(router: PreviewRouter<EntryRoute>().routerBinding)
}
#endif
