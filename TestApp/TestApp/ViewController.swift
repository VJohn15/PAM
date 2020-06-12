//
//  ViewController.swift
//  TestApp
//
//  Created by We For Web on 12/06/2020.
//  Copyright © 2020 We For Web. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    var responseArray = [Data]()
    
    func callAPI() {
        Alamofire.request(URL(string: "https://jsonplaceholder.typicode.com/posts")!, method: .get,
                parameters: nil, headers: nil).responseJSON { (response) in
                if let responseData = response.data {
                    do {
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        self.responseArray = try decodeJSON.decode([Data].self, from: responseData)
                        self.tableView.reloadData()
                    }
                    catch {
                        
                    }
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(responseArray[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = responseArray[indexPath.row].title
        
        return cell
    }
    
    
}
