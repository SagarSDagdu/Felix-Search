//
//  FelixSearchManager.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit

final class FelixSearchManager: NSObject {
    
    //MARK:- Properties
    
    private var contactsManager: ContactsManager
    private var allContacts = [Contact]()
    private var filteredContacts = [Contact]()
    private var currentSearchTerms = [String]()
    private var contactUIResults = [DisplayContact]()
    
    //MARK:- Initialization
    
    init(contactsManager: ContactsManager, completion:(()->Void)? = nil) {
        self.contactsManager = contactsManager
        super.init()
        self.fetchAllContacts(completion: completion)
    }
    
    //MARK:- Public methods
    
    func resetSearch() {
        currentSearchTerms.removeAll()
        filteredContacts.removeAll()
        contactUIResults.removeAll()
    }
    
    func addSearchTermToExisting(searchTerm: String) {
        var updatedSearchTerms = [String]()
        if currentSearchTerms.isEmpty {
            currentSearchTerms = characterChunks(from: searchTerm)
            (filteredContacts, contactUIResults) = getFilteredContacts(from: allContacts, searchTerms: currentSearchTerms)
            return
        }
        
        let newSearchTerms = characterChunks(from: searchTerm)
        
        for currentSearchTerm in currentSearchTerms {
            for newSearchTerm in newSearchTerms {
                updatedSearchTerms.append(currentSearchTerm + newSearchTerm)
            }
        }
        
        currentSearchTerms = updatedSearchTerms
        (filteredContacts, contactUIResults) = getFilteredContacts(from: filteredContacts, searchTerms: currentSearchTerms)
    }
    
    func getCurrentlyMatchingDisplayContacts() -> [DisplayContact] {
        if currentSearchTerms.isEmpty {
            return allContacts.compactMap { DisplayContact(with: $0.name, searchedText: "")
            }
        }
        return contactUIResults
    }
    
    //MARK:- Helpers
    
    private func fetchAllContacts(completion: (()->Void)? = nil) {
        self.contactsManager.fetchAllContacts { (contacts) in
            self.allContacts = contacts
            completion?()
        }
    }
    
    private func getFilteredContacts(from contacts:[Contact], searchTerms: [String]) -> ([Contact], [DisplayContact]) {
        var filteredContacts = [Contact]()
        var displayContacts = [DisplayContact]()
        
        for searchTerm in searchTerms {
            let contactsForSearchTerm = getFilteredContacts(from: contacts, searchTerm: searchTerm)
            for contactForSearchTerm in contactsForSearchTerm {
                filteredContacts.removeAll { $0.name.caseInsensitiveCompare(contactForSearchTerm.name) == .orderedSame }
                filteredContacts.append(contactForSearchTerm)
                displayContacts.append(DisplayContact(with: contactForSearchTerm.name, searchedText: searchTerm))
            }
        }
        return (filteredContacts, displayContacts)
    }
    
    private func getFilteredContacts(from contacts:[Contact], searchTerm: String) -> [Contact] {
        return contacts.filter { $0.name.lowercased().contains(searchTerm) }
    }
    
    private func characterChunks(from string: String) -> [String] {
        return string.compactMap { String($0) }
    }
}
