//
//  ViewController.swift
//  Day7
//
//  Created by admin on 7/20/18.
//  Copyright © 2018 meosteam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constanst
    var contacts : [ContactModel]?

    // MARK: - outlet
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - action
    @IBAction func actionAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddViewController") as!  AddViewController
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = viewHeader
        tableView.tableHeaderView?.layoutIfNeeded()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        contacts =  DatabaseManager.instanle.getAllContacts()
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = contacts?.count{
            return count
        }
        else{
            return 0
        }
    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.imageAvatar.image = UIImage(data: contacts![indexPath.row].avatar!)
        cell.lbName.text = contacts?[indexPath.row].name
        cell.lbContact.text = contacts?[indexPath.row].phone
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


// MARK: - Receive and update table
extension ViewController: UpdateDelegate{
    func update() {
        contacts?.removeAll()
        contacts =  DatabaseManager.instanle.getAllContacts()
        tableView.reloadData()
    }
}
