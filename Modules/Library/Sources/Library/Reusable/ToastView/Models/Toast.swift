/// Model representing the information for a toast notification view.
public struct Toast: Equatable {
    let style: ToastStyle
    let message: String

    public init(style: ToastStyle, message: String) {
        self.style = style
        self.message = message
    }
}
