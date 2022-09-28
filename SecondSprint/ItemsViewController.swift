//
//  ItemsViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


//ItemsViewController Class Start
class ItemsViewController: UIViewController {
    
    var items = [String]()
    
    //outlet of table view
    @IBOutlet weak var itemTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
    
    
    //Testing Part
    static func getVC() -> CartViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        return vc
    }
    
    //Parsing JSON
    func fetchJSON(){
        Alamofire.request("https://dummyjson.com/products/categories", method: .get, encoding: URLEncoding.default, headers: nil).responseJSON{
            (response) in
            switch response.result
            {
            case .success:
                let data: NSArray = response.result.value as! NSArray
                for index in 0...(data).count-1
                {
                    self.items.append((data[index] as AnyObject).stringValue)
                    
                }
                self.itemTable.reloadData()
                
            case .failure:
                print("Error fetching JSON")
                
            }
            
        }
    }

}//end of class

// Displaying table
extension ItemsViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController
        vc?.item = items[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
