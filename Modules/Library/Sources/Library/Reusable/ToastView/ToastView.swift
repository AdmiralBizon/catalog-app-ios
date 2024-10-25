import Resources
import SwiftUI

/// A view component for displaying toast alerts with customizable message and style.
struct ToastView: View {
    
    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 8
    }

    // MARK: - Private Properties

    private let style: ToastStyle
    private let message: String
    private let didTapClose: () -> Void

    // MARK: - Initialization

    init(style: ToastStyle, message: String, didTapClose: @escaping () -> Void) {
        self.style = style
        self.message = message
        self.didTapClose = didTapClose
    }

    // MARK: - Body

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            style.config.icon
                .foregroundColor(style.config.themeColor)

            Text(message)
                .font(.caption)
                .foregroundColor(Colors.Text.main)

            Spacer(minLength: 10)

            Button(action: didTapClose) {
                Image(systemName: "xmark")
                    .foregroundColor(style.config.themeColor)
            }
        }
        .padding()
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(style.config.themeColor, lineWidth: 1)

                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .foregroundColor(Colors.Product.background)
            }
        }
        .padding(.horizontal)
    }

}
