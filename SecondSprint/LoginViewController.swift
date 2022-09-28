//
//  ViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import LocalAuthentication
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreData

//Class Login ViewController Start
class LoginViewController: UIViewController {
    
    //Outlet Start
    @IBOutlet weak var bagsImage: UIImageView!
    @IBOutlet weak var emailIDTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    //Outlet End
    
    var regEmail = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add corner radius to login and SignUp button
        loginButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor
        authenticateUserByFaceID()

    }
    
    //Testing part
    static func getVC() -> LoginViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
    
    //Email Validation function
    func isValidEmail(emailId: String) -> Bool{
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        return emailTest.evaluate(with: emailId)
    }
    
    //Login Button clicked action
    @IBAction func loginButtonClicked(_ sender: Any) {
    
    //check for valid email
    //Check if Email field is empty
        if let email = self.emailIDTxt.text  {
            if email.isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Your EmailId field is empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
        }
    
        if isValidEmail(emailId: email) == false{
                let alert = UIAlertController(title: "Alert", message: "Your EmailId is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }
            }
        
        //Check if password is Empty
        if let password =  self.passwordTxt.text, password.isEmpty{
               let alert = UIAlertController(title: "Alert", message: "Your Password field is empty", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: {
                   return
               })
           }
        
        //CoreData
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
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
            print(regEmail)
        
    }
        //New User Condition
        if !(regEmail.contains(emailIDTxt.text!)) {
            let emailId: String = emailIDTxt.text!
            let pass: String = passwordTxt.text!
            loginUser(email: emailId, password: pass)
        }
        
        else{
            let emailId: String = emailIDTxt.text!
            let pass: String = passwordTxt.text!
            loginUser(email: emailId, password: pass)
            
        }
        
        
        
        
        
    }//end login button clicked function
    
    //Function for logging user
    func loginUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (result,error) -> Void in
            
            if let _error = error{
                print(_error.localizedDescription)
                
                let alert = UIAlertController(title: "Alert", message: _error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: {
                 return
                 })
            }
            else{
                print("Logged in")
                let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(tabVC, animated: true)
                self.navigationItem.setHidesBackButton(true, animated: true)
            }
        })
        
    }
    
    //Function for authenticating user by FaceId
    func authenticateUserByFaceID(){
        let context1 = LAContext()
        var error: NSError?
        let reasonStr = "Identify Yourself"
        if context1.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context1.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonStr){
                [weak self] success, authenticationError in
                DispatchQueue.main.sync {
                    if success{
                        self?.showAlert(msgStr: "Authenticated Success", title: "Sucess")
                    }
                    else{
                        self?.showAlert(msgStr: "Authentication Failed", title: "Failed")
                    }
                }
            }
        }
        else{
            self.showAlert(msgStr: "No Biometric", title: "Error")
        }
    }

    //Alert Function
    func showAlert(msgStr: String, title: String){
        let alert = UIAlertController(title: title, message: msgStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}//end of Login View Controller class

