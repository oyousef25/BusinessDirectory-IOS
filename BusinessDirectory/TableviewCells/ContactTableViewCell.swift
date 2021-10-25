//
//  ContactTableViewCell.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessHead: UILabel!
    @IBOutlet weak var companyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*
        This method is used to set the values for the UI elements with the object's returned data
     */
    func setUpCell(using business: ContactList){
        businessHead.text = business.contactName
        companyName.text = business.companyName
        
        //set a default image in case there is no poster
        businessImage.image = UIImage(named: "sample")
        
        //get the poster path string
        guard let imagePath = business.contactLogo else { return }
        
        //build a url to fetch the album and load the image
        if let url = buildImageUrl(for: imagePath){
            print(url)
            loadPoster(url: url, forCell: self)
        }
    }
    
    /*
        This method will be building a valid image URL
     */
    func buildImageUrl(for path: String) -> URL? {
        let imagePath = path
        
        guard let imageURL = URL(string: imagePath) else { return nil}

        return imageURL
    }
    
    /*
        This method will load the image from the URL
     */
    func loadPoster(url: URL, forCell cell: ContactTableViewCell){
        /*
         Starting a new URL session to read the image from the url
         */
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url){
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let companyLogo = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.businessImage.image = companyLogo
                }
            }
        }
        task.resume()
    }
}
