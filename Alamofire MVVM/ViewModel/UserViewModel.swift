//
//  UserViewModel.swift
//  Alamofire MVVM
//
//  Created by Adwait Barkale on 15/07/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import Alamofire

class UserViewModel
{
    
    weak var vc: ViewController?
    var arrUsers = [UserModel]()
    
    
    //using Alamofire
    func getAllUserDataAF()
    {
        AF.request("https://jsonplaceholder.typicode.com/todos").response{ response in
            if let data = response.data
            {
                do{
                    let userResponse = try JSONDecoder().decode([UserModel].self, from: data)
                    //print(userResponse)
                    //                    for userModel in userResponse{
                    //                        self.arrUsers.append(userModel)
                    //                    }
                    self.arrUsers.append(contentsOf: userResponse)
                    DispatchQueue.main.async {
                        self.vc?.tblView.reloadData()
                    }
                    //print(self.arrUsers)
                }catch let err{
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    
    //using URL Session
    func getAllUserData()
    {
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos")!) { (data, response, error) in
            if error == nil{
                if let data = data
                {
                    do{
                        let userResponse = try JSONDecoder().decode([UserModel].self, from: data)
                        //print(userResponse)
                        //                    for userModel in userResponse{
                        //                        self.arrUsers.append(userModel)
                        //                    }
                        self.arrUsers.append(contentsOf: userResponse)
                        DispatchQueue.main.async {
                            self.vc?.tblView.reloadData()
                        }
                        //print(self.arrUsers)
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
}
