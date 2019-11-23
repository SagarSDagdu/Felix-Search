//
//  ViewController.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Private properties
    
    private var searchResults = [DisplayContact]()
    private var felixSearchManager = FelixSearchManager(contactsManager: ContactsManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initialSetup()
    }
    
    private func setupUI() {
        self.title = "Felix Search"
        tableView.register(UINib(nibName: String.init(describing: ContactCellTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactCellTableViewCell.self))
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    
    private func initialSetup() {
        felixSearchManager.resetSearch()
        reloadContacts()
    }
    
    private func reloadContacts() {
        searchResults = felixSearchManager.getCurrentlyMatchingDisplayContacts()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCellTableViewCell.self), for: indexPath) as? ContactCellTableViewCell {
            cell.setupCell(with: searchResults[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        felixSearchManager.resetSearch()
        
        if let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            for character in text {
                if let dialpadChar = DialPadCharacter(rawValue: String(character)) {
                    let searchTerm = dialpadChar.getSearchTerm()
                    felixSearchManager.addSearchTermToExisting(searchTerm: searchTerm)
                }
            }
        }
        reloadContacts()
    }
}
