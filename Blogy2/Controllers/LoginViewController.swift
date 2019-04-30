//
//  LoginViewController.swift
//  Blogy
//
//  Created by admin on 22/09/2017.
//  Copyright © 2017 malekmouzayen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        if userEmail == "" {
            showAlertBox(title: "Missing Fields", message: "Email field is empty")
            return
        } else if !isValidEmail(testStr: userEmail!){
            showAlertBox(title: "Wrong email", message: "The email addresse is not valied")
            return
        } else if userPassword == "" {
            showAlertBox(title: "Missing Fields", message: "Password field is empty")
            return
        }
        handelLogin(userEmail: userEmail!, userPassword: userPassword!)
    }

    func handelLogin(userEmail: String, userPassword: String) {
        print("handle login")
        
        let activiteIndecator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activiteIndecator.center = view.center
        activiteIndecator.hidesWhenStopped = false
        view.addSubview(activiteIndecator)
        activiteIndecator.startAnimating()
        
        let regURL = URL(string: "https://reqres.in/api/register")
        var request = URLRequest(url: regURL!)
        request.httpMethod = "POST"
        
        let postString = ["email": userEmail, "password": userPassword]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            
//            print(data)
//            print(response)
        }
        task.resume()
        activiteIndecator.stopAnimating()
        if let tabViewController = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController {
            present(tabViewController, animated: true, completion: nil)
        }
        
    }
}
