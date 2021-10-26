//
//  ContactsDetailsViewController.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-20.
//

import UIKit

class ContactsDetailsViewController: UIViewController {
    
    //MARK: Properties
    var contactList: ContactList?
    
    var products = [String]()
    
    //MARK: Outlets
    //Our UI elemts on the page
    @IBOutlet weak var bussinesName: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var callTomorrowAction: UIButton!
    
    //Our products tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func callTomorrow(_ sender: Any) {
        //Create an alert controller
        let ac = UIAlertController(title: "Call Information", message: "A reminder has been set for tomorrow", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //Schedule a notification in 10 seconds
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bussinesName.text = contactList?.companyName
        contactName.text = contactList?.contactName
        contactNumber.text = contactList?.contactNumber
        
        //products = contactList?.contactProducts ?? [""]
        
        tableView.dataSource = self
    }
}

//MARK: TableView Datasource
extension ContactsDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contactList!.contactProducts!.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

//        let contactList = products[indexPath.row]
//
//        cell.textLabel?.text = contactList
        
        return cell
    }
}
