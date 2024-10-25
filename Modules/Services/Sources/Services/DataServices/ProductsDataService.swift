import Models
import NetworkLayer

/// Service for managing product data operations.
/// This class conforms to the `ProductsDataServiceInterface` and provides
/// functionality to fetch product data from the API.
public final class ProductsDataService: ProductsDataServiceInterface {

    public init() {}

    /// Asynchronously fetches products from the API.
    public func fetchProducts(after pointer: Int?, limit: Int?) async throws -> ProductsResponseEntity {
        let response = try await ProductsProvider.fetchProducts(after: pointer, limit: limit)
        return ProductsResponseEntity(response)
    }

}
