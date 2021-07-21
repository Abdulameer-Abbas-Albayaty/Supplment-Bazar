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
    
    @IBOutlet weak var txtName: DizneyAuthTextField!
    @IBOutlet weak var txtMobileNumber: DizneyAuthTextField!
    @IBOutlet weak var txtPassword: DizneyAuthTextField!
    @IBOutlet weak var txtPasswordConfirm: DizneyAuthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let name = txtName.text, name.count > 3 else {
            pop.configCancelable(messgae: "name_field_required".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        guard let mobileNumber = txtMobileNumber.text, mobileNumber.count >= 10 else {
            pop.configCancelable(messgae: "phone_number_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        guard let password = txtPassword.text, password.count >= 8 else {
            pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        guard let confirmPassword = txtPasswordConfirm.text, confirmPassword.count >= 8 else {
            pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        if password != confirmPassword {
            pop.configCancelable(messgae: "password_mismatch".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        
        let sign = SignupRequestData(name: name, phone_number: mobileNumber, password: password, password_confirmation: confirmPassword)
        signup.showActivityIndicator()
        viewModel.signup(body: sign) { (message) in
            self.signup.hideActivityIndicator()
            if let _ = message {
                self.performSegue(withIdentifier: toOtp, sender: mobileNumber)
            }
        }
    }

}
