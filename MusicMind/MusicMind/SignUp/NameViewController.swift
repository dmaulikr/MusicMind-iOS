//
//  NameViewController.swift
//  MusicMind
//
//  Created by Angel Contreras on 3/28/17.
//  Copyright © 2017 MusicMind. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty else {
                let alertController = UIAlertController(title: "Invalid", message: "Empty first or last name detected. Please make sure both fields are filled.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.user
//        user.firstName = firstName
//        user.lastName = lastName
        
        if segue.identifier == "toBday",
            let birthdayViewController = segue.destination as? BirthdayViewController {
            
//            birthdayViewController.newUser = user
        }
    }
    
}

extension NameViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //TODO: disable the signUpButton until there is text in the both first name and last name textfield.
        return true
    }
}