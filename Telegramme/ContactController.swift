//
//  ContactController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 20/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//Contact CRUD
class ContactController {
    
    //Add a new contact to Core Data
    func AddContact(newContact:Contact)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
        
        let person = NSManagedObject(entity: entity, insertInto: context)
        person.setValue("Melfred", forKeyPath: "firstname")
        person.setValue("Sawyer", forKeyPath: "lastname")
        person.setValue("91111222", forKeyPath: "mobileno")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Retrieve all contacts from Core Data
    func retrieveAllContact()
    {
        var people:[NSManagedObject] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do {
            people = try context.fetch(fetchRequest)
            
            for p in people {
                var person:Contact
                let firstname = p.value(forKey: "firstname") as? String
                let lastname = p.value(forKey: "lastname") as? String
                let mobileno = p.value(forKey: "mobileno") as? String
                person=Contact(firstname: firstname!, lastname: lastname!, mobileno: mobileno!)
                appDelegate.contactList.append(person)
                print("\(firstname!) \(lastname), \(mobileno!)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    //Update current contact with new contact
    //fetch data based on mobileno
    func updateContact(mobileno:String, newContact:Contact)
    {
        
    }
    
    //Delete contact
    //fetch data based on mobileno
    func deleteContact(mobileno:String)
    {
        
    }
}
