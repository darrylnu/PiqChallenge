//
//  cell.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet var imagePost: UIImageView!
    
    @IBOutlet var userLabel: UILabel!
    
    
    @IBOutlet var starLabel: UILabel!
    
    @IBOutlet var starButtonImage: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imagePost.image = nil
        self.userLabel.text = ""
        self.starLabel.text = ""
        self.starButtonImage.setImage(UIImage(named: "star-7.png"), forState: .Normal)
    }
    
}
