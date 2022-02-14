//
//  ViewController.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 11/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
        
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.image = UIImage(named:"searchLogo.jpg")
        return v
    }()
    
    
    lazy var getStartedBtn: UIButton = {
        let btnStart = UIButton()
        btnStart.translatesAutoresizingMaskIntoConstraints = false
        btnStart.setTitle("Get Started", for: .normal)
        btnStart.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
        btnStart.setTitleColor(.white, for: .normal)
        btnStart.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        btnStart.layer.cornerRadius = 12
        return btnStart
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        addSubViews()
        setConstraints()
    
    }
    
    func addSubViews(){
        self.view.addSubview(imageView)
        self.view.addSubview(getStartedBtn)
    }
    
    func setConstraints(){
        imageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
       // getStartedBtn.center = self.view.center
        getStartedBtn.widthAnchor.constraint(equalToConstant: 250).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getStartedBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        
    }
    
    
    @objc func goToHome() {
        let rootVC = HomeViewController()
        rootVC.title = "Home"
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
        navVC.navigationBar.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4274509804, blue: 0.7921568627, alpha: 1)
        present(navVC, animated: true)
    }
}

