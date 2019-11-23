//
//  Contact.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit

///Contact model
class Contact : NSObject {
    var name: String
    
    init(withName name:String) {
        self.name = name
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
    }
    
    override var description: String {
        return name
    }
    
}

///This class is used for displaying a contact on UI. The searched part of the contact's text appears bold so that the user knows what search has yeild this contact.
final class DisplayContact: Contact {
    var searchedText: String
    
    init(with name: String, searchedText: String) {
        self.searchedText = searchedText
        super.init(withName: name)
        
    }
    
    var attributedName: NSAttributedString {
        get {
            let attributedName = NSMutableAttributedString(string: name)
            let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
            
            let range = (name.lowercased() as NSString).range(of: searchedText)
            attributedName.addAttributes(boldFontAttribute, range: range)
            return attributedName
        }
    }
}

