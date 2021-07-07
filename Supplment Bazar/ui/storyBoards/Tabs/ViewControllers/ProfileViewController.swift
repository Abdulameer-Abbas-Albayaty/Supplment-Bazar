//
//  ProfileViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 07/07/2021.
//

import UIKit

class ProfileViewController: BaseTableViewController<HomeViewModel> {

    @IBOutlet weak var lblUserMobile: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var languageCell: UITableViewCell!
        
    @IBOutlet weak var lblVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            languageCell.isHidden = false
        } else {
            languageCell.isHidden = true
        }
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            lblVersion.text = "\("version".getLocalized()) \(version)"
        } else {
            lblVersion.text = nil
        }
        callAPI()
    }
    
    fileprivate func callAPI() {
//        if CustomerInfoUD.isEmpty() {
//            viewModel.getProfileInfo { (res) in
//                if let res = res?.user {
//                    self.lblUserName.text = res.name
//                    self.lblUserMobile.text = res.phone
//                    self.userImage.sd_setImage(with: URL(string: res.image))
//                }
//            }
//        } else {
//            self.lblUserName.text = CustomerInfoUD.name
//            self.lblUserMobile.text = CustomerInfoUD.mobile
//            self.userImage.sd_setImage(with: URL(string: CustomerInfoUD.pic ?? ""))
//        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                if let mobile = CustomerInfoUD.mobile {
//                    navigationController?.pushViewController(Navigator.toChangePassword(mobile: mobile, status: nil), animated: true)
                }
            case 1:
                break
//                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case 1:
                let urlString = "https://apps.apple.com/us/app/smart-tasheel/id1563482557"
                let title = "Download Tasheel app"
                guard let appUrl = URL(string: urlString) else { return }
                let actitiviyController = UIActivityViewController(activityItems: [title, appUrl], applicationActivities:nil)
                present(actitiviyController, animated: true)
            case 2:
                print("about")
            default:
                break
            }
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let alert = UIAlertController(title: "logout_question".getLocalized(), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "logout".getLocalized(), style: .destructive, handler: { (_) in
//            self.viewModel.logout { (res) in
//                if let _ = res {
//                    self.logout()
//                }
//            }
        }))
        alert.addAction(UIAlertAction(title: "cancel".getLocalized(), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
