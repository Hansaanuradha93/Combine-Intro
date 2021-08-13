import UIKit
import Combine

class MainTableViewCell: UITableViewCell {
    
    // MARK: Properties
    static let reuseId = "MainTableViewCell"
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let action = PassthroughSubject<String, Never>()

    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: Cell
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 10, width: contentView.frame.width - 5, height: contentView.frame.height - 20)
    }
}


// MARK: - Private Methods
private extension MainTableViewCell {
    
    @objc func buttonTapped() {
        action.send("button tapped!")
    }
    
    
    func configureViews() {
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
