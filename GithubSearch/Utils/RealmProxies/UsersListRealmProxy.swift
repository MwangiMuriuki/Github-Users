//
//  UsersListRealmProxy.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 14/02/2022.
//

import Foundation
import RealmSwift


//struct UsersListRealmProxy<RealmManager: GithubRealmManager>: RealmProxiable{
//    var showUsers: RealmQuery<UserItemsRealm> {
//        return query(sortProperty: "login", ordering: .ascending)
//    }
//
//    func append(_ userItemsRealm: UserItemsRealm) {
//        rm.transaction(writeHandler: { (realm) in
//            realm.add(userItemsRealm, update: .all)
//        })
//    }
//    
//    func appendList(_ userItemsRealmList: [UserItemsRealm]) {
//        rm.transaction(writeHandler: { (realm) in
//            realm.add(userItemsRealmList, update: .all)
//            
//        })
//    }
//    
//}
