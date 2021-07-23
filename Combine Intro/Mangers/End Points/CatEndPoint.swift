import Foundation

// MARK: Cases
enum CatEndPoint {
    case facts
    case users
}


// MARK: - Scheme
extension CatEndPoint {
    private var scheme: String { return "https" }
}


// MARK: - Host
extension CatEndPoint {
    private var host: String { return "cat-fact.herokuapp.com" }
}


// MARK: - Path
extension CatEndPoint {
    
    private var path: String {
        switch self {
        case .facts: return "/facts "
        case .users: return "/users"
        }
    }
}


// MARK: - Parameters
extension CatEndPoint {
    
    private var parameters: [String : Any] {
        switch self {
        case .facts: return ["":""]
        case .users: return ["":""]
        }
    }
}


// MARK: - Query Components
extension CatEndPoint {
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        for(key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
}


// MARK: - Url
extension CatEndPoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryComponents
        return components.url!
    }
}
