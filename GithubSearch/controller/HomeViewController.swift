//
//  HomeViewController.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 12/02/2022.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.tintColor = .white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.tintColor = .white
        tv.allowsSelection = true
        tv.contentMode = .scaleToFill
        tv.rowHeight = 60
        return tv
    }()
    
  //  var userDataClass: UsersRealmDataClass?
    var userDataClass: UsersDataClass?
    var usersList = [UserItems]()
  //  var usersDataList = [UserItemsRealm]()

//    var usersListProxy = UsersListRealmProxy()
//    var usersListRealm = UsersListRealmProxy().showUsers
    var serverurl: String = ""
    var pageNum = 1
    
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    let spinner = UIActivityIndicatorView(style: .medium)
    var serviceManager = ServiceCallManager()
    var fetchingMoreData = false

//    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let heartimage = #imageLiteral(resourceName: "heart")
        view.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
        let menuButton = UIBarButtonItem(image: heartimage, style: .plain, target: self, action: #selector(goToFavourites))
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        serviceManager.delegate = self
        addSubViews()
        addViewConstraints()
        setupTableView()
        setupActivityIndicator()
        setupFooterIndicator()
        
        fetchData()
        
//        if (realm.isEmpty){
//            fetchData()
//        }
//        else{
//
//            DispatchQueue.main.async { [self] in
//                let results: Results<UserItemsRealm> = realm.objects(UserItemsRealm.self).sorted(byKeyPath: "login", ascending: true)
//                let converted = results.reduce(List<UserItemsRealm>()) { (list, element) -> List<UserItemsRealm> in
//                    list.append(element)
//                    return list
//                }
//
//                usersDList = converted
//                self.tableView.reloadData()
//            }
//        }
        
    }
    
    func setupTableView(){
        tableView.register(GithubListCustomCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = true
    }
    
    func addSubViews(){
        view.addSubview(mainContentView)
        mainContentView.addSubview(tableView)
    }
    
    func addViewConstraints(){
        mainContentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -5).isActive = true
    
    }
    
    func setupActivityIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7041453178)
        activityIndicator.color = .white
        activityIndicator.layer.cornerRadius = 10
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupFooterIndicator(){
        spinner.startAnimating()
        spinner.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7041453178)
        spinner.color = .white
        spinner.layer.cornerRadius = 10
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(44), height: CGFloat(44))
    }
    
    @objc func goToFavourites(){
        
    }
    
    func fetchData(){
        activityIndicator.startAnimating()
        serviceManager.fetchUsersList(pageNumber: pageNum)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GithubListCustomCell
        let userListData = usersList[indexPath.row]
        cell.populateData(with: userListData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = usersList[indexPath.row]
        
        let vc = DetailsViewController()
      //  vc.username = data.login
        vc.pasedData = data
//        vc.controllerTitle = data.group_name ?? ""
        
        let navCtrl = UINavigationController(rootViewController: vc)
        navCtrl.modalPresentationStyle = .fullScreen
        present(navCtrl, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath) {
        
        let lastIndex = self.usersList.count - 1
               if indexPath.row == lastIndex {
                   print("End of List")
                   tableView.tableFooterView?.isHidden = false
                   pageNum = pageNum + 1
                   print("Next Page: \(pageNum)")
                   serviceManager.fetchUsersList(pageNumber: pageNum)
                   
               }
        }
}


extension HomeViewController : ServiceCallManagerDelegate{
    func successResponse(response: UsersDataClass) {
        userDataClass = response
        if userDataClass != nil {
            
          //  usersList = (userDataClass?.items)!
            usersList.append(contentsOf: userDataClass!.items)
            
         //   UsersListRealmProxy().appendList(usersDataList)
            
            DispatchQueue.main.async { [self] in
                
//                usersDataList.append(objectsIn: userDataClass!.items)
//                
//                try! realm.write({
//                    realm.add(usersDataList)
//                })
//                
//                let results: Results<UserItemsRealm> = realm.objects(UserItemsRealm.self).sorted(byKeyPath: "login", ascending: true)
//                let converted = results.reduce(List<UserItemsRealm>()) { (list, element) -> List<UserItemsRealm> in
//                    list.append(element)
//                    return list
//                }
//                
//                usersDList = converted
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    func errorResponse(error: String) {
        activityIndicator.stopAnimating()
        print("Error Fetching Users: \(error)")
    }
}
