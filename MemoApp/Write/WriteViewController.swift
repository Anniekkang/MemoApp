//
//  WriteViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit
import RealmSwift
import CoreMIDI

class WriteViewController: BaseViewController, UINavigationControllerDelegate {

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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        
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
              
               let task = memoModel(title: title.string ,date: Date(), contents: contents.string, status: 0)
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
              
               let task = memoModel(title: title.string ,date: Date(), contents: contents.string, status: 0)
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
        
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
       }
    
   
}

extension StringProtocol where Index == String.Index {
    var partialRangeOfFirstLine: PartialRangeUpTo<String.Index> {
        return ..<(rangeOfCharacter(from: .newlines)?.lowerBound ?? endIndex)
    }
    
    var partialRangeOfContents : PartialRangeFrom<String.Index> {
        return (rangeOfCharacter(from: .newlines)?.upperBound ?? firstLine.endIndex)...
    }
  
    var rangeOfFirstLine: Range<Index> {
        return startIndex..<partialRangeOfFirstLine.upperBound
    }
    
    var rangeofContents : Range<Index> {
        return partialRangeOfContents.lowerBound..<endIndex
    }
    var firstLine: SubSequence {
        return self[partialRangeOfFirstLine]
    }
    
    var contentsLine : SubSequence {
        return self[partialRangeOfContents]
    }
    
}

extension WriteViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

