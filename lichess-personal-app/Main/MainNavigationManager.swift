import Foundation

protocol MainNavigationDelegate: AnyObject, NavigationDelegate {
    func push(destination: Destinations)
}

class MainNavigationManager: MainNavigationDelegate, ObservableObject {
    typealias T = Destinations
    
    @Published var path: [Destinations] = []
    
    func push(destination: Destinations) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.path.append(destination)
        }
    }
    
    func popToRoot() {
        path = []
    }
    
    func pop(last k: Int) {
        for _ in 0..<k {
            if path.isEmpty {
                return
            }
            else {
                path.removeLast()
            }
        }
    }
}
