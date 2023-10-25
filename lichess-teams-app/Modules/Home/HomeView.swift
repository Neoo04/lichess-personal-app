//
//  ContentView.swift
//  lichess-teams-app
//
//  Created by generic dev on 10/20/23.
//

import SwiftUI

struct HomeView: View {
    @State private var teamName: String = ""

    @ObservedObject
    private var viewModel: HomeViewModel
    
    init() {
        @Inject var viewModel: HomeViewModel
        self.viewModel = viewModel
        viewModel.fetchTeams()
    }

    var body: some View {
        switch viewModel.state {
        case .error: Button { viewModel.fetchTeams()} label: {
            Text("Try again")
        }
        case .success(withTeams: let teams): produceSuccessView(withTeams: teams)
        case .loading: ProgressView()
        case .none: EmptyView()
        }
    }

    @ViewBuilder
    
    func produceSuccessView(withTeams teams: [LichessTeam]) -> some View {
        List(teams) { team in
            Button {
                viewModel.onSearchTeamClicked(team.name!)
            } label: {
                Text(team.name!)
            }
        }
    }
}
