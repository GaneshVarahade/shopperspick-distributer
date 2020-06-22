//
//  ReceiveShipmentTableViewCell.swift
//  shopperspick
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol ReceiveShipmentDelegate {
    func onBatchStatusClicked(_ sender:Any)
}

class ReceiveShipmentTableViewCell: UITableViewCell {
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblExpected: UILabel!
    @IBOutlet weak var txtRecived: UITextField!
    @IBOutlet weak var btnBatchStatus: UIButton!
    
    var delegate:ReceiveShipmentDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnBatchStatusTapped(_ sender: Any) {
        delegate?.onBatchStatusClicked(sender)
    }
    

}
