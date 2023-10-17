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
    }
}