//
//  ChangePasswordTableViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 25/07/2021.
//

import UIKit

class ChangePasswordTableViewController: BaseTableViewController<ChangePasswordViewModel> {

    @IBOutlet weak var txtNewConfirmation: DizneyAuthTextField!
    @IBOutlet weak var txtNewPassword: DizneyAuthTextField!
    @IBOutlet weak var txtOldPassword: DizneyAuthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func changeTapped(_ sender: Any) {
        guard let oldPassword = txtOldPassword.text, oldPassword.count >= 8 else {
            self.pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        guard let newPassword = txtNewPassword.text, newPassword.count >= 8 else {
            self.pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        guard let newConfirmation = txtNewConfirmation.text, newConfirmation.count >= 8 else {
            self.pop.configCancelable(messgae: "password_count".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        if newPassword != newConfirmation {
            self.pop.configCancelable(messgae: "New password must be equal to its confirmation".getLocalized(), image: #imageLiteral(resourceName: "error"))
            return
        }
        let body = ChangePasswordRequest(current_password: oldPassword, password: newPassword, password_confirmation: newConfirmation)
        viewModel.change(body: body) { (res) in
            if let res = res {
                self.pop.configActionOnly(messgae: res, image: #imageLiteral(resourceName: "tick"), actionTitle: "ok".getLocalized()) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
