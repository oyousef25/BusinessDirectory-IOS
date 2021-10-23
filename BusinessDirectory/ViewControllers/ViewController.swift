//
//  ViewController.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-19.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var businessesResults = [Business]()
    
    
    //MARK: Outlets
    @IBOutlet weak var tableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

//MARK: Extensions

//MARK: TableView Delegate
extension ViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //Find the cell that was clicked on by the user
//        let selectedAlbum = albumResults[indexPath.row]
//
//        /*
//            Create an alert controller to display the album name that was added to the cart
//         */
//        let ac = UIAlertController(title: "\(String(describing: selectedAlbum.collectionName!)) added to cart!", message: nil, preferredStyle: .alert)
//
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//    }
}


//MARK: TableView Datasource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! BusinessTableViewCell

//        let business = albumResults[indexPath.row]
//        cell.setUpCell(using: business)
        
        return cell
    }
}

