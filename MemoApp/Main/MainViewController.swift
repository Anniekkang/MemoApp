//
//  MainViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit

class MainViewController: BaseViewController {

    var memoCount = 0
    let mainView = MainView()
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        makeAlert(message: "처음 오셨군요! \n 환영합니다 :) \n\n 당신만의 메모를 작성하고 \n 관리해보세요!")
//        let label = UILabel()
//        label.textColor = UIColor.white
//        label.text = "\(memoCount)개의 메모"
//        label.textAlignment = .left
//        label.frame(forAlignmentRect: CGRect(x: -100, y: 0, width: 100, height: 50))
//        label.font = .systemFont(ofSize: 30, weight: .heavy)
//        self.navigationItem.titleView = label
//        label.backgroundColor = .darkGray
        
        mainView.backgroundColor = .darkGray
        
    }
    

    
}
