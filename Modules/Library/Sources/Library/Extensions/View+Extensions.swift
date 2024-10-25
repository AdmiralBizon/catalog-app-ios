import Core
import SwiftUI

public extension View {

    /// Customizes the appearance of a tab item based on the selected tab.
    func customTabItem(tab: AppTab, isSelected: Bool) -> some View {
        modifier(CustomTabItem(tab: tab, isSelected: isSelected))
    }

    /// Applies an animated shimmer effect to the current view.
    func shimmer() -> some View {
        modifier(Shimmer())
    }

    /// Displays toast alert messages in the current view.
    func toastView(toast: Binding<Toast?>) -> some View {
        modifier(ToastItem(toast: toast))
    }

}
