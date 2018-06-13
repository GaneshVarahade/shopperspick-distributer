//
//  LookupPOsViewController.swift
//  blaze
//
//  Created by pankaj on 09/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class LookupPOsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var poSearchBar: UISearchBar!
    @IBOutlet weak var topView: UIView!
    
    var tempDataList : [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Lookup PO#"
        
        tempDataList = [["po_no":"123456","metric":"YES"],["po_no":"123456","metric":"NO"]]
        
        //topView.dropShadow()
        setSearchBarUI()
    }
    // MARK:- Utilities
    func setSearchBarUI() {
        poSearchBar.layer.borderWidth = 1;
        poSearchBar.layer.borderColor = UIColor.white.cgColor
        for s in poSearchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    
    // MARK: - UITableViewDelegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PurchaseOrderTableViewCell
        
        cell.poNoLabel.text = (tempDataList[indexPath.row])["po_no"] as? String
        if (tempDataList[indexPath.row])["metric"] as? String == "YES" {
            cell.metricImg.image = UIImage.init(named: "okGreen")
          
        }
        else {
            cell.metricImg.image = UIImage()
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PurchaseOrderDetailsTableViewController") as! PurchaseOrderDetailsTableViewController
        obj.poNo = ((tempDataList[indexPath.row])["po_no"] as? String)!
        if (tempDataList[indexPath.row])["metric"] as? String == "YES" {
            obj.isMetric = true
               showAdd = false
        }
        else {
            obj.isMetric = false
                 showAdd = true
        }
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 60
        }
        else {
            return 44
        }
    }

    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
