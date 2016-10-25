//
//  YelpCell.swift
//  Yelp
//
//  Created by Kyou on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class YelpCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var data: Business!{
        didSet{
            if let url = data.imageURL{
                
                thumbImageView.setImageWith(url)
            }
            distanceLabel.text = data.distance
            nameLabel.text = data.name
            reviewLabel.text = "\(data.reviewCount!) Reviews"
            addressLabel.text = data.address
            categoryLabel.text = data.categories
            
            if let rateUrl = data.ratingImageURL {
                
                ratingImageView.setImageWith(rateUrl)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutIfNeeded()
        
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
