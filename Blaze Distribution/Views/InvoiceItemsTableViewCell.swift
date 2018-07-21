//
//  PaymentDetailsTableViewCell.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class InvoiceItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var productNameBtn: UIButton!
    @IBOutlet weak var batchNoLabel: UILabel!
    @IBOutlet weak var noUnits: UILabel!
    
    @IBOutlet weak var cellTapView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
