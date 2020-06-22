//
//  ShippingManifestTableViewCell.swift
//  shopperspick
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ShippingManifestTableViewCell: UITableViewCell {

    @IBOutlet weak var shippingIdButton: UIButton!
    @IBOutlet weak var shippingStatusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
