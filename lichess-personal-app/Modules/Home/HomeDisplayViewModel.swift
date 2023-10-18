import Foundation
import Combine

class HomeDisplayViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Inject
    private var navigationDelegate: any MainNavigationDelegate

    @Inject
    private var repository: any LichessTopTenRepositoryContract

    @Published var state: PlayersStete = .none

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
    
    func onSelectedplayer(_ player: Player) {
        
    }
    
}

enum PlayersStete {
    case none, loading, error, success(withPlayers: [Player])
}
