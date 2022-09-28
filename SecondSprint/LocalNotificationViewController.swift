//
//  LocalNotificationViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import NotificationFramework

    // class LocalNotificationViewController start
class LocalNotificationViewController: UIViewController, UNUserNotificationCenterDelegate{

    @IBOutlet weak var localNotificationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Testing part
    static func getVC() -> LocalNotificationViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LocalNotificationViewController") as! LocalNotificationViewController
        return vc
    }
    @IBAction func localNotificationButtobClicked(_ sender: Any) {
        
        let notify = Notification()
        notify.localNotification()
        
    }
}// class end
