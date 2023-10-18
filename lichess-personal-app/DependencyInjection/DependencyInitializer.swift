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
        
        container.register(UserDefaults.self) { UserDefaults.standard }
        container.register(URLSession.self) { URLSession.shared }
        container.register(JSONDecoder.self) { JSONDecoder() }
        container.register(NSManagedObjectContext.self) { PersistenceController.shared.container.viewContext }
        container.register(LichessTopTenRepositoryContract.self) { LichessTopTenRepository() }
        container.register(LichessTopTenSourceContract.self) { LichessTopTenSource() }
        container.register(HomeDisplayViewModel.self) { HomeDisplayViewModel() }
        let homeDisplayViewModel = HomeDisplayViewModel()
        container.register(HomeDisplayViewModel.self) { homeDisplayViewModel }






    }
}
