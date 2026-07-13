// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools
import DetailConcurrent

/// Displays a routed detail screen for the provided title.
public struct DetailView: View {

    @State internal var viewModel: ViewModel

    public init(router: Binding<Router<DetailRoute>>, index: Int) {
        _viewModel = State(initialValue: ViewModel(router: router, index: index))
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .loaded(let details):
                ZStack {
                    self.getColor(for: details, isBackground: true)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text(details.name)
                            .font(.largeTitle).fontWeight(.semibold)
                        
                        if let description = details.description {
                            Text(description)
                                .font(.body).fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                }
                .foregroundColor(self.getColor(for: details, isBackground: false))
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
            ToolbarItem(placement: nextButtonPlacement) {
                Button("Next") {
                    self.viewModel.action(.onNext)
                }
                .font(Font.title3)
                .fontWeight(.medium)
                .tint(.black)
            }
        }
    }

    private var nextButtonPlacement: ToolbarItemPlacement {
        #if os(macOS)
        .automatic
        #else
        .topBarTrailing
        #endif
    }

    func getColor(for details: Details, isBackground: Bool) -> Color {
        if isBackground {
            if details.isColorInverted {
                Color.white
            } else {
                details.color
            }
        } else {
            if details.isColorInverted {
                details.color
            } else {
                Color.white
            }
        }
    }
}

#if DEBUG
#Preview {
    DetailView(router: PreviewRouter<DetailRoute>().routerBinding, index: 0)
}
#endif
