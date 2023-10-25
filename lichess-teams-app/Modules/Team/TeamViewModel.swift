import Foundation
import Combine

class TeamViewModel: ObservableObject {
    
    @Inject
    private var navigationDelegate: any MainNavigationDelegate

    private var subscriptions: Set<AnyCancellable> = []

    @Inject
    private var repository: any LichessSelectedTeamRepositoryContract
    
    @Published var state: selectedTeamState = .none
    
    func fetchSpecificTeam() {
        if case .success = state {
            return
        }
        if case .loading = state {
            return
        }
        state = .loading
        repository.fetchSelectedTeam()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] completion in
                switch completion {
                case .finished : break
                case .failure(_):
                    self?.state = .error
                }
            } receiveValue: { [weak self] team in
                if team.name != nil {
                    self?.state = .success(withTeam: team)
                } else {
                    self?.state = .error

                }
            }
            .store(in: &subscriptions)
    }
}

enum selectedTeamState {
    case none, loading, error, success(withTeam: LichessTeam)
}
