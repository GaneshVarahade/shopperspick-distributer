//
//  InvoicePaymentsTableViewCell.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 14/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class InvoicePaymentsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPaymentName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
