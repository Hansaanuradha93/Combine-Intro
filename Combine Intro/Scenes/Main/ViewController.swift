import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseId)
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}


// MARK: - TableView Datasource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId, for: indexPath) as! MainTableViewCell
        return cell
    }
}

