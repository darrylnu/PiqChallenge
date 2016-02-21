//
//  ChallengeCell.swift
//  ChallengeMe
//
//  Created by Darryl Nunn on 2/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class ChallengeCell: UITableViewCell {


    @IBOutlet var challengeCount: UILabel!

    @IBOutlet var challengeStrip: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.challengeCount.text = "0"
        self.challengeStrip.text = ""
        
    }
}
