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
    
    
    func getCovidData(completed: @escaping (Result<User, Error>) -> Void) {
//        let endPoint = GithubEndPoint.user(username: username)
        let url = URL(string: "https://api.coronavirus.data.gov.uk/v1/data")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
//                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
//                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
//                let json = try decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//                let user = try decoder.decode(User.self, from: data)
//                completed(.success(user))
            } catch let error {
                print("Error: \(error)")
//                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
}
