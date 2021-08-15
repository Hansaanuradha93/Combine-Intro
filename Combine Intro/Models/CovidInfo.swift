import Foundation

struct CovidInfo: Codable, Hashable {
    let length: Int?
    let maxPageLimit: Int?
    let totalRecords: Int?
    let data: [DailyRecord]?
    let test: Int? // remove it
}


struct DailyRecord: Codable, Hashable {
    let date: String?
    let name: String?
    let casesDaily: Int?
    let casesCumulative: Int?
    let deathsDaily: Int?
    let deathsCumulative: Int?
    let firstVaccinationsDaily: Int?
    let firstVaccinationsCumulative: Int?
    let secondVaccinationsDaily: Int?
    let secondVaccinationsCumulative: Int?
}
