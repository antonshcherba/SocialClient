//
//  ContactsViewController.swift
//  SocialClient
//
//  Created by Admin on 16/08/15.
//  Copyright © 2015 antonShcherba. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ContactsViewController: UITableViewController {
    var contacts: Dictionary<String,String> = [String: String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            var fbRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, birthday, education"])
            
            fbRequest.startWithCompletionHandler({ [unowned self](connection, result, error) -> Void in
                if error == nil {
                    print("All is OK")
                    
                    if let responseDictionary = result as? Dictionary<String, AnyObject> {
                        let userName = responseDictionary["name"] as! String
                        let userEmail = responseDictionary["email"] as! String
                        //let userBirthDay = responseDictionary["birthday"] as! String
                        //let userEducation = responseDictionary["education"] as! String
                        
                        self.contacts["name"] = userName
                        self.contacts["email"] = userEmail
                        //self.contacts["birthday"] = userBirthDay
                        //self.contacts["education"] = userEducation
                        print("My username: \(userName)")
                        self.tableView.reloadData()
                        
                    }
                } else {
                    print(error.localizedDescription)
                }
                })
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
        let key = Array(contacts.keys)[indexPath.row]
        cell.textLabel!.text = key
        cell.detailTextLabel?.text = contacts[key]
        
        return cell
    }

}
