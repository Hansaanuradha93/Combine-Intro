import Combine
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let perPage = 10
}

// MARK: - Methods
extension NetworkManager {
    
    func fetchCompanies() -> Future <[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(["Apple", "Google", "Facebook", "Microsoft"]))
            }
        }
    }

    
    func getFollwers(for username: String, page: Int) -> AnyPublisher<[Follower], Never> {
        let endPoint = GithubEndPoint.followers(username: username, perPage: perPage, page: page)
        let url = endPoint.url

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Follower].self, decoder: JSONDecoder())
            .replaceError(with: [Follower]())
            .eraseToAnyPublisher()
    }
}
