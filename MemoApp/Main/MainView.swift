//
//  MainView.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit
import SnapKit

class MainView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let searchBar : UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "검색"
        view.backgroundColor = .systemGray2
        return view
    }()
    
    let tableView : UITableView = {
        let view = UITableView()
        return view
        
    }()
    
    override func configuration() {
        [searchBar,tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.trailingMargin.leadingMargin.topMargin.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(self).multipliedBy(0.2)
        }
        tableView.snp.makeConstraints { make in
            make.trailingMargin.leadingMargin.bottomMargin.equalTo(safeAreaLayoutGuide)
            make.topMargin.equalTo(searchBar.snp.bottomMargin)
            
        }
        
        
        
    }
    
    
}
