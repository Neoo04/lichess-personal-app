import Foundation
import Combine

protocol LichessSelectedPlayerRepositoryContract {
    func assignSelectedplayer(_ idPlayer: String)
    func fetchSelectedPlayer() -> AnyPublisher<DetailedPlayer, Error>
}

class LichessSelectedPlayerRepository: LichessSelectedPlayerRepositoryContract{

    private let apiConfiguration = LichessApiConfiguration()

    @Inject
    private var decoder: JSONDecoder

    @Inject
    private var session: URLSession

    private var storedPlayer: String? = "Crecent"
    
    func assignSelectedplayer(_ idPlayer: String) {
        storedPlayer = idPlayer
    }
    
    func fetchSelectedPlayer() -> AnyPublisher<DetailedPlayer, Error> {
        let detailedPlayer = session.dataTaskPublisher(for: apiConfiguration.getSelectedPlayerUrl(storedPlayer ?? ""))
            .map(\.data)
            .decode(type: DetailedPlayer.self, decoder: decoder)
            .eraseToAnyPublisher()
        return detailedPlayer
    }
}
