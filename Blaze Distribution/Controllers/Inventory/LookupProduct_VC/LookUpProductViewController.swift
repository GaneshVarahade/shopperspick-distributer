//
//  LookUpProductViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class LookUpProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lookUpTableView: UITableView!
    
    var tempDataList = [String:AnyObject]()
    var sectionNameList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lookup Product"
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       
        lookUpTableView.sectionIndexColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        
        tempDataList = ["A":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "B":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "C":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "D":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "E":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "F":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "G":[["name":"alaska"],["name":"alaska"],["name":"alaska"]],
            "H":[["name":"alaska"],["name":"alaska"],["name":"alaska"]]] as [String : AnyObject]
        
        sectionNameList = Array(tempDataList.keys)
        
        //topView.dropShadow()
        
        setSearchBarUI()
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Basket"), style: .done, target: self, action: #selector(basketBtnPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSearchBarUI() {
        
        searchBar.layer.borderWidth = 1;
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
    }
    
    
    // MARK: - Selector methods
    
    @objc func basketBtnPressed() {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController")
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK:- UITableView Datasource/Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tempDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNameList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LookUpTableViewCell
        cell.nameLabel.text =  "Aks"
        cell.quantityLabel.text = "$400"
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionNameList
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        else {
            return 50
        }
    }
    
    // MARK: - UIButton Events
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmTransferViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    // MARK: - UITouch events
    
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
