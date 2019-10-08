//
//  ManifestItemSelectionCell.swift
//  BLAZE Distribution
//
//  Created by Mac on 08/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import UIKit

class ManifestItemSelectionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblRequestedQty: UILabel!
    @IBOutlet weak var lblRemainingQty: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
}
