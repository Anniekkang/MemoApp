//
//  MainViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit
import Foundation
import RealmSwift
import SwiftUI


class MainViewController: BaseViewController, UISearchBarDelegate, UISearchControllerDelegate {
     
    let localRealm = try! Realm()
    
    var tasks : Results<memoModel>!
    var writeButton: UIBarButtonItem!
    let mainView = MainView()
    var fixedMemoCount = 0
    var filteredCell : [memoModel] = []
    
    override func loadView() {
        self.view = mainView
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(#function)
        print("Realm is located at:", localRealm.configuration.fileURL!)
       
        mainView.backgroundColor = .darkGray
        fetchRealm()
        configuration()
        toolbarDesign()
        setupSearchController()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userDefault()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        fetchRealm()
        print(#function)
    }

    func userDefault(){
        if UserDefaults.standard.bool(forKey: "open") == false {
            let vc = popUpViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        
        
    }
   
    func numberformatter(count : Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let newCount = numberFormatter.string(for:count)
        return newCount!
    }
    
    
    func setupSearchController(){
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
        
        var isSearchBarEmpty : Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        
        }
        
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = UIColor.orange
        searchController.searchBar.delegate = self
        searchController.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
       
     
        if tasks.count >= 1000 {
            self.navigationItem.title = "numberformatter(count: tasks.count)개의 메모"
        } else {
            self.navigationItem.title = "\(tasks.count)개의 메모"
        }
        
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

    var isFiltering: Bool {
        
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
      
        return isActive || isSearchBarHasText
    
    }
    

}


extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isFiltering {
          return 1
        } else {
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
    
        cell.backgroundColor = .systemGray
        if self.isFiltering {
            
            cell.textLabel?.text = filteredCell[indexPath.row].title
            cell.contentsLabel.text = filteredCell[indexPath.row].contents
            cell.timeLabel.text = "\(filteredCell[indexPath.row].date)"
        } else {
           
            cell.textLabel?.text =  tasks[indexPath.row].title
            cell.contentsLabel.text = tasks[indexPath.row].contents
    
            
            
            cell.timeLabel.text = "\(tasks[indexPath.row].date)"
        }
     
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //active and hastext 일 때
        if self.isFiltering {
            return filteredCell.count
        } else {
      
        if section == 0 {
            return fixedMemoCount
        } else {
            return tasks.count - fixedMemoCount
        }
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if self.isFiltering {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.frame = CGRect.init(x: 0 , y: 0, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "\(filteredCell.count)개 찾음 "
            label.font = .systemFont(ofSize: 25, weight: .bold)
            label.textColor = .white

            headerView.addSubview(label)
            return headerView
            
            
        } else {
        
        
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
        

    }
    
 
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         //realm에서 false를 true 로 바꿈.혹은 반대
        
        let fixed = UIContextualAction(style: .normal, title: "fixed") { [self] action, view, completionHandler in
            
            try! self.localRealm.write{
                self.tasks[indexPath.row].fixed = !self.tasks[indexPath.row].fixed
                self.fetchRealm()
                //false가 true로 바뀜(in realm)
        
            }
           
            let zeroSection = tasks.filter("fixed = true")
            let oneSection = tasks.filter("fixed = false")

            


//            if tasks[indexPath.row].fixed {
//                //section = 0 에서 필요한 배열
//
//                sectionZeroArr.append(tasks[indexPath.row])
//                if sectionOneArr.contains(tasks[indexPath.row]) {
//                    sectionOneArr.remove(at: indexPath.row)
//                }
//            } else {
//                //section = 1 에서 필요한 배열
//                sectionOneArr.append(tasks[indexPath.row])
//                if sectionZeroArr.contains(tasks[indexPath.row]) {
//                    sectionZeroArr.remove(at: indexPath.row)
//                }
//
//            }
//
//
            fixedMemoCount = zeroSection.toArray().count
            if self.fixedMemoCount > 5 {
                self.makeAlert(message: "더이상 추가할 수 없습니다")
     
            }
            tableView.reloadData()
            
        }
    
        let image = self.tasks[indexPath.row].fixed ? "pin.slash.fill" : "pin.fill"
        fixed.image = UIImage(systemName: image)
        fixed.backgroundColor = .orange
        fixed.image?.withTintColor(.white)
        
        return UISwipeActionsConfiguration(actions: [fixed])
    }
 
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancel = UIContextualAction(style: .normal, title: "cancel") { action, view, completionHandler in
            completionHandler(false)
        }

        let delete = UIContextualAction(style: .destructive, title: "delete") { action, view, completionHandler in
            //realm에 있는 메모 지우기
            try! self.localRealm.write({
                self.localRealm.delete(self.tasks[indexPath.row])
                
            })
            
            let alert = UIAlertController(title: nil, message:  "정말로 삭제하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "네", style: .default, handler: { UIAlertAction in
                completionHandler(false)
            }))
            alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: { UIAlertAction in
                completionHandler(true)
            }))
            
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = view.bounds
            self.present(alert, animated: true)
            
        }
        
        tableView.reloadData()
        
        
        return UISwipeActionsConfiguration(actions: [cancel,delete])
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
   
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRealm = tasks[indexPath.row]
        
        try! self.localRealm.write({
                if (selectedRealm.status == 0){
                    selectedRealm.status = 1
                }else{
                    selectedRealm.status = 0
                }
            })
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        let vc = ModifiedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
 
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }



//search
extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let someModelResults: Results<memoModel> = localRealm.objects(memoModel.self)
        let someModelArray: [memoModel] = someModelResults.toArray()
        
        
        guard let text = searchController.searchBar.text else { return }
        print(text)
        self.filteredCell = someModelArray.filter({ $0.contents.contains(text) || $0.title.contains(text) })
        
        dump(filteredCell.count)
        
        mainView.tableView.reloadData()
   
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
