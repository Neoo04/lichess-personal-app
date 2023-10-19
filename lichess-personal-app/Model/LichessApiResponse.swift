import Foundation

struct LichessApiResponse: Decodable {
    let bullet: [Player]
}

struct Player: Codable, Identifiable {
    let username: String
    var id: String { username }
}
