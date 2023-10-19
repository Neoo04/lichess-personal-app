import Foundation
import Combine

protocol LichessTopTenRepositoryContract {
    func fetchTopTen() -> AnyPublisher<[Player], Error>
}

class LichessTopTenRepository: LichessTopTenRepositoryContract{
    
    private let apiConfiguration = LichessApiConfiguration()

    @Inject
    private var decoder: JSONDecoder

    @Inject
    private var session: URLSession

    func fetchTopTen() -> AnyPublisher<[Player], Error> {
        let players = session.dataTaskPublisher(for: apiConfiguration.getPlayersApiUrl())
            .map(\.data)
            .decode(type: LichessApiResponse.self, decoder: decoder)
            .map(\.bullet)
            .map({[weak self] players in
                return players
            })
            .eraseToAnyPublisher()
        return players
    }
}
