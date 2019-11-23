//
//  ContactsManager.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit


final class ContactsManager: NSObject {
        
    //MARK:- Fetch all contacts
    
    func fetchAllContacts(completion: (([Contact])->Void)) {
        var fileContents = ""
        let filePath = Bundle.main.path(forResource: "contacts", ofType: "txt")
        do {
            fileContents = try String(contentsOfFile: filePath!, encoding: .utf8)
        } catch {
            print("Error in loading contacts")
        }
        let contactNames =  fileContents.components(separatedBy: "\n")
        completion(contactNames.compactMap { Contact(withName: $0) })
    }
}
