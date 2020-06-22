//
//  QuantityBatchTableViewCell.swift
//  shopperspick
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol qauntityBatchCellDelegate : class {
    func didPressBatchBtn(_ tag: Int)
}

class QuantityBatchTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var batchTextField: UITextField!
    
    weak var cellDelegate: qauntityBatchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //topView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK:- UITextfield Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin")
    }
   
}
