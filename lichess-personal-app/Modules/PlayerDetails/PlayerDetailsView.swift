//
//  ContentView.swift
//  lichess-personal-app
//
//  Created by generic dev on 10/17/23.
//

import SwiftUI

struct PlayerDetailsView: View {
    
    @ObservedObject
    private var viewModel: PlayerDetailsViewModel

    init() {
        @Inject var viewModel: PlayerDetailsViewModel
        self.viewModel = viewModel
        viewModel.fetchPlayerDetails()
    }
    
    var body: some View {
        
        switch viewModel.state {
            
        case .error: Button { viewModel.fetchPlayerDetails()} label: {
            Text("Something went wrong, try again!")
            }
        case .loading: ProgressView()
        case .none: ProgressView()
        case .success(let detailedPlayer): produceSuccessView(detailedPlayer)
        }
    }

    @ViewBuilder
    func produceSuccessView(_ detailedPlayer: DetailedPlayer) -> some View{
        if let username = detailedPlayer.username {
            let title =  " is a/an  \(detailedPlayer.title ?? "untitled player")" 
            Text("The player \(username) " + title)
        } else {
            Button { viewModel.fetchPlayerDetails()} label: { Text("Something went wrong, try again!") }
        }

    }
}
