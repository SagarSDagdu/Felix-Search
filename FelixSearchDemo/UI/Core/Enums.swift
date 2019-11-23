//
//  Enums.swift
//  FelixSearchDemo
//
//  Created by Sagar Dagdu on 11/23/19.
//  Copyright © 2019 Sagar Dagdu. All rights reserved.
//

import UIKit

///Dialpad characters
enum DialPadCharacter: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case star = "*"
    case hash = "#"
    case delete = "delete"
    
    func getSearchTerm() -> String {
        switch self {
        case .two:      return "abc"
        case .three:    return "def"
        case .four:     return "ghi"
        case .five:     return "jkl"
        case .six:      return "mno"
        case .seven:    return "pqrs"
        case .eight:    return "tuv"
        case .nine:     return "wxyz"
        case .delete:   return rawValue
        default:        return ""
        }
    }
}

