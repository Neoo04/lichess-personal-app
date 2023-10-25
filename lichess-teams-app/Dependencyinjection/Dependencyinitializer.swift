import Foundation
import CoreData

class DependencyInitializer {
    static let container = Container()

    init() {
        addDependencies(to: DependencyInitializer.container)
    }

    func addDependencies( to container: Container) {
        let mainNavigationManager = MainNavigationManager()
        container.register(MainNavigationManager.self, factory: { mainNavigationManager })
        container.register((any MainNavigationDelegate).self, factory: {
            mainNavigationManager
        })
        
        container.register(URLSession.self) { URLSession.shared }
        container.register(JSONDecoder.self) { JSONDecoder() }
        
        let selectedTeamRepository = LichessSelectedTeamRepository()
        container.register(LichessSelectedTeamRepositoryContract.self) { selectedTeamRepository }

        let teamsRepository = LichessTeamsRepositiry()
        container.register(LichessTeamsRepositoryContract.self) { teamsRepository }

        let homeViewModel = HomeViewModel()
        container.register(HomeViewModel.self) { homeViewModel }

        let teamViewModel = TeamViewModel()
        container.register(TeamViewModel.self) { teamViewModel }


    }
}
