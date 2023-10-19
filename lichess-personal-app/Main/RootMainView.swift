import SwiftUI

struct RootMainView: View {
    
    @ObservedObject
    private var navigationManager: MainNavigationManager
    
    init() {
        @Inject var navigationManager: MainNavigationManager
        self.navigationManager = navigationManager
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            HomeView()
                .navigationDestination(for: Destinations.self) { destination in
                    switch destination {
                    case .playerDetails: PlayerDetailsView()
                            .navigationTitle("Player ingormation")
                    }
                }
        }
        
    }
}
