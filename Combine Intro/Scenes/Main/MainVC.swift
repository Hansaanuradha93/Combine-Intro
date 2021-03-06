import UIKit
import Combine

class MainVC: UIViewController {
    
    // MARK: Properties
    private let tableView = UITableView()
    private var observers: [AnyCancellable] = []
    private var companies: [String] = []
    private var followers: [Follower] = []
    private var facts: [Fact] = []
    private var username = "SAllen0400"

    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        fetchCompanies()
        fetchFollowers()
        fetchUserInfo()
        fetchCatFacts()
        fetchCovidData()
    }
}


// MARK: - TableView Datasource
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId, for: indexPath) as! MainTableViewCell
        cell.action.sink { value in
            print(value)
        }.store(in: &observers)
        cell.textLabel?.text = followers[indexPath.row].login
        return cell
    }
}


// MARK: - Private Methods
private extension MainVC {
    
    func fetchCovidData() {
        NetworkManager.shared.getCovidData()
            .receive(on: DispatchQueue.main)
            .sink { values in
                print(values)
            }
            .store(in: &observers)
    }
    
    
    func fetchCompanies() {
        NetworkManager.shared.fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error: \(error)")
                }
            }, receiveValue: { [weak self] values in
                guard let self = self else { return }
                self.companies = values
                self.tableView.reloadData()
            })
            .store(in: &observers)
    }
    
    
    func fetchFollowers() {
        NetworkManager.shared.getFollwers(for: username, page: 20)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] values in
                guard let self = self else { return }
                self.followers = values
                self.tableView.reloadData()
            }
            .store(in: &observers)
    }
    
    
    func fetchUserInfo() {
        NetworkManager.shared.getUserInfo(for: username)
            .receive(on: DispatchQueue.main)
            .sink { value in
                print("User: \(value)")
            }
            .store(in: &observers)
    }
    
    
    func fetchCatFacts() {
        NetworkManager.shared.getFacts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] values in
                guard let self = self else { return }
                self.facts = values
            }
            .store(in: &observers)
    }
    
    
    func configureViews() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseId)
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}
