//
//  LoginViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 05/07/2021.
//

import UIKit

private let toOTP = "toOTP"

class LoginViewController: AuthBaseViewController<LoginViewModel> {
    
    @IBOutlet weak var txtPassword: DizneyAuthTextField!
    @IBOutlet weak var txtMobileNumber: DizneyAuthTextField!
    @IBOutlet weak var signButton: DizneyButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let mobileNumber = txtMobileNumber.text else {return}
        guard let password = txtPassword.text else {return}
        if mobileNumber.count < 10 {
            pop.configCancelable(messgae: "phone_number_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        } else if password.count < 8 {
            pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        signButton.showActivityIndicator()
        let body = LoginRequestData(phone_number: mobileNumber, password: password)
        viewModel.login(body: body) { (res)  in
            self.signButton.hideActivityIndicator()
            if let res = res {
                if res.is_verified {
                    Navigator.toTabs().changeRoot()
                } else {
                    self.performSegue(withIdentifier: toOTP, sender: mobileNumber)
                }
            }
        }
    }
    
}
