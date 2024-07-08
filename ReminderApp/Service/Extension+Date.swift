//
//  DateService.swift
//  ReminderApp
//
//  Created by 강한결 on 7/4/24.
//

import Foundation

extension Date {
    static func compareWithToday(_ targetDate: Date) -> ComparisonResult {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let today = formatter.string(from: Date())
        let target = formatter.string(from: targetDate)
                
        return today.compare(target)
    }
    
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
}
