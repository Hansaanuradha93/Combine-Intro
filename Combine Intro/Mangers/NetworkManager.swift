import Combine
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let perPage = 10
    private let companies = ["Apple", "Google", "Facebook", "Microsoft"]
}

// MARK: - Methods
extension NetworkManager {
    
    func fetchCompanies() -> Future <[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(self.companies))
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
    
    
    func getUserInfo(for username: String) -> AnyPublisher<User, Never> {
        let endPoint = GithubEndPoint.user(username: username)
        let url = endPoint.url
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode (type: User.self, decoder: JSONDecoder())
            .replaceError(with: User(login: "", avatarUrl: "", name: "", location: "", bio: "", company: "", email: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date()))
            .eraseToAnyPublisher()
    }
    
    
    func getFacts() -> AnyPublisher<[Fact], Never> {
        let endPoint = CatEndPoint.facts
        let url = endPoint.url
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Fact].self, decoder: JSONDecoder())
            .replaceError(with: [Fact]())
            .eraseToAnyPublisher()
    }
    
    func getCovidData() -> AnyPublisher <CovidInfo, Never> {
        let endPoint = CovidEndPoint.data
        let url = endPoint.url
        let sampleDate = CovidInfo(length: nil, maxPageLimit: nil, totalRecords: nil, data: nil)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CovidInfo.self, decoder: JSONDecoder())
            .replaceError(with: sampleDate)
            .eraseToAnyPublisher()
    }

    
    
}
