//
//  MainViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit
import SwiftUI

class MainViewController: BaseViewController {

    var writeButton: UIBarButtonItem!
    var memoList : [String] = []
    var fixedMemo = 0
    let mainView = MainView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mainView.backgroundColor = .darkGray
        
        
        makeAlert(message: "처음 오셨군요! \n 환영합니다 :) \n\n 당신만의 메모를 작성하고 \n 관리해보세요!")
        navDesign()
        configuration()
        toolbarDesign()
       
        
    }
    
    func toolbarDesign(){
        
        self.navigationController?.isToolbarHidden = false
        writeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(writeButtonTapped))
        writeButton.tintColor = .orange
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        [flexibleSpace,writeButton].forEach {
            items.append($0)
        }

        self.toolbarItems = items
       

        
    }
    
    @objc func writeButtonTapped(){
        
        let vc = WriteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func navDesign(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "\(memoList.count)개의 메모"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
    }
    
    override func configuration() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView.tableView.backgroundColor = .black
    }

    
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width-10, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 50, y: 10, width: headerView.frame.width-20, height: headerView.frame.height-10)
        label.text = "메모"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        
        cell.backgroundColor = .systemGray
        return cell
        
    }
    
    
    
    
    
}
