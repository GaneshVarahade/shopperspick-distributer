//
//  SMHeaderProductCell.swift
//  shopperspick Distribution
//
//  Created by Mac on 08/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import UIKit

class SMHeaderProductCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //Header cell
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderedQty: UILabel!
    @IBOutlet weak var lblRemainingQty: UILabel!
//    @IBOutlet weak var txtSelectInventory: UITextField!
//    @IBOutlet weak var txtSelectBatch: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtSelectInventory: MyCustomTextField!
    @IBOutlet weak var txtSelectBatch: MyCustomTextField!
    
    
    
    func setUI(){
        self.btnAdd.layer.cornerRadius = 6.0
        self.txtSelectInventory.layer.borderColor = UIColor.APPGreenColor.cgColor
        self.txtSelectInventory.layer.borderWidth = 1.0
        self.txtSelectInventory.layer.cornerRadius = 5.0
        
        self.txtSelectBatch.layer.borderColor = UIColor.APPGreenColor.cgColor
        self.txtSelectBatch.layer.borderWidth = 1.0
        self.txtSelectBatch.layer.cornerRadius = 5.0
        
//        let imageView = UIImageView();
//        let image = UIImage(named: "choose_arrow.png");
//        imageView.image = image;
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "choose_arrow.png"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.txtSelectInventory.rightView = button;
        button.isHidden = true
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "choose_arrow.png"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.txtSelectBatch.rightView = button1;
        button1.isHidden = true

        self.txtSelectBatch.rightViewMode = .always
        self.txtSelectInventory.rightViewMode = .always
    }

}
