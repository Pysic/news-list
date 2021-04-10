//
//  NewsFeedTableViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 09/04/21.
//

import UIKit
import Alamofire

class NewsFeedTableViewController: UITableViewController {

    private var news: [NewsDataModel] = []
    private var isLoading: Bool = false
    private var totalPage: Int = 0
    private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    private func requestNews(){
        self.isLoading = true
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(ControllersUtils().getToken())",
            "Content-Type": "application/json"
        ]
        
        AlamoService().newsApi(url: .NEWS, headers: headers) { (response) in
            self.news += response.data
            self.totalPage = response.pagination.total_pages
            self.isLoading = false
            DispatchQueue.main.async {
                self.view.loaderElement(indicator: self.indicator, show: false)
                self.tableView.reloadData()
            }
        } onError: { (response) in
            self.isLoading = false
            print(response)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        
        if let details = segue.destination as? NewsDetailsViewController{
            let article = news[tableView.indexPathForSelectedRow?.row ?? 0]
            details.article = article
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        requestNews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsFeedTableViewCell
        let article = news[indexPath.row]
        
        cell.renderArticle(with: article)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == news.count - 5 && !self.isLoading && news.count != self.totalPage){
            requestNews()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
