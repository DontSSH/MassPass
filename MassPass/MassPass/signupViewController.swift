//
//  signupViewController.swift
//  MassPass
//
//  Created by Dennis Yilmaz on 8/30/20.
//  Copyright © 2020 Dennis Yilmaz. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import SwiftSocket

class signupViewController: UIViewController {

    let host = "192.168.1.158"
    let port = 13000
    var client: TCPClient?
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    
        @IBOutlet weak var fn_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client = TCPClient(address: host, port: Int32(port))
        
        //
        emailField.delegate = self
        lastnameField.delegate = self
        firstnameField.delegate = self
        //
        emailField.tag = 3
        lastnameField.tag = 2
        firstnameField.tag = 1
        //
    }
    
    
    @IBAction func signupClicked(_ sender: Any)
    {
        print("saving user-data")
        save_data()
    }
    

    let user_email: String = ""
    let user_firstname: String = ""
    let user_lastname: String = ""
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    func save_data()
    {
        let DocumentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let DirPath = DocumentDirectory.appendingPathComponent("massPASS")
        do
        {
            try FileManager.default.createDirectory(atPath: DirPath!.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError
        {
            print("Unable to create directory \(error.debugDescription)")
        }
        print("Dir Path = \(DirPath!)")
        
        print("collecting information")
        // let me collect the info
        
        let user_email: String = (emailField.text ?? "no_email")
        print(user_email)
        
        let user_firstname: String = (firstnameField.text ?? "default name")
        print(user_firstname)
        
        let user_lastname: String = (lastnameField.text ?? "default last")
        print(user_lastname)
        
        verify_email()
        
        
    }

    func verify_email()
         
    {
        
        //let client = TCPClient(address: "10.1.23.213", port: 13000)
        //let data: Data = Data("verification".utf8) // ... Bytes you want to send
        //let result = client.send(data: data)
        
        
        //let client = TCPClient(address: "10.1.23.213", port: 13000)
        //switch client.connect(timeout: 1) {
        //case .success :
          //  print("connection successfull")
        //    client.send(data: data)
         //   break
        //case .failure(let error) :
        //    print(error.localizedDescription)
         //   break
            
        let user_email: String = (emailField.text ?? "no_email")
        
        let client = TCPClient(address: "10.1.23.213", port: 13000)
        switch client.connect(timeout: 1) {
          case .success:
            print("connected to verification server")
            let intcode = Int.random(in: 100000000...999999999)
            print(intcode)
            let stringcode = String(intcode)
            let finalcode = stringcode + "$%$" + user_email + "$%$" + "verification"
            print(finalcode)
            
            switch client.send(string: finalcode ) {
              case .success:
                    
                    print("server handshake")
                    client.close()
                    print("closed connection")
                
              case .failure(let error):
                print(error)
            }
          case .failure(let error):
            print(error)
        }
        
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
}

extension signupViewController: UITextFieldDelegate {
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
return true
}
}
