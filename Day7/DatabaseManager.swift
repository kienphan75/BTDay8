//
//  DatabaseManager.swift
//  Day7
//
//  Created by admin on 7/23/18.
//  Copyright © 2018 meosteam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager{
    static let instanle = DatabaseManager()
    
    
    func getAllContacts(context :NSManagedObjectContext ) -> [Contacts]?{
        
        var contacts = [Contacts]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let newContact = Contacts(context: context)
                newContact.name = data.value(forKey: "name") as! String
                newContact.phone = data.value(forKey: "phone") as! String
                newContact.avatar = (data.value(forKey: "avatar") as! Data)
                contacts.append(newContact)
                
            }
            return contacts
            
        } catch {
            
            print("Failed")
        }
        return nil
    }
    
    func insert(contact: Contacts, context :NSManagedObjectContext) {
        if let name = contact.name, let phone = contact.phone, let avatar = contact.avatar{
            let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context)
            let newContact = NSManagedObject(entity: entity!, insertInto: context)
            newContact.setValue(name, forKey: "name")
            newContact.setValue(phone, forKey: "phone")
            newContact.setValue(avatar, forKey: "avatar")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
}
