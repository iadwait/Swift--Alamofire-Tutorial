//
//  ViewController.swift
//  Alamofire MVVM
//
//  Created by Adwait Barkale on 15/07/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.vc = self
        //userViewModel.getAllUserData()
        userViewModel.getAllUserDataAF()
        tblView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }

}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userViewModel.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        let modelUser = userViewModel.arrUsers[indexPath.row]
        if let id = modelUser.id
        {
            cell?.lblId.text = "\(id)"
        }else{
            cell?.lblId.text = "No Id"
        }
        cell?.lblTitle.text = modelUser.title
        let status = modelUser.getStatusColor()
        cell?.lblStatus.text = status.0
        cell?.backgroundColor = status.1
        return cell!
    }
    
}

