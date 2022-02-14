//
//  UsersRealmDataClass.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 14/02/2022.
//

import Foundation
import RealmSwift

class UsersRealmDataClass: Object, Decodable {
    @objc dynamic var total_count: Int = 0
    @objc dynamic var incomplete_results: Bool = false
    var items = Array<UserItemsRealm>()
}

class UserItemsRealm: Object, Decodable {
    @objc dynamic var login : String?
    @objc dynamic var id : Int = 0
    @objc dynamic var node_id : String?
    @objc dynamic var avatar_url : String?
    @objc dynamic var gravatar_id : String?
    @objc dynamic var url : String?
    @objc dynamic var html_url : String?
    @objc dynamic var followers_url : String?
    @objc dynamic var following_url : String?
    @objc dynamic var gists_url : String?
    @objc dynamic var starred_url : String?
    @objc dynamic var subscriptions_url : String?
    @objc dynamic var organizations_url : String?
    @objc dynamic var repos_url : String?
    @objc dynamic var events_url : String?
    @objc dynamic var received_events_url : String?
    @objc dynamic var type : String?
    var site_admin : Bool?
    var score : Double?
}
