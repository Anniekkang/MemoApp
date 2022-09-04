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


