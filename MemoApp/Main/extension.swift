//
//  extension.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/12.
//

import UIKit

extension MainViewController {
    func convertTime(date : Date, indexPath : IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let todayStr = formatter.string(from: Date())
        let convertStr = formatter.string(from: date)
        
        let calendar = Calendar.current
        let date = calendar.startOfDay(for: date)
        let dayofWeek = calendar.component(.weekday, from: date)
        let days = calendar.range(of: .weekday, in: .weekOfYear, for: date)!.compactMap {
            calendar.date(byAdding: .day, value: $0 - dayofWeek, to: date)}.filter { !calendar.isDateInWeekend($0)
            }
        
        
        //오늘일때
        if convertStr == todayStr {
            let result = todayDateFormatter(date: date)
                return result
            } else if days.contains(date) {
                //this week
                let result = thisweekDateForamatter(date: date)
                return result
            } else {
            
                let result = lastweekDateFormatter(date: date)
                return result
            }
                
     
        }
    
    
}
