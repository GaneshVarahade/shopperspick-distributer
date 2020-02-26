
//
//  POStaticDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 11/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class POStaticDetailsTableViewController: UITableViewController {

    @IBOutlet weak var metricIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    @IBOutlet weak var completedDate: UILabel!
    
    var tempDict = [String:Any]()
    var model: ModelPurchaseOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AQLog.debug()
        
        EventBus.sharedBus().subscribe(self,
                                       selector: #selector(self.getDataForPOObject(notification:)),
            eventType: EventBusEventType.SENDATA_PURCHASEORDER)
    }


    @objc func getDataForPOObject(notification: Notification) {
        model = notification.userInfo!["data"] as! ModelPurchaseOrder
        
        metricIdLabel.text = TextHelpers.isEmpty(model.metrcId) ? " -/-" : model.metrcId
        statusLabel.text = TextHelpers.isEmpty(model.status) ? " -/-" : model.status
        originLabel.text = TextHelpers.isEmpty(model.origin) ? " -/-": model.origin
        receivedLabel.text = model.received == 0 ? " -/-" : DateFormatterUtil.format(dateTime: Double(model.received)/1000,
                                                      format: DateFormatterUtil.mmddyyyy)
        completedDate.text = model.completedDate == 0 ? " -/-" : DateFormatterUtil.format(dateTime: Double(model.completedDate)/1000,
                                                      format: DateFormatterUtil.mmddyyyy)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
        
                if TextHelpers.isEmpty(model.metrcId) {
                    return 0
                }
        }
        
        if indexPath.row == 2{
            if TextHelpers.isEmpty(model.origin){
                return 0
            }
        }
        
        if deviceIdiom == .pad {
            return 70
        }
        else {
            return 50
        }
        
        
        
    }

}
