//
//  ContactCellTableViewCell.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit

class ContactCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        selectionStyle = .none
    }
    
    func setupCell(with contact: DisplayContact) {
        self.titleLabel.attributedText = contact.attributedName
    }
    
}
