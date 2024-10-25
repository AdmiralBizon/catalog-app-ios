import Models
import Services

/// Manager responsible for handling pagination of the products list in the catalog.
final class CatalogPaginationManager: CatalogPaginationManagerInterface {

    // MARK: - Private Properties

    private let pageLimit: Int
    private let dataService: ProductsDataServiceInterface

    // MARK: - Initialization

    init(pageLimit: Int, dataService: ProductsDataServiceInterface) {
        self.pageLimit = pageLimit
        self.dataService = dataService
    }

    // MARK: - CatalogPaginationManagerInterface

    func fetchNextPage(after pointer: Int?) async throws -> ProductsResponseEntity {
        try await dataService.fetchProducts(after: pointer, limit: pageLimit)
    }

}
