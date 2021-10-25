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
    
    //MARK: Outlets
    @IBOutlet weak var bussinesName: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bussinesName.text = contactList?.companyName
        contactName.text = contactList?.contactName
        contactNumber.text = contactList?.contactNumber
    }
}
