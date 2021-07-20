import Combine
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
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
}
