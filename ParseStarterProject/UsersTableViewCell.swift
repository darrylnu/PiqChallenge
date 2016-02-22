//
//  UsersTableViewCell.swift
//  PiqChallenge
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    
  
    @IBOutlet var userLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.userImage.image = UIImage(named: "placeholderpic")
    }
   
}
