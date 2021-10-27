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
    //This will tell the table =view about ho many rows it is supposed to return
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let url = createBusinessURL(){
            //Fetching all businesses from the URL
            fetchBusinesses(from: url)
        } else{
            print("Can't read URL")
        }
        
        //Sorting our results
        let sortedList:[Business] = businessesResults.sorted{
                $0.businessName ?? "businessName" < $1.businessName ?? "businessName"
        }
        
        //Assigning our array to the sorted results
        self.businessesResults = sortedList
        
        //Returning the size of our array
        return businessesResults.count
    }
    
    //This will give the views in our cells the appropiriate values that were loaded from the api
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creating a new instance of our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! BusinessTableViewCell

        //Locationg our current cell
        let business = businessesResults[indexPath.row]
        
        //Setting up the cell using our cell class methods
        cell.setUpCell(using: business)
        
        //Returning our ready-to-go cell
        return cell
    }
    
    //MARK: API METHODS
    /*
        Function to create a valid URL
     */
    func createBusinessURL() -> URL?{
        //We will use this url to fetch the JSON data
        let urlString = "https://dtakaki.scweb.ca/mad510/testData.json"
        print(urlString)
        
        //Returning our URL
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
                    
//                    //Adding all the results to our businesses array
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
    
    //This method will allow us to pass whatever we need to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //this will have the information about which cell we are navigating to
        guard let destinationVC = segue.destination as? BusinessDetailsViewController, let indexPath = tableview.indexPathForSelectedRow else { return }
        
        //Passing the selected business object to the details controller
        destinationVC.business = businessesResults[indexPath.row]
    }
}

