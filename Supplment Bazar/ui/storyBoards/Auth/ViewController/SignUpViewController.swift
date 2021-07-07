//
//  SignUpViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/07/2021.
//

import UIKit

private let toOtp = "toOtp"

class SignUpViewController: AuthBaseViewController<SignupViewModel> {

    @IBOutlet weak var signup: DizneyButton!
    
    @IBOutlet weak var txtPasswordConfirm: DizneyAuthTextField!
    @IBOutlet weak var txtPassword: DizneyAuthTextField!
    @IBOutlet weak var txtMobileNumber: DizneyAuthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signButtonTapped(_ sender: Any) {
        guard let mobileNumber = txtMobileNumber.text else {return}
        guard let password = txtPassword.text else {return}
        guard let confirmPassword = txtPasswordConfirm.text else {return}
        if mobileNumber.count < 10 {
            pop.configCancelable(messgae: "phone_number_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        } else if password.count < 8 {
            pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        } else if confirmPassword.count < 8 {
            pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        } else if password != confirmPassword {
            pop.configCancelable(messgae: "password_mismatch".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        
        view.endEditing(true)
        let sign = SignupRequestData(phone_number: mobileNumber, password: password, password_confirmation: confirmPassword)
        signup.showActivityIndicator()
        viewModel.signup(body: sign) { (message) in
            self.signup.hideActivityIndicator()
            if let _ = message {
                self.performSegue(withIdentifier: toOtp, sender: mobileNumber)
            }
        }
    }

}
