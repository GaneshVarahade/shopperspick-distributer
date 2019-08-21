//
//  ViewLogsVC.swift
//  Blaze Distribution
//
//  Created by Apple on 15/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewLogsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var logTable: UITableView!
    var objModelLogs = [ModelTimesStampLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("LogVcTitle", comment: "")
        //self.logTable.tableHeaderView?.backgroundColor = UIColor.darkGray
        self.logTable.sectionIndexColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        self.logTable.tableHeaderView?.tintColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        self.logTable.delegate=self
        self.logTable.dataSource = self
        //Read Model timestamp Log
     self.objModelLogs = RealmManager().readList(type: ModelTimesStampLog.self)
        //print(objModelLogs)
        UtilPrintLogs.requestLogs(message:"Log list", objectToPrint: objModelLogs)
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- UITableView Datasource/Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return objModelLogs.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Sorry! No logs found"

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if objModelLogs.count == 0{
            return 50.0
        }else{
            return 0.0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewLogCell
        cell.lblTimesStamp.text = objModelLogs[indexPath.row].timesStamp
        cell.lblEventId.text = objModelLogs[indexPath.row].objectId
        cell.lblEventName.text = objModelLogs[indexPath.row].event
        //cell.lblLastSyncDate.text = objModelLogs[indexPath.row].lastSyncTime ?? "--"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 90
        }
        else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
