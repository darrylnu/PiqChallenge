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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imagePost.image = nil
        self.userLabel.text = ""
    }
    
}
