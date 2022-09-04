//
//  MainTableViewCell.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    let titleLabel : UILabel = {
       let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .bold)
    
        return view
        
    }()
    
    let stackView : UIStackView = {
        let view = UIStackView()
        view.spacing = 5
        view.axis = .horizontal
        return view
    }()
    
    let timeLabel : UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let contentsLabel : UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    
    func configure(){
        self.addSubview(titleLabel)
        self.addSubview(stackView)
        [timeLabel, contentsLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        
    }
    
    func constraints(){
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(10)
            make.topMargin.equalTo(10)
            make.height.equalTo(30)
          
        }
        
        stackView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(10)
            make.topMargin.equalTo(titleLabel.snp.bottomMargin).offset(10)
            make.height.equalTo(20)
        }
        
        
    }
}
