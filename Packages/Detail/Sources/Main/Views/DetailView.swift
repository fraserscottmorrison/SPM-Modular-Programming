import SwiftUI
import Tools

/// Displays a routed detail screen for the provided title.
public struct DetailView: View {

    @StateObject internal var viewModel: ViewModel

    public init(router: Binding<Router<DetailRoute>>, title: String) {
        _viewModel = StateObject(wrappedValue: ViewModel(router: router, title: title))
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                ZStack {
                    self.viewModel.title.toHashColor()
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text(self.viewModel.title)
                            .font(.largeTitle).fontWeight(.semibold)
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.action(.onAppear)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Push Next") {
                    self.viewModel.router.navigateTo(.initialRoute(WordGenerator.next()))
                }
                .font(Font.title3)
                .tint(.black)
            }
        }
    }
}

#if DEBUG
#Preview {
    DetailView(router: PreviewRouter<DetailRoute>().routerBinding, title: "Preview")
}
#endif
