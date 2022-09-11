//
//  popUpViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/12.
//

import UIKit
import SnapKit


class popUpViewController: BaseViewController {

    let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
        
    }()
    
    let label : UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "처음 오셨군요! \n 환영합니다 :) \n\n 당신만의 메모를 작성하고 \n 관리해보세요!"
        view.numberOfLines = 5
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.backgroundColor = .clear
        view.textAlignment = .center
        
        return view
    }()
    
    let button : UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .orange
        view.setTitle("확인", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.layer.cornerRadius = 8
        
        return view
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configuration()
      
    }
    
    override func configuration() {
        [button, label].forEach {
            mainView.addSubview($0)
        }
        
        self.view.addSubview(mainView)
        
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender : UIButton){
        self.dismiss(animated: true) {
            UserDefaults.standard.set(true, forKey: "open")
        }
        
    }
    
    
    override func setConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.6)
            make.height.equalTo(mainView.snp.width)
            
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.topMargin).offset(-10)
            make.trailingMargin.equalTo(mainView.snp.trailingMargin).offset(-10)
            make.leadingMargin.equalTo(mainView.snp.leadingMargin).offset(10)
            make.height.equalTo(label.snp.width)
            make.centerX.centerY.equalTo(mainView)
            
        }
        
        button.snp.makeConstraints { make in
            make.leadingMargin.equalTo(mainView).offset(20)
            make.trailingMargin.equalTo(mainView).offset(-20)
            make.bottomMargin.equalTo(mainView).offset(-10)
            make.height.equalTo(label).multipliedBy(0.2)
            
        }
        
        
        
        
    }

}
