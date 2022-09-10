//
//  ModifiedViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/10.
//

import UIKit
import RealmSwift

class ModifiedViewController: BaseViewController {

    let localRealm = try! Realm()
   
    var tasks : Results<memoModel>! {
        didSet {
            print("tasked changed!")
        }
    }
    
    
    let mainView = ModifiedView()
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backgroundColor = .darkGray
        naviDesign()
        
    }
    
    func naviDesign(){
        //navigationitem design
        let leftButton = UIButton(type: .system)
        leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        leftButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        leftButton.sizeToFit()
        leftButton.tintColor = .orange
        leftButton.setTitleColor(.orange, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        leftButton.setTitle("메모", for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let rightShareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        rightShareButton.tintColor = .orange
        navigationItem.rightBarButtonItem = rightShareButton

        
        
    }
    
    @objc func backButtonTapped(){
        
        
    }
    
    @objc func shareButtonTapped(){
        
        
        
    }

    
}
