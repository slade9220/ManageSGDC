//
//  EventTableViewCell.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 04/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
