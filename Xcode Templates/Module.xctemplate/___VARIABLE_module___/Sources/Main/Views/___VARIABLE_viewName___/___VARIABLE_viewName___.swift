import SwiftUI
import Tools

public struct ___VARIABLE_viewName___: View {

    @StateObject internal var viewModel: ViewModel

    public init(router: Binding<Router<___VARIABLE_module___Route>>) {
        _viewModel = StateObject(wrappedValue: ViewModel(router: router))
    }

    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loaded:
                EmptyView()
            case .loading:
                ProgressView()
            default:
                EmptyView()
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