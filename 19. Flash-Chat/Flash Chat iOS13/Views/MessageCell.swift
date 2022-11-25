//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Mutlu Çalkan on 25.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var youAvatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
