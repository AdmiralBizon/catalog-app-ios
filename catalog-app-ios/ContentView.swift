import Catalog
import Core
import Library
import Resources
import SwiftUI

struct ContentView: View {
    
    // MARK: - Private Properties

    @State private var selectedTab: AppTab = .catalog

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            CatalogView()
                .customTabItem(tab: .catalog, isSelected: selectedTab == .catalog)
        }
        .accentColor(Colors.Text.main)
    }

}
