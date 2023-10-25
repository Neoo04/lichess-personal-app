import SwiftUI

struct TeamView: View {

    @ObservedObject
    private var viewModel: TeamViewModel
    
    init() {
        @Inject var viewModel: TeamViewModel
        self.viewModel = viewModel
        viewModel.fetchSpecificTeam()
    }

    var body: some View {
        switch viewModel.state {
        case .error: Button { viewModel.fetchSpecificTeam()} label: {
            Text("Try again")
        }
        case .success(withTeam: let team): produceSuccessView(withTeam: team)
        case .loading: ProgressView()
        case .none: EmptyView()
        }
    }

    @ViewBuilder
    
    func produceSuccessView(withTeam team: LichessTeam) -> some View {
        Text("\(team.name!) has \(team.nbMembers!) members ")
    }
}
