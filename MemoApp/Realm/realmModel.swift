//
//  realmModel.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit
import RealmSwift

class memoModel : Object {
    @Persisted var title : String//list형태로 생김
    @Persisted var date : Date
    @Persisted var contents : String
    @Persisted var fixed : Bool
    @Persisted var status : Int
    @Persisted var donebuttonStatus : Bool
    @Persisted(primaryKey: true) var objectId : ObjectId
    
    
   

    convenience init(title :String,date: Date, contents :String,status : Int, donebuttonStatus : Bool){
        self.init()
        self.title = title
        self.date  = date
        self.fixed = false//즐겨찾기고정(true-고정, false - 고정x)
        self.contents = contents
        self.status = 0//cell선택여부(선택 - 1, 선택x - 0)
        self.donebuttonStatus = false//done눌리면true, 안눌리면-false

    }

}

//Date타입 현재 시각을 string 으로 바꿔서 반환해주는 함수 -> 지난주
func lastweekDateFormatter(date : Date) -> String {
    let myDateFormatter = DateFormatter()
    myDateFormatter.dateFormat = "yyyy.mm.dd a hh시 mm분"
    myDateFormatter.locale = Locale(identifier: "ko_KR")
    let convertStr = myDateFormatter.string(from: Date())//현재시간 스트링형식 -> 일주일 후 부터 적용

    
    return convertStr

}
//Date타입 현재 시각을 요일string 으로 변환해서 반환해주는 함수 -> 이번주
func thisweekDateForamatter(date : Date) -> String {
    let myDateFormatter = DateFormatter()
    myDateFormatter.dateFormat = "EEEE요일"
    myDateFormatter.locale = Locale(identifier: "ko_KR")
    let convertStr = myDateFormatter.string(from: Date())
    
    return convertStr
  
}

//Date타입 현재 시각을 오늘기준 string으로 변환해서 반환해주는 함수 -> 오늘
func todayDateFormatter(date: Date) -> String {
    let myDateFormatter = DateFormatter()
    myDateFormatter.dateFormat = "a hh시 mm분"
    myDateFormatter.locale = Locale(identifier: "ko_KR")
    let convertStr = myDateFormatter.string(from: date)
    
    return convertStr
  
}
