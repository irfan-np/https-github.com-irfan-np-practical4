//
//  ShowContactViewControllerswift.swift
//  Telegramme
//
//  Created by MAD2_P02 on 11/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import Foundation
import UIKit

class ShowContactViewController : UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contactList:[Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactList = ContactController().retrieveAllContact()
        self.tableView.reloadData() //refresh data
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactList = ContactController().retrieveAllContact()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contactList[indexPath.row]
        cell.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
        cell.detailTextLabel!.text = "\(contact.mobileNo)"
        return cell
    }
    
/*    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        else {
            return true
        }
    }
    
     func tableview(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, cellForRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                appDelegate.contactList.remove(at: indexPath.row)
                //sectionOneitems.remove(at: indexPath.row)
            }
            else {
                appDelegate.contactList.remove(at: indexPath.row)
                //sectionTwoitems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }
 */
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Edit list item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.contactList[indexPath.row].firstName
                })
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.contactList[indexPath.row].lastName
                })
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.contactList[indexPath.row].mobileNo
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.contactList[indexPath.row].firstName = alert.textFields![0].text!
                self.contactList[indexPath.row].lastName = alert.textFields![1].text!
                self.contactList[indexPath.row].mobileNo = alert.textFields![2].text!
                var new:Contact
                new=Contact(firstname: alert.textFields![0].text!, lastname: alert.textFields![1].text!, mobileno: alert.textFields![2].text!)
                ContactController().updateContact(mobileno: alert.textFields![2].text!, newContact: new)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })
     let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
        ContactController().deleteContact(mobileno: self.contactList[indexPath.row].mobileNo)
        self.contactList.remove(at: indexPath.row)
         tableView.reloadData()
     })
        editAction.backgroundColor=UIColor.blue

        return [deleteAction,editAction]
    }
}
