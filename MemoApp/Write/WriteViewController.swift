//
//  WriteViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit
import RealmSwift

class WriteViewController: BaseViewController {

    let localRealm = try! Realm()
   
    var tasks : Results<memoModel>! {
        didSet {
            print("tasked changed!")
        }
    }
    
    
    let mainView = WriteView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .darkGray
        naviDesign()

        mainView.textview.becomeFirstResponder()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    func naviDesign(){
        //navigationitem design
         let leftButton = UIButton(type: .system)
         leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
         leftButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
         leftButton.setTitle("메모", for: .normal)
         leftButton.sizeToFit()
         leftButton.tintColor = .orange
         leftButton.setTitleColor(.orange, for: .normal)
         leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
         
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
         

         
         let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
    
         let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
         
         rightButton.tintColor = .orange
         shareButton.tintColor = .orange
         
         navigationItem.rightBarButtonItems = [rightButton,shareButton]
        
        
    }
    
    @objc func shareButtonTapped(){
        //share
        
    }
    
    @objc func doneButtonTapped(){
        //save text(realm에 저장) or 아무것도 없을시 삭제함
        
        
        if mainView.textview.text.isEmpty {
            self.navigationController?.popViewController(animated: true)
           } else {
            //save text(realm)
               let contents = mainView.textview.text
               let task = memoModel(title: "mola",date: Date(), contents: contents)
               do {
                   try localRealm.write{
                              localRealm.add(task)
                              print("realm succeed")
                       }
                   } catch {
                       print(Error.self)
                   }
            
               //나타내기
        
               
              
               MainViewController().mainView.tableView.reloadData()
               
               
               
               
               
        }
  
        
    }
    
    

    @objc func backButtonTapped(){

        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
       }
     
    
    



}
