import Library
import Models
import Resources
import SwiftUI

/// Root view for the catalog tab, serving as the main interface for browsing products.
public struct CatalogView: View {

    // MARK: - Constants

    private enum Constants {
        static let defaultPaddingValue: CGFloat = 16
        static let productCardWidth: CGFloat = (UIScreen.main.bounds.width - 48) / 2
    }

    // MARK: - Private Properties

    @StateObject private var viewModel: CatalogViewModel
    @State private var toast: Toast?

    private let shimmersColumns = [
        GridItem(.flexible(), spacing: Constants.defaultPaddingValue, alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]

    private let productsListColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Initialization

    public init() {
        _viewModel = StateObject(wrappedValue: CatalogViewModel())
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            contentView()
                .navigationTitle("Catalog")
                .navigationBarTitleDisplayMode(.inline)
                .toastView(toast: $toast)
                .onReceive(viewModel.$errorMessage) { message in
                    guard let message else { return }
                    toast = Toast(style: .error, message: message)
                }
                .onAppear {
                    viewModel.initialFetch()
                }
        }
    }

}

// MARK: - View Builders

private extension CatalogView {

    // MARK: Containers

    @ViewBuilder
    func contentView() -> some View {
        switch viewModel.viewState {
        case .content:
            productsListView()
        case .loading:
            loadingView()
        case .error:
            errorView()
        }
    }

    @ViewBuilder
    func errorView() -> some View {
        ErrorView(
            primaryAction: { viewModel.initialFetch() }
        )
    }

    @ViewBuilder
    func loadingView() -> some View {
        ScrollView {
            LazyVGrid(columns: shimmersColumns, alignment: .center, spacing: 16) {
                ForEach(0..<12) { _ in
                    shimmerView()
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.bottom, Constants.defaultPaddingValue)
        .padding(.horizontal, Constants.defaultPaddingValue)
    }

    @ViewBuilder
    func productsListView() -> some View {
        if !viewModel.products.isEmpty {
            ScrollView {
                VStack(spacing: 0) {
                    LazyVGrid(columns: productsListColumns, spacing: 16) {
                        ForEach(viewModel.products) { product in
                            productView(product)
                                .onAppear {
                                    viewModel.onItemAppear(product)
                                }
                        }

                    }

                    paginationView()
                        .padding(.top, 20)
                }
            }
            .scrollIndicators(.never)
            .padding(Constants.defaultPaddingValue)
            .refreshable {
                await viewModel.refreshProducts()
            }
        }
    }

    // MARK: Cells

    func shimmerView() -> some View {
        Colors.Product.imageBackground
            .frame(width: Constants.productCardWidth, height: 120)
            .shimmer()
    }

    func productView(_ product: ProductEntity) -> some View {
        ProductCardView(
            imageUrl: product.images.first ?? "",
            title: product.title,
            price: product.price,
            stock: product.stock
        )
        .frame(width: Constants.productCardWidth, alignment: .leading)
    }

    @ViewBuilder
    func paginationView() -> some View {
        if viewModel.paginationState == .loading {
            ProgressView()
                .tint(Colors.Text.main)
        } else if viewModel.paginationState == .error {
            Button(action: viewModel.retry) {
                Label("Retry", systemImage: "arrow.clockwise")
                    .foregroundColor(Colors.Text.main)
                    .padding()
            }
        }
    }

}
