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
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty else {
                let alertController = UIAlertController(title: "Invalid", message: "Empty first or last name detected. Please enter complete make sure both fields are filled.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
        }
        
        let newUser = User()
        newUser.firstName = firstName
        newUser.lastName = lastName
        
        if segue.identifier == "toBday",
            let destinationViewController = segue.destination as? BirthdayViewController {
            
            destinationViewController.newUser = newUser
        }
    }
    
}

extension NameViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}