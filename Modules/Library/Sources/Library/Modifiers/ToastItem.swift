import SwiftUI

/// View modifier for displaying toasts with customizable message and style.
struct ToastItem: ViewModifier {

    // MARK: - Constants

    private enum Constants {
        static let toastDuration = 5.0
    }

    // MARK: - Properties

    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    toastContentView()
                }
                .animation(.spring, value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }

}

// MARK: - View Builders

private extension ToastItem {

    @ViewBuilder
    func toastContentView() -> some View {
        if let toast {
            VStack(spacing: 0) {
                ToastView(
                    style: toast.style,
                    message: toast.message,
                    didTapClose: dismissToast
                )

                Spacer()
            }
            .offset(y: 10)
        }
    }

}

// MARK: - Actions

private extension ToastItem {

    func showToast() {
        guard toast != nil else { return }

        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        workItem?.cancel()

        let task = DispatchWorkItem {
            dismissToast()
        }

        workItem = task
        DispatchQueue.main.asyncAfter(
            deadline: .now() + Constants.toastDuration,
            execute: task
        )
    }

    func dismissToast() {
        withAnimation {
            toast = nil
        }

        workItem?.cancel()
        workItem = nil
    }

}
