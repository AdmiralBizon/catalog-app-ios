import Resources
import Services
import SwiftUI

/// View for displaying images with support for asynchronous loading.
public struct ImageView: View {

    // MARK: - Private Properties

    private let imageUrl: String
    private let imageSize: CGSize

    @State private var image: Image?
    @State private var isLoading = true

    // MARK: - Initialization

    public init(imageUrl: String, imageSize: CGSize) {
        self.imageUrl = imageUrl
        self.imageSize = imageSize
    }

    // MARK: - Body

    public var body: some View {
        contentView()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: imageSize.width, height: imageSize.height)
            .padding(.bottom, 8)
            .cornerRadius(4)
    }

}

// MARK: - View Builders

private extension ImageView {

    @ViewBuilder
    func contentView() -> some View {
        if let image {
            image
                .resizable()
        } else if isLoading {
            Colors.Product.imageBackground
                .shimmer()
                .onAppear {
                    loadImage()
                }
        } else {
            Colors.Product.imageBackground
        }
    }

}

// MARK: - Private Methods

private extension ImageView {

    func loadImage() {
        Task {
            do {
                let image = try await ImageLoader.shared.loadImage(path: imageUrl)
                await MainActor.run {
                    self.image = image
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }

}
