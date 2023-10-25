import Foundation
struct LichessTeamsResponse: Codable {
    let currentPageResults: [LichessTeam]
}
struct LichessTeam: Codable, Identifiable{
    let id: String?
    let name: String?
    let nbMembers: Int?
}
