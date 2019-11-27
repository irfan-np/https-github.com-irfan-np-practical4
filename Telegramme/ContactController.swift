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
        person.setValue(newContact.firstName, forKey: "firstname")
        person.setValue(newContact.lastName, forKey: "lastname")
        person.setValue(newContact.mobileNo, forKey: "mobileno")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Retrieve all contacts from Core Data
    func retrieveAllContact()->[Contact]
    {
        var contactList:[Contact] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do {
            let list:[NSManagedObject] = try context.fetch(fetchRequest)
            
            for p in list {
                let firstname = p.value(forKeyPath: "firstname") as! String
                let lastname = p.value(forKeyPath: "lastname") as! String
                let mobileno = p.value(forKeyPath: "mobileno") as! String
                //print("\(firstname!) \(lastname), \(mobileno!)")
                contactList.append(Contact(firstname: firstname, lastname: lastname, mobileno: mobileno))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return contactList
    }
    
    //Update current contact with new contact
    //fetch data based on mobileno
    func updateContact(mobileno:String, newContact:Contact)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        //fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        do
        {
            let test = try context.fetch(fetchRequest)
            
            let objectUpdate=test[0]
            objectUpdate.setValue(newContact.firstName, forKey: "firstname")
            objectUpdate.setValue(newContact.lastName, forKey: "lastname")
            objectUpdate.setValue(newContact.mobileNo, forKey: "mobileno")
            do {
                try context.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
    
    //Delete contact
    //fetch data based on mobileno
    func deleteContact(mobileno:String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        do
        {
            let test = try context.fetch(fetchRequest)
            
            let objectToDelete = test[0]
            context.delete(objectToDelete)
            
            do{
                try context.save()
            }
            catch
            {
                print("Could not save. \(error)")
            }
        }
        catch
        {
            print("Could not delete. \(error)")
        }
    }
}
