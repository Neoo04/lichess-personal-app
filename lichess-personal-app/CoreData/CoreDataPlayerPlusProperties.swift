import Foundation
import CoreData

extension CoreDataPlayer {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPlayer> {
        return NSFetchRequest<CoreDataPlayer>(entityName: "CoreDataPlayer")
    }
    
    @NSManaged public var name: String?
}

extension CoreDataPlayer: Identifiable {
    
}
