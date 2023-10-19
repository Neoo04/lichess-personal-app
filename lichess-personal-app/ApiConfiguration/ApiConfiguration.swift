import Foundation

struct LichessApiConfiguration {
    func getPlayersApiUrl() -> URL {
        return URL(string: "https://lichess.org/api/player")!
    }

    func getSelectedPlayerUrl(_ idPlayer: String) -> URL {
        return URL(string: "https://lichess.org/api/user/\(idPlayer)")!
    }
}


