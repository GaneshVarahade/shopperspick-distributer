//
//  ProductDetailsCellVC.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 30/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class ProductDetailsCellVC: UITableViewCell {

    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblInvetryId: UILabel!
    @IBOutlet weak var lblShopId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
