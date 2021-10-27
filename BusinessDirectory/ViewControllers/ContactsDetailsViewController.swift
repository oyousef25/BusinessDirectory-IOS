//
//  ContactsDetailsViewController.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-20.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ContactsDetailsViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    //MARK: Properties
    var contactList: ContactList?
    
    var products = [String]()
    
    //MARK: Outlets
    //Our UI elemts on the page
    @IBOutlet weak var bussinesName: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var callTomorrowAction: UIButton!
    
    //Our products tableView
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setting the page's UI elements values to whatever we have in the contactlist item
        bussinesName.text = contactList?.companyName
        contactName.text = contactList?.contactName
        contactNumber.text = contactList?.contactNumber
                
        //products = contactList?.contactProducts ?? [""]
        
        //Setting the data source for the products table view
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userActivity = NSUserActivity(activityType: "ca.myscc.oy.coreSpotlight")
        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPublicIndexing = false
        
        guard let contact = contactList else{return}
        
        userActivity.title = contact.contactName
        userActivity.keywords = ["hummus", "shawarma", "Mickey Mouse"]
        
        var attributeSet: CSSearchableItemAttributeSet{
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeData as String)
            attributeSet.contentDescription = contact.companyName
            attributeSet.phoneNumbers = [contact.contactNumber ?? "000 000 0000"]
            //attributeSet.phoneNumbers = ["555 555 5555"]
            attributeSet.supportsPhoneCall = true
            
            return attributeSet
        }
        
        userActivity.contentAttributeSet = attributeSet
        
        self.userActivity = userActivity
        self.userActivity?.becomeCurrent()
        
    }
    
    //MARK: Methods
    /*
        Asking the user for permission when using for the first time
     */
    @objc func registerLocal(){
        //Get the current context of the notification centre
        let centre = UNUserNotificationCenter.current()
        
        //These are the properties of our notifiation(It will have a sound, alert and a badge features)
        centre.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            
            if granted{
                print("WHoop")
            }else{
                print("OH NO!")
            }
        }
    }
    
    //MARK: Actions
    /*
     Acheduling a notification in 10 seconds when the user clicks on the call tomorrow button
     */
    @IBAction func callTomorrow(_ sender: Any) {
        //Create an alert controller
        let ac = UIAlertController(title: "Call Information", message: "A reminder has been set for tomorrow", preferredStyle: .alert)
        
        //Adding action to our alert controller and presenting it
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        /*
         Schedule a notification in 10 seconds
         */
        //We are going to ask the user for permission in the first time
        registerLocal()
                
        //Creating a new notification centre
        let centre = UNUserNotificationCenter.current()
        centre.removeAllPendingNotificationRequests()
        
        //Styling the contents of the notification
        let content = UNMutableNotificationContent()
        content.title = "Phone Call Reminder"
        content.body = "Please remember to call \(contactList?.contactName ?? "") today"
        content.categoryIdentifier = "alarm"
        content.sound = .default
                
        //Creating a trigger to show the notification at a specific time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //Creating a new notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        //Displaying the notification
        centre.add(request)
    }
}

//MARK: TableView Datasource
extension ContactsDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contactList!.contactProducts!.count
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)

//        let contactList = products[indexPath.row]
//
//        cell.textLabel?.text = contactList
        
        cell.textLabel?.text = "hummus"
        cell.imageView?.image = UIImage(systemName: "\(indexPath.row + 1).square")

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top 10 Products"
    }
}
