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
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCell(data: FeedCellModel) {
        timeLabel.text = data.createdAt
        contentLabel.text = data.content
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
