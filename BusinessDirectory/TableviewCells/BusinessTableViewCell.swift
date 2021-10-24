//
//  BusinessTableViewCell.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-22.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyContact: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*
        This method is used to set the values for the UI elements with the object's returned data
     */
    func setUpCell(using business: Business){
        companyName.text = business.businessName
        companyContact.text = "Company Contact: \(business.companyHead ?? "")"
    }
}
