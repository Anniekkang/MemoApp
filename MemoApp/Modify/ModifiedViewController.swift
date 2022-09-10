//
//  ModifiedViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/10.
//

import UIKit
import RealmSwift

class ModifiedViewController: BaseViewController, UITextViewDelegate {

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
        textSetup()
        self.mainView.textview.delegate = self
    }
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
       
        changeRightNavi()
        textView.isUserInteractionEnabled = true
    }
    
    
    func changeRightNavi(){
        let leftButton = UIButton(type: .system)
        leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        leftButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        leftButton.sizeToFit()
        leftButton.tintColor = .orange
        leftButton.setTitleColor(.orange, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        leftButton.setTitle("메모", for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donebuttonTapped))
        rightButton.tintColor = .orange
        shareButton.tintColor = .orange
        navigationItem.rightBarButtonItems = [rightButton,shareButton]
   
        
    }
    // MARK:  이 아래 버튼을 누르면 기존의 것이 변경되는것이아니라 새로 생겨서 저장된다
    @objc func donebuttonTapped(){
        
        //save text(realm에 저장) or 아무것도 없을시 저장안함
        
        
        if mainView.textview.text.isEmpty {
            self.navigationController?.popViewController(animated: true)
           } else {
               //save title
               let str = mainView.textview.text ?? ""
               let attributedString = NSMutableAttributedString(string: str)
               let title = NSAttributedString(string: String(str.firstLine))
               let range = NSRange(str.rangeOfFirstLine, in: str)
               attributedString.replaceCharacters(in: range, with: title)
               
               //save contents
               let contents = NSAttributedString(string: String(str.contentsLine))
               let range2 = NSRange(str.rangeofContents, in : str)
               attributedString.replaceCharacters(in: range2, with: contents)
               
               
               
            //save text(realm)
              
               let task = memoModel(title: title.string ,date: Date(), contents: contents.string, status: 0, donebuttonStatus: true)
               do {
                   try localRealm.write{
                       if task.donebuttonStatus == false {
                           task.donebuttonStatus = true
                           task.title = title.string
                           task.date = Date()
                           task.contents = contents.string
                           task.status = 0
                       }
                            
                              print("realm succeed")
                       
                       }
                   } catch {
                       print(Error.self)
                   }
            
               //나타내기
        
               MainViewController().mainView.tableView.reloadData()
      
        }

    }

 
    
    func textSetup(){
        //data 가져오기(title,contents)
        let selectedRealm = localRealm.objects(memoModel.self).filter("status == 1")
        
        dump(selectedRealm)
        
        mainView.textview.text = selectedRealm[0].title + "\n" + selectedRealm[0].contents
  
        
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
        
        if mainView.textview.text.isEmpty {
            //기존에 있던 메모 지우기
            
            
            
        } else {
            if localRealm.objects(memoModel.self).filter("donebuttonStatus == true").isEmpty{
                //false 일 떄,저장버튼안눌림, 이동하기, realm의 donebuttonStataus = false 그대로
                
                let str = mainView.textview.text ?? ""
                let attributedString = NSMutableAttributedString(string: str)
                let title = NSAttributedString(string: String(str.firstLine))
                let range = NSRange(str.rangeOfFirstLine, in: str)
                attributedString.replaceCharacters(in: range, with: title)
                
                //save contents
                let contents = NSAttributedString(string: String(str.contentsLine))
                let range2 = NSRange(str.rangeofContents, in : str)
                attributedString.replaceCharacters(in: range2, with: contents)
                
                //save text(realm)
                
                let task = memoModel(title: title.string ,date: Date(), contents: contents.string, status: 0, donebuttonStatus: false)
                do {
                    try localRealm.write{
                        localRealm.add(task)
                        print("realm succeed")
                        
                    }
                } catch {
                    print(Error.self)
                }
                
                
            } else {
                //true = 저장버튼 눌림(realm에 status 를 false로 업데이트)
                //save title
                
               try! localRealm.write {
                    localRealm.objects(memoModel.self).first?.donebuttonStatus = false
                }
                
            }
            //나타내기
            MainViewController().mainView.tableView.reloadData()
           
            
        }
        
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
       }
        
    
    @objc func shareButtonTapped(){
        
        
        
        
        
    }

    
}
