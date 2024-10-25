import Resources
import SwiftUI

/// View for displaying the main content of a product.
public struct ProductCardView: View {

    // MARK: - Constants

    private enum Constants {
        static let imageSize = CGSize(width: 64, height: 64)
    }

    // MARK: - Private Properties

    private let imageUrl: String
    private let title: String
    private let price: Double
    private let stock: Int

    // MARK: - Initialization

    public init(imageUrl: String, title: String, price: Double, stock: Int) {
        self.imageUrl = imageUrl
        self.title = title
        self.price = price
        self.stock = stock
    }

    // MARK: - Body

    public var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Colors.Product.background)

            VStack(alignment: .leading, spacing: 0) {
                ImageView(imageUrl: imageUrl, imageSize: Constants.imageSize)

                Text(title)
                    .font(.body)
                    .foregroundStyle(Colors.Text.main)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Text("$\(String(format: "%.2f", price))")
                        .font(.headline)

                    Text("In stock: \(stock)")
                        .font(.footnote)
                        .foregroundStyle(Colors.Text.support)
                }
            }
            .padding(8)
        }
    }

}
