//
//  ViewController.swift
//  LoginComponent
//
//  Created by 박정태 on 2020/01/03.
//  Copyright © 2020 JeongTae Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    

    @IBOutlet weak var loginBtnByGet: UIButton!
    @IBOutlet weak var loginBtnBypost: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginBtnByGet.layer.cornerRadius = 5
        loginBtnByGet.clipsToBounds = true
        
        loginBtnBypost.layer.cornerRadius = 5
        loginBtnBypost.clipsToBounds = true
    }


    @IBAction func loginByGet(_ sender: Any) {
        guard let id = idInput.text else {
           return
       }
       
       guard let password = idInput.text else {
           return
       }
       
       print(id, password)
       let url = URL(string: "http://127.0.0.1:3000")!
       let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, res, err) in
          
           guard let data = data, err == nil else { return }
               if let res = res as? HTTPURLResponse {
                   print("status code: \(res.statusCode)")
               }
               let json = try? JSONSerialization.jsonObject(with: data, options: [])
               if let dictionary = json as? [String: Any] {
                   print(dictionary)
                   
                   if let number = dictionary["data"] as? Int {
                       print(number)
                   }
               }
          
           
       })
       
       task.resume()
    }
    
    @IBAction func loginByPost(_ sender: Any) {
       guard let id = idInput.text else {
            return
        }
        
        guard let password = idInput.text else {
            return
        }
        
        print(id, password)
        let url = URL(string: "http://127.0.0.1:3000")!
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = "id=\(id)&password=\(password)".data(using:String.Encoding.utf8, allowLossyConversion: false)

        request.httpBody = body


        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
           
            guard let data = data, err == nil else { return }
                if let res = res as? HTTPURLResponse {
                    print("status code: \(res.statusCode)")
                }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any] {
                    print(dictionary)
                    
                    if let number = dictionary["data"] as? Int {
                        print(number)
                    }
                }
           
            
        })
        
        task.resume()
    }
}

