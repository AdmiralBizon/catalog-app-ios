import NetworkLayer
import SwiftUI

/// Service responsible for loading images from various sources and caching them
/// to improve performance and reduce network usage.
public final class ImageLoader {

    public static let shared = ImageLoader()
    
    private var imageCache: NSCache<NSString, UIImage>
    private let session: URLSession

    private init() {
        let memoryLimit = 50 * 1024 * 1024 /// default 50MB cache limit
        imageCache = NSCache<NSString, UIImage>()
        imageCache.totalCostLimit = memoryLimit

        session = URLSession(configuration: .default)
    }

    public func loadImage(path: String) async throws -> Image {
        guard let imageUrl = URL(string: path) else {
            throw APIError.invalidURL
        }

        /// Check if the image is already cached.
        if let cachedImage = imageCache.object(forKey: path as NSString) {
            return Image(uiImage: cachedImage)
        }

        /// Fetch the image from the network.
        let request = URLRequest(url: imageUrl)
        let (data, _) = try await URLSession.shared.data(for: request)

        /// Cache the image.
        if let loadedImage = UIImage(data: data) {
            imageCache.setObject(loadedImage, forKey: path as NSString)
            return Image(uiImage: loadedImage)
        } else {
            throw APIError.invalidResponse
        }
    }

}
