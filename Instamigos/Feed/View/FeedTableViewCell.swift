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
        // TODO: DECIDIR LÓGICA/NECESSIDADE DO LIKE
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    func populateCell(data: FeedCellModel) {
        timeLabel.text = data.calculatesElapsedTime(postDate: data.createdAt.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ"))
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
