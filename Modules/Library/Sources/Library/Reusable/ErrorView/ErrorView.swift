import Resources
import SwiftUI

/// Fullscreen view designed to display an error state.
/// Includes a button with a customizable action for the user to take,
/// allowing them to retry or navigate away from the error state.
public struct ErrorView: View {

    // MARK: - Private Properties

    private let primaryAction: (() -> Void)?

    // MARK: - Initialization

    public init(primaryAction: (() -> Void)?) {
        self.primaryAction = primaryAction
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text("Oops 😢")
                .font(.title3)
                .foregroundStyle(Colors.Text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 24)

            Text("Something goes wrong")
                .font(.subheadline)
                .foregroundStyle(Colors.Text.support)
                .multilineTextAlignment(.center)
                .padding(.top, 12)

            Button {
                primaryAction?()
            } label: {
                Text("Reload")
                    .font(.caption2)
                    .foregroundStyle(Colors.Buttons.text)
                    .frame(width: 130, height: 20)
                    .padding(8)
                    .background(Colors.Buttons.background)
                    .cornerRadius(8)
            }
            .padding(.top, 24)

            Spacer()
        }
        .padding()
    }

}
