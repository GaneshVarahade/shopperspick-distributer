//
//  ViewLogCell.swift
//  Blaze Distribution
//
//  Created by Apple on 15/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class ViewLogCell: UITableViewCell {
    @IBOutlet weak var lblTimesStamp: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventId: UILabel!
    @IBOutlet weak var lblLastSyncDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
