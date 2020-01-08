//
//  FriendController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 25/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//Contact CRUD
class FriendController {
     
    func AddFriend(friend:Friend)
    {
       let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
       let context = appDelegate.persistentContainer.viewContext
       
       let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
       
       let person = NSManagedObject(entity: entity, insertInto: context)
       person.setValue(friend.Name, forKey: "name")
       person.setValue(friend.profileImageName, forKey: "profileimagename")
       
       do {
           try context.save()
       } catch let error as NSError {
           print("Could not save. \(error), \(error.userInfo)")
       }
    }
    
    func AddMessageToFriend(friend:Friend, message:Message)
    {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
        
        let messageEntity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        
        let cdmesage = NSManagedObject(entity: messageEntity, insertInto: context)
        cdmesage.setValue(message.Date, forKey: "date")
        cdmesage.setValue(message.isSender, forKey: "isSender")
        cdmesage.setValue(message.Text, forKey: "text")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@" , friend.Name)
        
        do {
            let test = try context.fetch(fetchRequest)
            let cdfriend = test[0]
            //Relationship
            cdmesage.setValue(cdfriend, forKey: "friend")
            try context.save()
        }
        catch
        {
            print(error)
        }
    }
    
    func retrieveMessagesbyFriend(contact:Contact)->[Message]
    {
        var messageList:[Message] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDMessage")
        
        fetchRequest.predicate = NSPredicate(format: "contact.firstname = %@" , contact.firstName)
        
        do
        {
            let list:[NSManagedObject] = try context.fetch(fetchRequest)
            for m in list {
                let d = m.value(forKeyPath: "date") as! Date
                let b = m.value(forKeyPath: "isSender") as! Bool
                let t = m.value(forKeyPath: "text") as! String
                print("\(d) \(b), \(t)")
                messageList.append(Message(date: d, issender: b, text: t))
            }
        }
        catch
        {
            print(error)
        }
        return messageList
    }
}
