import SwiftUI

@main
struct lichess_teams_appApp: App {
    init() {
        _ = DependencyInitializer()
    }
    var body: some Scene {
        WindowGroup {
            RootMainView()
        }
    }
}
