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
    //We will be using this core data stack to load our contact items
    lazy var coreDataStack = CoreDataStack(modelName: "BusinessDirectory")
    
    //MARK: Properties
    //Here we will store our loaded results
    var contactList = [ContactList]()
    
    func fetchContactList(){
        //Loading all the current contact items that we have
        let fetchRequest: NSFetchRequest<ContactList> = ContactList.fetchRequest()
        
        //Sorting the results
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "contactName", ascending: true)]
        
        do {
            //Fetching the contacts and assigning them to our contactList
            contactList = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch {
            print("There was an error fetching the taskLists: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding rounded corners to the cell view
        
        
        //Setting the data source for the tableview to use our data source methods in the extension.
        tableView.dataSource = self
    }
    
    //This will refresh the page every time it appears
    override func viewWillAppear(_ animated: Bool) {
        //Loading out current contact items
        fetchContactList()
        //Refreshing our tableview
        tableView.reloadData()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the cell information to the details view controller
        guard let destinationVC = segue.destination as? ContactsDetailsViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        //Passing the selected contact item to the details controller to work with it
        destinationVC.contactList = contactList[indexPath.row]
    }
}

//MARK: TableView Datasource
//This method will tell the tableview about how many rows it is supposed to return
extension ContactsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    //This method will be changing the values of the cell with whatever we have in the contatList
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creating a new contact cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        //Getting the current cell using the index path
        let contactList = contactList[indexPath.row]
        
        //Setup cell using our cell class
        cell.setUpCell(using: contactList)
        
        //returning our modified cell
        return cell
    }
    
    //This will allow us to delete items from our table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Getting the current contact
            let contact = contactList[indexPath.row]
            //Delete this item from the core data
            coreDataStack.persistentContainer.viewContext.delete(contact)
            //removing the item from the array
            contactList.remove(at: indexPath.row)
            //delete the row from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)

            //Save the current state of the core data
            coreDataStack.saveContext()
        }
    }
}
