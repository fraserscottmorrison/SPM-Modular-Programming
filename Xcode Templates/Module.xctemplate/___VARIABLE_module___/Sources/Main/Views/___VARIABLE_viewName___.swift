// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools
import ___VARIABLE_module___Concurrent

/// Displays a routed detail screen for the provided title.
public struct ___VARIABLE_viewName___: View {

    @State internal var viewModel: ViewModel

    public init(router: Binding<Router<___VARIABLE_module___Route>>) {
        _viewModel = State(initialValue: ViewModel(router: router))
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                Text("")
            case .loading:
                ProgressView()
            default:
                ProgressView()
            }
        }
        .onAppear {
            viewModel.action(.onAppear)
        }
    }
}

#if DEBUG
#Preview {
    ___VARIABLE_viewName___(router: PreviewRouter<___VARIABLE_module___Route>().routerBinding)
}
#endif
