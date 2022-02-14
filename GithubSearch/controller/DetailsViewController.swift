//
//  DetailsViewController.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 12/02/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
//    lazy var navigationBar: UINavigationBar = {
//        let navBar = UINavigationBar()
//        navBar.tintColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
//        navBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
//        navBar.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
//        return navBar
//    }()
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.tintColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.tintColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "githubBlack")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var username: String? = ""
    var avatarString: String? = ""
    
    var pasedData = UserItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        navBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 52).isActive = true
        let navItem = UINavigationItem(title: "User Details")
        let backItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(goBack))
        navItem.leftBarButtonItem = backItem
        navItem.titleView?.tintColor = .white
        navBar.setItems([navItem], animated: false)

        addSubViews()
        setConstraints(navigationBar: navBar)
        setupNavBar()
        loadViews()
    }
    
    func setupNavBar(){
      
    }
    
    func addSubViews(){
      
        view.addSubview(mainContentView)
        mainContentView.addSubview(headerView)
        headerView.addSubview(avatar)
        headerView.addSubview(userName)
        mainContentView.addSubview(bottomView)
        
    }
    
    func setConstraints(navigationBar: UINavigationBar){
//        navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 52).isActive = true
//        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    
        
        mainContentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        headerView.topAnchor.constraint(equalTo: self.mainContentView.topAnchor, constant: 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: 0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        avatar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        avatar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatar.layer.cornerRadius = 50
        
        userName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10).isActive = true
        userName.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 10).isActive = true
        userName.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 1).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: 0).isActive = true
    
    }
    
    func loadViews(){
        userName.text = pasedData.login
        
        let avatarLink =  URL(string: (pasedData.avatar_url)!)
        do {
            if let imageUrlData = avatarLink {
                let url_data = try Data(contentsOf: imageUrlData)
                avatar.image = UIImage(data: url_data)
            }
            else{
                avatar.image = #imageLiteral(resourceName: "githubBlack")
            }
        }
        catch{
            print("Image Error", error)
        }
        
    }
    
    @objc func goBack(){
        
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
