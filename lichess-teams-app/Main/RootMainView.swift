import SwiftUI

struct RootMainView: View {
    @ObservedObject
    private var navigationManager = MainNavigationManager()

    init() {
        @Inject var navigationManager: MainNavigationManager
        self.navigationManager = navigationManager
    }

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            HomeView()
                .navigationDestination(for: Destinations.self) { destination in
                        switch destination {
                        case .home: HomeView()
                        case .team: TeamView()
                        case .detailedPlayer: DetailedPlayerView()
                    }
                    
                }
        }
    }
}
