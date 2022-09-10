//
//  WriteView.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/04.
//

import UIKit

class ModifiedView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let textview : UITextView = {
        let view = UITextView()
        view.backgroundColor = .black
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.textColor = .white
        return view
        
    }()
    
    let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func configuration() {
        backgroundView.addSubview(textview)
        self.addSubview(backgroundView)
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        textview.snp.makeConstraints { make in
            make.topMargin.leadingMargin.equalTo(20)
            make.bottomMargin.trailing.equalTo(-20)
        }
    }
    

}

