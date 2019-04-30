//
//  RegisterViewController.swift
//  Blogy
//
//  Created by admin on 23/09/2017.
//  Copyright © 2017 malekmouzayen. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var userFullnameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let confirmPassword = userConfirmPasswordTextField.text
        
        if userEmail == "" {
            showAlertBox(title: "Missing Fields", message: "Email field is empty")
            return
        } else if !isValidEmail(testStr: userEmail!){
            showAlertBox(title: "Wrong email", message: "The email addresse is not valied")
            return
        } else if userPassword == "" {
            showAlertBox(title: "Missing Fields", message: "Password field is empty")
            return
        } else if confirmPassword == ""  {
            showAlertBox(title: "Missing Fields", message: "Confirm password field is empty")
            return
        } else if confirmPassword != userPassword {
            showAlertBox(title: "Missing Fields", message: "Passwords do not match")
            return
        }
        
        handelUserRegisteration(userEmail: userEmail!, userPassword: userPassword!)
    }
    
    func handelUserRegisteration(userEmail: String, userPassword: String) {
        print("handel called")
        
        let activiteIndecator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activiteIndecator.center = view.center
        activiteIndecator.hidesWhenStopped = false
        view.addSubview(activiteIndecator)
        activiteIndecator.startAnimating()
        
        let regURL = URL(string: "https://reqres.in/api/register")
        var request = URLRequest(url: regURL!)
        request.httpMethod = "POST"
        let postString = ["email": userEmail, "password": userPassword]
        
        Alamofire.request("https://reqres.in/api/register", method: .post, parameters: postString).responseJSON { response in
            print("Result: \(response.result)")
            
            if let json = response.result.value  as? [String: Any] {
                print("JSON: \(json)") // serialized json response
                if let _ = json["token"] as? String {
                    
                } else {
                    self.showAlertBox(title: "Error", message: "Some thing went wrong, try agin later.")
                    return
                }
            }
            //            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            //                print("Data: \(utf8Text)") // original server data as UTF8 string
            //            }
            activiteIndecator.stopAnimating()
            activiteIndecator.hidesWhenStopped = true
        }
        if let tabViewController = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController {
            present(tabViewController, animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    func showAlertBox(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func isValidEmail(testStr: String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
