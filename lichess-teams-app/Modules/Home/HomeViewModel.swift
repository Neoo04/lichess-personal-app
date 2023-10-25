import Foundation
import Combine
class HomeViewModel: ObservableObject {
    
    @Inject
    private var navigationDelegate: any MainNavigationDelegate

    private var subscriptions: Set<AnyCancellable> = []

    @Inject
    private var repository: any LichessTeamsRepositoryContract

    @Inject
    private var selectedTeamRepository: any LichessSelectedTeamRepositoryContract
    
    @Published var state: teamsState = .none
    
    func fetchTeams() {
        if case .success = state {
            return
        }
        if case .loading = state {
            return
        }
        state = .loading
        repository.fetchAllTeams()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] completion in
                switch completion {
                case .finished : break
                case .failure(_):
                    self?.state = .error
                }
            } receiveValue: { [weak self] teams in
                if teams.isEmpty {
                    self?.state = .error
                } else {
                    self?.state = .success(withTeams: teams)
                }
            }
            .store(in: &subscriptions)
    }
    
    func onSearchTeamClicked(_ teamName: String){
        selectedTeamRepository.assignSelectedTeam(teamName)
        navigationDelegate.push(destination: .team)
    }
}

enum teamsState {
    case none, loading, error, success(withTeams: [LichessTeam])
}
