import SwiftUI

@main
struct CatalogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .dynamicTypeSize(.xSmall ... .xLarge)
        }
    }
}
