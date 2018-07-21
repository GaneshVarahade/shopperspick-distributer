//
//  ReceiveShipmentTableViewCell.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ReceiveShipmentTableViewCell: UITableViewCell {
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblExpected: UILabel!
    @IBOutlet weak var txtRecived: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
