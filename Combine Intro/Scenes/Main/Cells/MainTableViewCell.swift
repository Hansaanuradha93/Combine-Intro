import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let reuseId = "MainTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .red
    }
}
