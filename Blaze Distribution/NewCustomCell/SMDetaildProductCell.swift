//
//  SMDetaildProductCell.swift
//  BLAZE Distribution
//
//  Created by Mac on 08/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import UIKit

class SMDetaildProductCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lblInventoryName: UILabel!
    @IBOutlet weak var lblBatchName: UILabel!
    @IBOutlet weak var lblAvailabelBatchQty: UILabel!
    //@IBOutlet weak var txtActualQty: UITextField!
    @IBOutlet weak var txtActualQty: MyCustomTextField!
    
    
    
    func setupUI(){
        self.txtActualQty.layer.borderColor = UIColor.APPGreenColor.cgColor
        self.txtActualQty.layer.borderWidth = 1.0
        self.txtActualQty.layer.cornerRadius = 5.0
    }
}
