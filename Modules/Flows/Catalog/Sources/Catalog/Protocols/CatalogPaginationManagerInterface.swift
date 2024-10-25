import Models

/// Protocol for manager responsible for handling pagination of the products list in the catalog.
protocol CatalogPaginationManagerInterface {
    func fetchNextPage(after pointer: Int?) async throws -> ProductsResponseEntity
}
