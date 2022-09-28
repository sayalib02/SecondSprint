//
//  AddToCartViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import CoreData
import Alamofire
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


//start AddToCartViewController class
class AddToCartViewController: UIViewController {
    
    var item = ""
    var url = "https://dummyjson.com/products/category/"
    var items = [[String: Any]]()
    var titleData = ""
    var descriptionData = ""
    
    //outlet for table view
    @IBOutlet weak var itemTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = url + item
        fetchJSON()
    }
    
    //Testing part
    static func getVC() -> AddToCartViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
        return vc
    }
    
    //Core data
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    //save data in coredata
        func save(object: [String : String]){
            let detail = NSEntityDescription.insertNewObject(forEntityName: "Item1", into: context!) as! Item1
            detail.emailID = object["emailID"]
            detail.title = object["title"]
            detail.describe = object["describe"]
        
            do{
                try context?.save()
            }catch{
                print("data not saved")
        }
    }
    
    
    //JSON Parsing
    func fetchJSON(){
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseJSON{
            (response) in
            
            switch response.result
            {
            case .success:
                if let json = response.result.value as! [String: Any]?{
                    if let responseValue = json["products"] as! [[String: Any]]?{
                        self.items = responseValue
                        
                        self.itemTable.reloadData()
                    }
                }
            case .failure:
                print("Error fetching JSON")
            }
        }
    }
    }// end of class
    
//Displaying Table
extension AddToCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
        cell.titleLabel.text = items[indexPath.row]["title"] as? String
        cell.describeLabel.text = items[indexPath.row]["description"] as? String
        cell.cartButton.tag = indexPath.row
        cell.cartButton.addTarget(self, action: #selector(cartButtonFunction), for: .touchUpInside)
        return cell
    }
    
    @objc func cartButtonFunction(sender: UIButton)
    {
        // To get row data
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        titleData = items[indexpath1.row]["title"] as! String
        descriptionData = items[indexpath1.row]["description"] as! String
        
        let userEmail = Auth.auth().currentUser?.email
        
        let detailsDict = ["emailID": userEmail,"title": titleData, "describe": descriptionData]
        print(detailsDict)
        save(object: detailsDict as! [String:String])
        
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
        
    }
}
