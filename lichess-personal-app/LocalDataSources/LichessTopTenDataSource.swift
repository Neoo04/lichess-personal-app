import Foundation
import CoreData

protocol LichessTopTenSourceContract {
    func fetchAll() -> [Player]?
    func persist(players: [Player])
}

class LichessTopTenSource: LichessTopTenSourceContract {
    
    @Inject
    private var persistanceContext: NSManagedObjectContext
    
    func fetchAll() -> [Player]? {
        do {
            
            let persistedPlayers = try
            persistanceContext.fetch(CoreDataPlayer.fetchRequest())
            return persistedPlayers.compactMap{ coreDataPlayer in
                if  let name = coreDataPlayer.name {
                    return Player(name: name)
                }
                return nil
            }
        } catch {
            return nil
        }
    }

    func persist(players: [Player]) {
        players.forEach { player in
            let persisablePlayer = CoreDataPlayer(context: persistanceContext)
            persisablePlayer.name = player.id
        }
        do {
            try persistanceContext.save()
        } catch {
            print("There was an error storing the species to core data")
        }
    }
}
