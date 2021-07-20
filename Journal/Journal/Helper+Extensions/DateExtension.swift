//
//  DateExtension.swift
//  Journal
//
//  Created by lijia xu on 7/20/21.
//

import Foundation

extension Date {
    func getStringForm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
    
}//End Of Date
