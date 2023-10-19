//
//  PlayerDetailsViewModel.swift
//  lichess-personal-app
//
//  Created by generic dev on 10/18/23.
//

import Foundation
import Combine

class PlayerDetailsViewModel: ObservableObject {

    private var subscriptions: Set<AnyCancellable> = []

    @Inject
    private var repository: LichessSelectedPlayerRepositoryContract

    @Inject
    private var navigationDelegate: any MainNavigationDelegate

    @Published var state: PlayerDetailsState = .none
    
    func fetchPlayerDetails(){

        if case .success = state {
            return
        }

        if case .loading = state {
            return
        }
        repository.fetchSelectedPlayer()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] completion in
                switch completion {
                    case .finished: break
                    case .failure(_):
                    self?.state = .error
                    DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                        self?.navigationDelegate.pop(last: 1)
                    }
                    
                }
                
            } receiveValue: { [weak self] player in
                self?.state = .success(withPlayer: player)
            }
            .store(in: &subscriptions)
        
    }
}

enum PlayerDetailsState {
    case none, loading, error, success(withPlayer: DetailedPlayer)
}
