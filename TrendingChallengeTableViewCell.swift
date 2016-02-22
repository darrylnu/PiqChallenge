//
//  TrendingChallengeTableViewCell.swift
//  PiqChallenge
//
//  Created by Darryl Nunn on 2/22/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class TrendingChallengeTableViewCell: UITableViewCell {
    
    
    @IBOutlet var postImage: UIImageView!

    @IBOutlet var postComment: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.postImage.image = nil
        self.postComment.text = ""
    }
}
