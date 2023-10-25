import Foundation

struct LichessApiConfiguration {

    func getSpecificTeam(_ idTeam: String) -> URL {
        return URL(string: "https://lichess.org/api/team/\(idTeam)")!
    }

    func getAllTeams() ->URL {
        return URL(string: "https://lichess.org/api/team/all")!
    }
}
