//
//  ConfirmTransferTableViewCell.swift
//  blaze
//
//  Created by pankaj on 09/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ConfirmTransferTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameBtn: UIButton!
    @IBOutlet weak var transferAmountLbl: UILabel!
    @IBOutlet weak var expectedTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
