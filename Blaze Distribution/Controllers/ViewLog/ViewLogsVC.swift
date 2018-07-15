//
//  ViewLogsVC.swift
//  Blaze Distribution
//
//  Created by Apple on 15/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class ViewLogsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var logTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View Logs"
        self.logTable.tableHeaderView?.backgroundColor = UIColor.darkGray
        self.logTable.sectionIndexColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        self.logTable.tableHeaderView?.tintColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        self.logTable.delegate=self
        self.logTable.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- UITableView Datasource/Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Invoice"
        }else if section == 1{
            return "Inventry"
        }else{
           return "Open Transfer"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewLogCell
       // let key = sectionNameList[indexPath.section]
//        var dict = filterDict[key]
//        cell.nameLabel.text =  dict![indexPath.row].name
//        cell.quantityLabel.text = String(format: "%.1f",dict![indexPath.row].quantity)
//
//        //Set up Add button
//        cell.addBtn.addTarget(self, action: #selector(addButtonClicked(_ :)), for: UIControlEvents.touchUpInside)
//        cell.addBtn.tag = indexPath.row
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Invoice","Inventry","Transfer"]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        else {
            return 50
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
