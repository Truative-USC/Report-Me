//
//  adminCellTableViewCell.swift
//  Bully
//
//  Created by Dev on 8/2/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class adminCellTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var id: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
