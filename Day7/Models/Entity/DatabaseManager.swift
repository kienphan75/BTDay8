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
    private var context: NSManagedObjectContext
    
    
    private init(){
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
    
    
    /// get all contact in database
    ///
    /// - Returns: list contact
    func getAllContacts() -> [ContactModel]?{
        
        var contacts = [ContactModel]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let name = data.value(forKey: "name") as! String
                let phone = data.value(forKey: "phone") as! String
                let avatar = (data.value(forKey: "avatar") as! Data)
                let newContact = ContactModel()
                newContact.name = name
                newContact.phone = phone
                newContact.avatar = avatar
                contacts.append(newContact)
                
            }
            return contacts
            
        } catch {
            
            print("Failed")
        }
        return nil
    }
    
    
    /// insert a new contact to database
    ///
    /// - Parameter contact: a contact want insert
    func insert(contact: ContactModel) {
        
            let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context)
            let newContact = NSManagedObject(entity: entity!, insertInto: context)
            newContact.setValue(contact.name, forKey: "name")
            newContact.setValue(contact.phone, forKey: "phone")
            newContact.setValue(contact.avatar, forKey: "avatar")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        
    }
}
