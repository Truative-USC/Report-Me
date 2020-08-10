//
//  noteCell.swift
//  Bully
//
//  Created by Dev on 8/20/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class noteCell: UITableViewCell {

    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
