//
//  ServiceCallManager.swift
//  GithubSearch
//
//  Created by Ernest Mwangi on 12/02/2022.
//

import Foundation

struct ServiceCallManager{
    
    var delegate: ServiceCallManagerDelegate?
    
    let baseURL = "https://api.github.com/search/users?q=lagos"
    let session = URLSession(configuration: .default)
    
    func fetchUsersList(pageNumber: Int?){
        
        let urlString = "\(baseURL)&page=\(pageNumber ?? 1)"
        print("FullUrl: \(urlString)")
        if let fullUrl = URL(string: urlString){
            
            let task = session.dataTask(with: fullUrl) { data, response, error in
                if error != nil {
                    print("List Error: \(String(describing: error))")
                    self.delegate?.errorResponse(error: error!.localizedDescription)
                    return
                }
                if let safeData = data {
                    if let fetchedData = self.parseJSON(userListData: safeData){
                        self.delegate?.successResponse(response: fetchedData)
                    }
                }
            }
            task.resume()
        }
    }
    
   
    func parseJSON(userListData: Data) -> UsersDataClass?{
        do {
            let decodedUserList = try JSONDecoder().decode(UsersDataClass.self, from: userListData)
           
            return decodedUserList
            
        } catch {
            print(error)
           return nil
        }
    }
}

protocol ServiceCallManagerDelegate{
    func successResponse(response: UsersDataClass)
    func errorResponse(error: String)
}
