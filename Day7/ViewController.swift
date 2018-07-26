//
//  ViewController.swift
//  Day7
//
//  Created by admin on 7/20/18.
//  Copyright © 2018 meosteam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contacts : [Contacts]?

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func actionAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddViewController") as!  AddViewController
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        contacts =  DatabaseManager.instanle.getAllContacts(context: context)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        contacts =  DatabaseManager.instanle.getAllContacts(context: context )
        tableView.reloadData()
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

