import Foundation
import Combine

protocol LichessTeamsRepositoryContract {
    func fetchAllTeams() -> AnyPublisher<[LichessTeam], Error>
}

class LichessTeamsRepositiry: LichessTeamsRepositoryContract {

    private let apiConfiguration = LichessApiConfiguration()

    @Inject
    private var decoder: JSONDecoder

    @Inject
    private var session: URLSession
    
    func fetchAllTeams() -> AnyPublisher<[LichessTeam], Error> {
        let teams = session.dataTaskPublisher(for: apiConfiguration.getAllTeams())
            .map(\.data)
            .decode(type: LichessTeamsResponse.self, decoder: decoder)
            .map(\.currentPageResults)
            .map({teams in
                return teams
            })
            .eraseToAnyPublisher()
        return teams
    }
}
