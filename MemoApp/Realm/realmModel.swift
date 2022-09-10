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
        self.fixed = false
        self.contents = contents
        self.status = 0
        self.donebuttonStatus = false

    }

}



