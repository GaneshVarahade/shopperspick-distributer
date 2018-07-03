//
//  LookUpProductViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class LookUpProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lookUpTableView: UITableView!
    
    var predicateArray = [String]()
    var tempDataList = [String:AnyObject]()
    var filterDict = [String:[ModelProduct]]()
    var sectionNameList = [String]()
    var productData : [ModelProduct] = []
    var cartData = [ModelCartProduct]()
    var ProductA = [ModelProduct]()
    var arrayFilteredProduct = [ModelProduct]()
    let customBarbutton = UIButton(type: .system)
    //var filteredProductList = [[String:[ModelProduct]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lookup Product"
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        lookUpTableView.sectionIndexColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        self.lookUpTableView.estimatedRowHeight = 120
        self.lookUpTableView.rowHeight = UITableViewAutomaticDimension
        predicateArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R",
        "S","T","U","V","W","X","Y","Z"]
        setSearchBarUI()
//        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Basket"), style: .done, target: self, action: #selector(basketBtnPressed))
//
        //let button = UIButton(type: .system)
        customBarbutton.setBackgroundImage(UIImage(named: "Basket"), for: (UIControlState.normal))
        customBarbutton.setTitle("12", for: UIControlState.normal)
        customBarbutton.setTitleColor(UIColor.red, for: UIControlState.normal)
        customBarbutton.sizeToFit()
        customBarbutton.addTarget(self, action: #selector(basketBtnPressed), for: UIControlEvents.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: customBarbutton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        //Update cart count
        customBarbutton.setTitle(String(format: "%d",cartData.count), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper
    @objc func addButtonClicked(_ button: UIButton) {
        //get row tag
        let pointInTable: CGPoint =         button.convert(button.bounds.origin, to: self.lookUpTableView)
        let cellIndexPath = self.lookUpTableView.indexPathForRow(at: pointInTable)
        let section = cellIndexPath?.section
        let indexPath = button.tag
        let selectedModelProduct :[ModelProduct] = [filterDict[sectionNameList[section!]]![indexPath]]
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LookUpProductEnterQuantitySegue") as! LookUpProductEnterQuantity
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LookUpProductEnterQuantitySegue") as! LookUpProductEnterQuantity
        obj.selecetdProduct = selectedModelProduct
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    func getData(){
        productData   = RealmManager().readList(type: ModelProduct.self)
        cartData = RealmManager().readList(type:ModelCartProduct.self)
        print(cartData)
        
        //filterArray()
        for val in predicateArray{
            filterArrayByPredicate(predicateString: val)
        }
        print(filterDict)
        print(Array(filterDict.keys))
        sectionNameList = Array(filterDict.keys)
        lookUpTableView.reloadData()
        print("----DataRead----- \(productData.count)")
    }
    
    func filterArrayByPredicate(predicateString : String){
        ProductA.removeAll()
        for dict in productData{
            let productName = dict.name
            if productName?.first == predicateString.first || productName?.first == predicateString.lowercased().first{
                ProductA.append(dict)
            }
        }
        if ProductA.count != 0 {
            filterDict[predicateString] = ProductA
        }
    }
//    func filterArray(){
//        ProductA.removeAll()
//        ProductB.removeAll()
//        ProductC.removeAll()
//        for dict in productData{
//            let productName = dict.name
//            if productName?.first == "A" || productName?.first == "a"{
//                ProductA.append(dict)
//            };if productName?.first == "B" || productName?.first == "b"{
//                ProductB.append(dict)
//            };if productName?.first == "C" || productName?.first == "c"{
//                ProductC.append(dict)
//            }
//        }
//        filterDict["C"] = ProductC
//        filterDict["B"] = ProductB
//        filterDict["A"] = ProductA
//        print(filterDict)
//        print(Array(filterDict.keys))
//        sectionNameList = Array(filterDict.keys)
//    }
    
    
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
        return sectionNameList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionNameList[section]
        return (filterDict[key]?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNameList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LookUpTableViewCell
        let key = sectionNameList[indexPath.section]
        var dict = filterDict[key]
        cell.nameLabel.text =  dict![indexPath.row].name
        cell.quantityLabel.text = String(format: "%.1f",dict![indexPath.row].quantity)
        
        //Set up Add button
        cell.addBtn.addTarget(self, action: #selector(addButtonClicked(_ :)), for: UIControlEvents.touchUpInside)
        cell.addBtn.tag = indexPath.row
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    // MARK: - UIButton Events
    @IBAction func continueBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmTransferViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBAction func findSearchBtnClicked(_ sender: Any) {
        if searchBar.text != "" {
            for key in sectionNameList{
                arrayFilteredProduct.removeAll()
               let dictProdModel = filterDict[key]
                for dict in dictProdModel!{
//                    if (dict.name?.lowercased() == searchBar.text?.lowercased()){
//                        arrayFilteredProduct.append(dict)
//                    }
                    if (dict.name?.lowercased().range(of: searchBar.text!.lowercased()) != nil){
                        arrayFilteredProduct.append(dict)
                    }
                }
                
                if(arrayFilteredProduct.count != 0){
                    //filterDict[key] = arrayFilteredProduct
                    filterDict.updateValue(arrayFilteredProduct, forKey: key)
                }else{
                    filterDict.removeValue(forKey: key)
                    sectionNameList = sectionNameList.filter { $0 != key }
                }
            }
            //Check Filtered Dict count
            print(filterDict)
            if (filterDict.count == 0){
                showToast("No Record found")
            }
            lookUpTableView.reloadData()
        }else{
            
        }
    }
    // MARK: - UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if (searchBar.text?.count==0)
        {
            filterDict.removeAll()
            sectionNameList.removeAll()
            getData();
            lookUpTableView.reloadData()
        }
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
//        getData();
//        lookUpTableView.reloadData()
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
