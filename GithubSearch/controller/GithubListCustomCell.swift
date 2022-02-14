//
//  GithubListCustomCell.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 12/02/2022.
//

import UIKit

class GithubListCustomCell: UITableViewCell {
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
      //  view.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainContentView)
        mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        mainContentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mainContentView.addSubview(avatar)
        mainContentView.addSubview(userName)
        
        avatar.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 5).isActive = true
        avatar.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 45).isActive = true
        avatar.layer.cornerRadius = 22.5
        
        mainContentView.addSubview(userName)
        userName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10).isActive = true
        userName.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor).isActive = true
        userName.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .white
        avatar.layer.cornerRadius = 20
        avatar.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func populateData(with model: UserItems){
        
        self.userName.text = model.login
      
        let avatarLink =  URL(string: (model.avatar_url)!)
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


}
