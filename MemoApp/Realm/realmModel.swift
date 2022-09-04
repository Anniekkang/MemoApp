//
//  realmModel.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit
import RealmSwift

class memoModel : Object {
    @Persisted var title : String
    @Persisted var date : Date
    @Persisted var contents : String?
    @Persisted var fixed : Bool
   
    
    @Persisted(primaryKey: true) var objectId : ObjectId
    
    convenience init(title :String,contents : String?){
        self.init()
        self.title = title
        self.date  = Date()
        self.fixed = false
        self.contents = contents
        
  
    }
    
}
