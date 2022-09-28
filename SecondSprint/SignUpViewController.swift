//
//  SignUpViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreData

// Start ofSignupViewController class
class SignUpViewController: UIViewController {
    
    //Outlet Start
    @IBOutlet weak var regLabel: UILabel!
    @IBOutlet weak var bagImage: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailIDTxt: UITextField!
    @IBOutlet weak var mobileNoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    //Outlet End
    
    var regEmail = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding corner radius to SignUp Button
        signUpButton.layer.cornerRadius = 10
    }
    
    
    //Testing Part
    static func getVC() -> SignUpViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return vc
    }
    
    //MARK: Validation Functions
    
        //Valid Name function
    func isValidName(personName: String) -> Bool{
        let nameRegx = "^([a-zA-z]{4,})"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegx)
        return nameTest.evaluate(with: personName)
    }
    
    //Valid Email Function
    func isValidEmail(email: String) -> Bool{
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        return emailTest.evaluate(with: email)
    }
    
    // Valid Number function
    func isValidPhoneNumber(number: String) -> Bool{
        let numRegx = "[0-9]{10}"
        let numTest = NSPredicate(format: "SELF MATCHES %@", numRegx)
        return numTest.evaluate(with: number)
    }
            
    // Valid Password function
    func isValidPassword(pass: String) -> Bool{
        let passRegx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", passRegx)
        return passTest.evaluate(with: pass)
    }
    
    
    
    //Core data
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    //save data in coredata
    func save(object: [String : String]){
        let detail = NSEntityDescription.insertNewObject(forEntityName: "SprintDetails", into: context!) as! SprintDetails
        detail.name = object["name"]
        detail.emailID = object["emailID"]
        detail.mobileNo = object["mobileNo"]
        detail.password = object["password"]
    
        do{
            try context?.save()
        }catch{
            print("data not saved")
        }
    }

    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        //Dictionary to store data
        let detailsDict = ["name": nameTxt.text, "emailID": emailIDTxt.text, "mobileNo": mobileNoTxt.text, "password": passwordTxt.text]
        //fetch details from coredata
        var details = [SprintDetails]()
        let detailsFetch = NSFetchRequest<NSManagedObject>(entityName: "SprintDetails")
        do{
            details = try context?.fetch(detailsFetch) as! [SprintDetails]
            print(details)
        }catch{
            print("Cannot get data")
        }
        
        //store email in array
        for email in details{
        regEmail.append(email.emailID)
        
    }
        //check for existing users
        if regEmail.contains(emailIDTxt.text!){
            let emailId: String = emailIDTxt.text!
            let password:String = passwordTxt.text!
            registerUser(emailId: emailId, pass: password)
        }
        
        else if let name = self.nameTxt.text, let emailId = self.emailIDTxt.text, let num = self.mobileNoTxt.text, let password = self.passwordTxt.text, let confirmPassword = self.confirmPasswordTxt.text{
        
        // Proper Name check
        if name.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please enter Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
            return
        })
    }
    
        else if isValidName(personName: name) == false{
            let alert = UIAlertController(title: "Alert", message: "Name must contain atleast 4 alphabets", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
            return
        })
    }
        //Proper emailid check
        else if emailId.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please enter EmailId", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
        })
    }
        else if isValidEmail(email: emailId) == false{
            let alert = UIAlertController(title: "Alert", message: "Your EmailId is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
        })
        
    }
    
    // proper number check
        else if num.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please enter mobile number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
        })
    }
        else if isValidPhoneNumber(number: num) == false{
            let alert = UIAlertController(title: "Alert", message: "Your number is incorrect. Must contain 10 digits", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
        })
        
    }
    
        //proper password check
       else if password.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please enter Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
        })
    }
        else if isValidPassword(pass: password) == false{
            let alert = UIAlertController(title: "Alert", message: "Your Password is incorrect. Minimum 6 characters with atleast 1 alphabet, 1 special character and a number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }
            
        //Matching password check
        else if confirmPassword != passwordTxt.text{
            let alert = UIAlertController(title: "Alert", message: "Password not matching ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
            return
                 })
             }
                
        // save data in firebase as well as in coredata
        else{
            let emailId: String = emailIDTxt.text!
            let password: String = passwordTxt.text!
            save(object: detailsDict as! [String:String])
            print(detailsDict)
            let categoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            self.navigationController?.pushViewController(categoryVC, animated: true)
                 
            registerUser(emailId: emailId, pass: password)
                 }
             }
      
    }//signUp button action end
    
    //Function to register User in Firebase
    func registerUser(emailId: String, pass: String){
        Auth.auth().createUser(withEmail: emailId, password: pass, completion: {
            (result, error) -> Void in
            if let _error = error{
                print(_error.localizedDescription)
                let alert = UIAlertController(title: "Alert", message: _error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: {
                return
                     })
                
            }
            else{
                print("User Registered Success!!")
            }
        })
    }
    
    
}//end of SignUp ViewController class
