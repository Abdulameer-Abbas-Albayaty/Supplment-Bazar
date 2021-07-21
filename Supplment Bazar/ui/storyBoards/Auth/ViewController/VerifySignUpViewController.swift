//
//  VerifySignUpViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 14/07/2021.
//

import UIKit

class VerifySignUpViewController: AuthBaseViewController<VerifySignUpViewModel> {

    @IBOutlet weak var txtCode: DizneyAuthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resendTapped(_ sender: Any) {
        viewModel.resend { (res) in
            if let res = res {
                self.pop.configCancelable(messgae: res, image: #imageLiteral(resourceName: "tick"))
            }
        }
    }
    
    @IBAction func verifyTapped(_ sender: Any) {
        guard let code = txtCode.text, code.count == 6 else {
            self.pop.configCancelable(messgae: "OTP count", image: #imageLiteral(resourceName: "error"))
            return
        }
        startWaiting()
        viewModel.verify(body: VerifySignUpRequest(code: code)) { (res) in
            self.endWaiting()
            if let _ = res {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
