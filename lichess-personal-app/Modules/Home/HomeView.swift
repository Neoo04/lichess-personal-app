//
//  ContentView.swift
//  lichess-personal-app
//
//  Created by generic dev on 10/17/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject
    private var viewModel: HomeDisplayViewModel
    
    init() {
        @Inject var viewModel: HomeDisplayViewModel
        self.viewModel = viewModel
        viewModel.fetchSpecies()
    }
    
    var body: some View {
        switch viewModel.state {
        case .error: Button { viewModel.fetchSpecies()} label: {
            Text("Try again")
        }
        case .success(withPlayers: let players): produceSuccessView(withPlayers: players)
        case .loading: ProgressView()
        case .none: EmptyView()
        }
    }
    
    @ViewBuilder
    
    func produceSuccessView(withPlayers players: [Player]) -> some View {
        List(players) { player in
            Button {
                viewModel.onSelectedplayer(player)
            } label: {
                Text(player.id)
            }
        }
    }
}
