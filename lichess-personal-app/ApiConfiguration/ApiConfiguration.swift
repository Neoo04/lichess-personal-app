import Foundation

struct LichessApiConfiguration {
    func getUrl() -> URL {
        return URL(string: "https://lichess.org/api/player")!
    }
}
