import Foundation

struct LichessApiResponse: Decodable {
    let bullet: [Player]
}

struct Player: Codable, Identifiable {
    let name: String
    var id: String { name }
}
