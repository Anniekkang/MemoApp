//
//  MainViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit
import RealmSwift


class MainViewController: BaseViewController {

    var filteredArr: [String] = []
    var tasks : Results<memoModel>!
    var writeButton: UIBarButtonItem!
    var fixedMemoCount = 0
    let mainView = MainView()
   
  
    
   
    let localRealm = try! Realm()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
       
        mainView.backgroundColor = .darkGray
        fetchRealm()
        configuration()
        toolbarDesign()
        setupSearchController()
        

        makeAlert(message: "처음 오셨군요! \n 환영합니다 :) \n\n 당신만의 메모를 작성하고 \n 관리해보세요!")

    }
    
    func setupSearchController(){
        
        let numberFormatter = NumberFormatter()
        NumberFormatter().numberStyle = .decimal
        let newCount = numberFormatter.string(for: tasks.count)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
        
        var isSearchBarEmpty : Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        
        }
        
      
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.orange
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "\(newCount!)개의 메모"
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.clear
      
        searchController.searchResultsUpdater = self
        
//        searchController.searchBar.searchTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidEnd)
//
       
        
        
    }
    
//    @objc func textFieldTapped(){
//        let vc = SearchTableViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
//
//
//
//    }
//
    
    override func viewWillAppear(_ animated: Bool) {
    
        fetchRealm()
    }
    
    //새롭게 업데이트 된 realm을 가져오는 것
    func fetchRealm(){
        tasks = localRealm.objects(memoModel.self).sorted(byKeyPath: "date", ascending: true)
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
        if section == 0 {
            return fixedMemoCount
        } else {
            return tasks.count - fixedMemoCount
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if fixedMemoCount == 0 {
                let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
                return headerView
            } else {
                let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
                let label = UILabel()
                label.frame = CGRect.init(x: 0 , y: 0, width: headerView.frame.width, height: headerView.frame.height)
                label.text = "고정된 메모"
                label.font = .systemFont(ofSize: 25, weight: .bold)
                label.textColor = .white

                headerView.addSubview(label)
                return headerView
            }
            

           
        } else {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.frame = CGRect.init(x: 0 , y: 0, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "메모"
            label.font = .systemFont(ofSize: 25, weight: .bold)
            label.textColor = .white

            headerView.addSubview(label)

            return headerView
            
        }
        
        
        

    }
    

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         //realm에서 false를 true 로 바꿈.혹은 반대
        let fixed = UIContextualAction(style: .normal, title: "fixed") { action, view, completionHandler in
            
            try! self.localRealm.write{
                
                self.tasks[indexPath.row].fixed = !self.tasks[indexPath.row].fixed
                self.fetchRealm()
                //false가 true로 바뀜
                
            }
   
        }
  
        fixed.backgroundColor = .orange
        fixed.image?.withTintColor(.white)
        //realm 에서 fixed 값이 true인 data -> section 0, false -> section 1
    
        if memoModel().fixed {
            //true (section = 0)
            fixed.image = UIImage(systemName: "pin.slash.fill")
            fixedMemoCount += 1
        } else {
            //false (section = 1)
            fixed.image = UIImage(systemName: "pin.fill")
            fixedMemoCount -= 1
        }
        
        
        tableView.reloadData()
        
        if fixedMemoCount > 5 {
                let alert = UIContextualAction(style: .normal, title: "deny") { action, view, completionHandler in
                
                self.makeAlert(message: "더이상 추가할 수 없습니다", button: "확인")

                
                }
        
            return UISwipeActionsConfiguration(actions: [alert])
        }
        
        return UISwipeActionsConfiguration(actions: [fixed])
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "delete") { action, view, completionHandler in
            
            try! self.localRealm.write({
                self.localRealm.delete(self.tasks[indexPath.row])
            
            })
            tableView.reloadData()
    }
        
        return UISwipeActionsConfiguration(actions: [delete] )
        
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
    
        
        cell.backgroundColor = .systemGray
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.contentsLabel.text = tasks[indexPath.row].contents
        cell.timeLabel.text = "\(tasks[indexPath.row].date)"
        cell.contentView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
     
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

  
}

extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let vc = SearchTableViewController()
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true)
    }
}

//extension UIColor {
//    static var navigationBarColor : UIColor {
//        if #available(iOS 13, *) {
//            return UIColor { (traitCollection : UITraitCollection) -> UIColor in
//                if traitCollection.userInterfaceStyle == .dark {
//                    return UIColor(red: 18.0/255.0, green: 18.0/255.0, blue: 18.0/255.0, alpha: 1.0)
//                } else {
//                    return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
//                }
//            }
//
//            }
//        else {
//            return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 240.0/255.0)
//        }
//    }
//}
