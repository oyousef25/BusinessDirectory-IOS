//
//  ContactsViewController.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-20.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var companyHead: UILabel!
    @IBOutlet weak var companyName: UILabel!
    
    //MARK: Core Data
    lazy var coreDataStack = CoreDataStack(modelName: "BusinessDirectory")
    var contactList = [ContactList]()
    
    func fetchContactList(){
        let fetchRequest: NSFetchRequest<ContactList> = ContactList.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "contactName", ascending: true)]
        
        do {
            contactList = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch {
            print("There was an error fetching the taskLists: \(error.localizedDescription)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContactList()
        //tableview.reloadData()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the cell information to the details view controller
        guard let destinationVC = segue.destination as? ContactsDetailsViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destinationVC.contactList = contactList[indexPath.row]
    }
}

//MARK: TableView Datasource
extension ContactsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        let contactList = contactList[indexPath.row]
        
        cell.setUpCell(using: contactList)
        
        return cell
    }
}
