//
//  reportCell.swift
//  Bully
//
//  Created by Dev on 7/25/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class reportCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bullyType: UILabel!
    @IBOutlet weak var reportStage: UIImageView!
    @IBOutlet weak var date: UILabel!

    @IBOutlet weak var stage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
