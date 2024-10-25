import Models

/// Protocol defining the interface for product data services.
public protocol ProductsDataServiceInterface {
    func fetchProducts(after pointer: Int?, limit: Int?) async throws -> ProductsResponseEntity
}
