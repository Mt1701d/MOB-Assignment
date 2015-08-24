//
//  TableViewCell.swift
//  UICollectiontest
//
//  Created by MT1701 on 12/8/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var NumOfPLabel: UILabel!
    @IBOutlet weak var TableNumberLabel: UILabel!
    @IBOutlet weak var ID: UILabel!
    
    @IBOutlet weak var tableLabel: UILabel!
    
    @IBOutlet weak var IDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ID.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
