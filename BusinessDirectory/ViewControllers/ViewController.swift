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
        
        /*
            Setting up the delegate and data source for the tableView
         */
        tableview.dataSource = self
    }
}

//MARK: Extensions

//MARK: TableView Datasource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let url = createBusinessURL(){
            fetchBusinesses(from: url)
        } else{
            print("Can't read URL")
        }
        return businessesResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! BusinessTableViewCell

        let business = businessesResults[indexPath.row]
        cell.setUpCell(using: business)
        
        return cell
    }
    
    //MARK: API METHODS
    /*
        Function to create a valid URL
     */
    func createBusinessURL() -> URL?{
        //Create the url string and return it
        let urlString = "https://dtakaki.scweb.ca/mad510/testData.json"
        print(urlString)
        
        
        return URL(string: urlString)
    }
    
    
    /*
        Fetch the Businesses from the API
     */
    func fetchBusinesses(from url: URL){
        //Starting a new url session to fetch data from the JSON object thats returned by our URL
        let businessTask = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            //Handling any errors and diplaying them
            if let error = error {
                print("There was an error fetching the data - \(error.localizedDescription)")
            } else {
                do {
                    //Unwrapping using optional binding to make sure its not nil
                    guard let someData = data else { return }
                    
                    /*
                        Decoding the JSON data
                     */
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(Businesses.self, from: someData)
                    
                    //Adding all the results to our businesses array
                    self.businessesResults = downloadedResults.results
                } catch let error {
                    print("Problem decoding: \(error.localizedDescription)")
                }
                
                //Reloading the tableview to display the new results
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
        businessTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the cell information to the details view controller
        guard let destinationVC = segue.destination as? BusinessDetailsViewController, let indexPath = tableview.indexPathForSelectedRow else { return }
        
        destinationVC.business = businessesResults[indexPath.row]
    }
}

