import Foundation
import Combine

protocol NavigationDelegate {
    associatedtype T where T: Hashable
    func pop(last k: Int)
    func popToRoot()
    func push(destination: T)
}

protocol NavigationPublisher: ObservableObject {
    associatedtype T where T: Hashable
    var path: Published<[T]>.Publisher { get }
}
