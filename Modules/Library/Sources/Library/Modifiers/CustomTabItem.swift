import Core
import SwiftUI

/// View modifier for customizing the appearance and behavior of a view,
/// based on the specified tab configuration.
struct CustomTabItem: ViewModifier {
    let tab: AppTab
    let isSelected: Bool

    private var icon: Image {
        isSelected ? tab.config.selectedIcon : tab.config.icon
    }

    func body(content: Content) -> some View {
        content
            .tabItem {
                Label(
                    title: {
                        Text(tab.config.title)
                    },
                    icon: {
                        icon.renderingMode(.template)
                    }
                )
            }
            .tag(tab)
    }
}
