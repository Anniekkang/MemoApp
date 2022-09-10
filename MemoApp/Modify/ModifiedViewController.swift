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
        textSetup()
        
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
            
            
            //save text(realm) && status == 0
            
            let task = localRealm.objects(memoModel.self).first!
            do {
                try localRealm.write{
                    task.title = title.string
                    task.contents = contents.string
                    task.date = Date()
                    task.status = 0
                    print("realm succeed")
                    
                }
            } catch {
                print(Error.self)
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
