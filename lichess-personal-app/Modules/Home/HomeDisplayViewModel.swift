import Foundation
import Combine

class HomeDisplayViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Inject
    private var navigationDelegate: any MainNavigationDelegate

    @Inject
    private var repository: any LichessTopTenRepositoryContract

    @Inject
    private var lichessDetailedPlayerRepository: any LichessSelectedPlayerRepositoryContract

    @Published var state: PlayersState = .none

    func fetchSpecies() {
        if case .success = state {
            return
        }
        if case .loading = state {
            return
        }
        state = .loading
        repository.fetchTopTen()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] completion in
                switch completion {
                case .finished : break
                case .failure(_):
                    self?.state = .error
                }
            } receiveValue: { [weak self] players in
                if players.isEmpty {
                    self?.state = .error
                } else {
                    self?.state = .success(withPlayers: players)
                }
            }
            .store(in: &subscriptions)
    }
    
    func onSelectedplayer(_ playerId: String) {
        lichessDetailedPlayerRepository.assignSelectedplayer(playerId)
        self.navigationDelegate.push(destination: .playerDetails)
    }
    
}

enum PlayersState {
    case none, loading, error, success(withPlayers: [Player])
}
