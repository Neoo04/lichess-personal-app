import Foundation
import Combine

protocol LichessSelectedTeamRepositoryContract {
    func assignSelectedTeam(_ idTeam: String)
    func fetchSelectedTeam() -> AnyPublisher<LichessTeam, Error>
}

class LichessSelectedTeamRepository: LichessSelectedTeamRepositoryContract{

    private let apiConfiguration = LichessApiConfiguration()

    @Inject
    private var decoder: JSONDecoder

    @Inject
    private var session: URLSession

    private var storedTeam: String? = "upgop"
    
    func assignSelectedTeam(_ idTeam: String) {
        storedTeam = idTeam.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    func fetchSelectedTeam() -> AnyPublisher<LichessTeam, Error> {
        let selectedTeam = session.dataTaskPublisher(for: apiConfiguration.getSpecificTeam(storedTeam ?? ""))
            .map(\.data)
            .decode(type: LichessTeam.self, decoder: decoder)
            .map({ team in
                return team
            })
            .eraseToAnyPublisher()
        
        return selectedTeam
    }
}
