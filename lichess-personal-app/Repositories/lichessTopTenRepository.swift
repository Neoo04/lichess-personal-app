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

    @Inject
    private var localDataSource: LichessTopTenSourceContract

    func fetchTopTen() -> AnyPublisher<[Player], Error> {
        debugPrint(session.dataTaskPublisher(for: apiConfiguration.getUrl())
            .map(\.data)
            .decode(type: LichessApiResponse.self, decoder: decoder))
        if let players = fetchLocalPlayers() {
            return Future<[Player], Error> { promise in
                promise(.success(players))
            }.eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: apiConfiguration.getUrl())
            .map(\.data)
            .decode(type: LichessApiResponse.self, decoder: decoder)
            .map(\.bullet)
            .map { [weak self ] players in
                self?.localDataSource.persist(players: players)
                return players
                
            }
            .eraseToAnyPublisher()
    }
    
    func fetchLocalPlayers() ->[Player]? {
        if let players = localDataSource.fetchAll(), !players.isEmpty {
            return players
        } else {
            return nil
        }
    }
}
