//
//  BaseViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        setConstraints()
       
    }
    

    func configuration(){}
    func setConstraints(){}
    func makeAlert(message : String, button: String = "확인"){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
     
     
    

}
