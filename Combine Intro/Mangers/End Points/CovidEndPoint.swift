import Foundation

// MARK: Cases
enum CovidEndPoint {
    case data
}


// MARK: - Scheme
extension CovidEndPoint {
    private var scheme: String { return "https" }
}


// MARK: - Host
extension CovidEndPoint {
    private var host: String { return "api.coronavirus.data.gov.uk" }
}


// MARK: - Path
extension CovidEndPoint {
    
    private var path: String {
        switch self {
        case .data: return "/v1/data"
        }
    }
}


// MARK: - Parameters
extension CovidEndPoint {
    
    private var parameters: [String : Any] {
        switch self {
        case .data: return ["":""]
        }
    }
}


// MARK: - Query Components
extension CovidEndPoint {
    
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
extension CovidEndPoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryComponents
        return components.url!
    }
}
