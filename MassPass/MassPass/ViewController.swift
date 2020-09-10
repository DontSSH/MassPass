//
//  ViewController.swift
//  MassPass
//
//  Created by Dennis Yilmaz on 8/29/20.
//  Copyright © 2020 Dennis Yilmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
    }

    @IBAction func signupClick(_ sender: Any)
    {
        print("signing up")
    }
    
    @IBAction func loginClick(_ sender: Any)
    {
        
        print("logining in")
        
    }
}
