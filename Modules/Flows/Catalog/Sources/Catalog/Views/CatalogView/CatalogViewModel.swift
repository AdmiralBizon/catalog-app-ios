import Foundation
import Library
import Models
import Services

/// ViewModel for managing the catalog tab's root view.
/// This ViewModel handles user interactions such as fetching new data, refreshing the product list,
/// and manipulating the view's state to reflect changes in the data or user actions.
final class CatalogViewModel: ObservableObject {

    // MARK: - Constants

    private enum Constants {
        static let loadThreshold = 5
        static let pageLimit = 20
    }

    // MARK: - Properties

    @Published private(set) var viewState: ViewState = .loading
    @Published private(set) var paginationState: PaginationState = .notActive
    @Published private(set) var products: [ProductEntity] = []
    @Published private(set) var errorMessage: String?

    var hasMoreProducts: Bool {
        productsTotalCount > products.count
    }

    // MARK: - Private Properties

    private var paginationPointer: Int?
    private var productsTotalCount = 0
    private var isRefreshing = false
    private var fetchTask: Task<Void, Never>? {
        willSet {
            if let task = fetchTask {
                if task.isCancelled { return }
                task.cancel()
            }
        }
    }

    private let paginationManager: CatalogPaginationManagerInterface = CatalogPaginationManager(
        pageLimit: Constants.pageLimit,
        dataService: ProductsDataService()
    )

    // MARK: - Methods

    /// Fetches the initial list of products when the screen is initialized.
    /// Resets the pagination pointer and triggers the product fetching process
    /// with a flag indicating that this is the initial fetch.
    func initialFetch() {
        paginationPointer = nil
        fetchProducts(isInitialFetch: true)
    }

    /// Attempts to fetch the next portion of products when an item appears in the view.
    /// Checks if loading the next page is necessary based on the current item’s position
    /// in the list and triggers the fetch process if applicable.
    func onItemAppear(_ product: ProductEntity) {
        guard shouldLoadNextPage(currentItem: product) else {
            return
        }

        fetchProducts(isInitialFetch: false)
    }

    /// Asynchronously refreshes the list of products.
    /// Cancels any ongoing fetch tasks, resets the pagination pointer,
    /// and initiates a new fetch for the product list.
    /// Ensures that refresh operations do not overlap by checking the isRefreshing flag.
    ///
    /// Called when user used pull-to-refresh feature.
    func refreshProducts() async {
        guard !isRefreshing else { return }

        isRefreshing = true
        paginationPointer = nil
        fetchTask?.cancel()
        try? await fetchProductsAsync(isNeedShowToast: true)
        isRefreshing = false
    }

    /// Retries fetching the product list after a failure.
    /// This function triggers the fetch process for the product list,
    /// using the current pagination state without resetting it.
    func retry() {
        fetchProducts(isInitialFetch: false)
    }

}

// MARK: - Private Methods

private extension CatalogViewModel {

    func shouldLoadNextPage(currentItem: ProductEntity) -> Bool {
        /// Checks if the next page of products is available and that no active requests are currently in progress.
        guard
            hasMoreProducts,
            paginationState == .notActive,
            viewState != .loading,
            !isRefreshing,
            let currentItemIndex = products.firstIndex(where: { $0.id == currentItem.id })
        else {
            return false
        }

        /// Determines whether to start loading more products based on the current item's position.
        /// Loads more products if the current item is within the threshold value of the last item in the list.
        let thresholdIndex = (paginationPointer ?? 0) - Constants.loadThreshold
        return currentItemIndex >= thresholdIndex
    }

    func fetchProducts(isInitialFetch: Bool) {
        fetchTask = Task {
            await MainActor.run {
                /// Update view state to show shimmers grid or pagination state to show loader at the end of list.
                if isInitialFetch {
                    viewState = .loading
                } else {
                    paginationState = .loading
                }
            }

            do {
                try await fetchProductsAsync(isNeedShowToast: !isInitialFetch)
                await MainActor.run {
                    /// Set content states after success fetch.
                    if isInitialFetch {
                        viewState = .content
                    } else {
                        paginationState = .notActive
                    }
                }
            } catch {
                if Task.isCancelled { return }

                await MainActor.run {
                    /// Set error states after failure.
                    if isInitialFetch {
                        viewState = .error
                    } else {
                        paginationState = .error
                    }
                }
            }
        }
    }

    func fetchProductsAsync(isNeedShowToast: Bool) async throws {
        do {
            let response = try await paginationManager.fetchNextPage(after: paginationPointer)
            await MainActor.run {
                productsTotalCount = response.total
                paginationPointer = response.products.last?.id
                products += response.products
            }
        } catch {
            if isNeedShowToast {
                await MainActor.run {
                    errorMessage = "Something goes wrong. Please try again!"
                }
            }
            throw error
        }
    }

}
