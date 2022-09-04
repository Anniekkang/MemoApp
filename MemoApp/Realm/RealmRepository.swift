//
//  RealmRepository.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit
import RealmSwift

protocol MemoRepositoryType {
    func fetchDate(date : Date)-> Results<memoModel> 
}

let localRealm = try! Realm()

class RealmRepository {

    func fetchDate(date : Date)-> Results<memoModel> {
        return localRealm.objects(memoModel.self).filter(<#T##predicateFormat: String##String#>, <#T##args: Any...##Any#>)
    }

}
