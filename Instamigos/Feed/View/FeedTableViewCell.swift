//
//  FeedTableViewCell.swift
//  Instamigos
//
//  Created by Cáren Sousa on 20/05/23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var addOrRemoveLike: ((Bool, IndexPath) -> Void)?
    var likeData: Bool?
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        if let likeData = likeData, let indexPath = getIndexPath() {
            addOrRemoveLike?(!likeData, indexPath)
        }
    }
    
    private func getIndexPath() -> IndexPath? {
        guard let tableView = superview as? UITableView else { return nil }
        return tableView.indexPath(for: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    func populateCell(data: FeedCellModel) {
        timeLabel.text = data.calculatesElapsedTime(postDate: data.createdAt.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ"))
        contentLabel.text = data.content
        likeCountLabel.text = "\(data.like_count)"
        
        likeData = data.isLiked
        
        if data.isLiked {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    
    func getName(name: String?) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
