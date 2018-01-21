//
//  PhraseCell.swift
//  CoreML in ARKit
//
//  Created by John Abreu on 1/21/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit

class PhraseCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
