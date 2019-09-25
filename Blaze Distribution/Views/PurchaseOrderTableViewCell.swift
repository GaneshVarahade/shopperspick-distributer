//
//  PurchaseOrderTableViewCell.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class PurchaseOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var btnErrrorPo: UIButton!
    @IBOutlet weak var poNoLabel: UILabel!
    @IBOutlet weak var metricImg: UIImageView!
    @IBOutlet weak var metricLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
