//
//  LoginViewController.swift
//  SocialClient
//
//  Created by Admin on 16/08/15.
//  Copyright (c) 2015 antonShcherba. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    let permissions = ["public_profile", "email", "user_friends", "user_birthday", "user_education_history"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fbLoginButton.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            performSegueWithIdentifier("fbLogged", sender: self)
        }
        
        //let loginButton = FBSDKLoginButton()
        //loginButton.center = view.center
        //view.addSubview(fbLoginButton)
        fbLoginButton.readPermissions = permissions
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if result.grantedPermissions.contains(permissions[0]) {
            performSegueWithIdentifier("fbLogged", sender: self)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //presentViewController(self, animated: true, completion: nil)
        return
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "fbLogged" {
            print("goes to Contacts")
        }
    }


}

