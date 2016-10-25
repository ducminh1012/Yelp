//
//  FilterCell.swift
//  Yelp
//
//  Created by Kyou on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol DealCellDelegate: class {
    func switchValueChange(value: Bool)
}

class FilterCell: UITableViewCell {

    weak var dealCellDelegate: DealCellDelegate!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        switchValue = sender.isOn
        dealCellDelegate.switchValueChange(value: sender.isOn)
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var haveDealSwitch: UISwitch!
    
    var switchValue = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
