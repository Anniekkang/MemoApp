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
        
        configuration()
        setConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView : UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        
        
        return view
        
    }()
    
    override func configuration() {
        [tableView].forEach {
            self.addSubview($0)
        }
       
    }
    
    override func setConstraints() {

        tableView.snp.makeConstraints { make in
            make.leadingMargin.trailingMargin.bottomMargin.equalTo(safeAreaLayoutGuide)
            make.topMargin.equalTo(20)
            
        }
        
        
        
    }
    
    
}
