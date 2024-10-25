import SwiftUI

/// List of application tabs.
/// Every item has predefined configuration with icons and title.
public enum AppTab: Hashable {
    case catalog
}

public extension AppTab {

    // MARK: - Nested Types

    struct TabConfig {
        public let icon: Image
        public let selectedIcon: Image
        public let title: String
    }

    // MARK: - Properties

    var config: TabConfig {
        switch self {
        case .catalog:
            .init(
                icon: .init(systemName: "folder"),
                selectedIcon: .init(systemName: "folder.fill"),
                title: "Catalog"
            )
        }
    }

}
