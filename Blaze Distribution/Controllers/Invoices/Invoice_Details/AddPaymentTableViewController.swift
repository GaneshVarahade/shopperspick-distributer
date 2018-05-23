//
//  AddPaymentTableViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class AddPaymentTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var paymentDateView: UIView!
    @IBOutlet weak var referenceNoView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var notesView: UIView!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Add Payment"

//        paymentTypeView.dropShadow()
//        paymentDateView.dropShadow()
//        referenceNoView.dropShadow()
//        amountView.dropShadow()
//        notesView.dropShadow()
        
        notesTextView.text = "Enter your notes here..."
        notesTextView.textColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 1:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 2:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 3:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 4:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 5:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 6:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 7:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 8:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 9:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 10:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 11:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        default:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        }
    }
    
    
    // MARK: - UITextView Delegate/DataSource
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your notes here..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = UIColor.lightGray
            textView.text = "Enter your notes here..."
        }
    }
    
    // MARK:- Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - UIButton Events
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
