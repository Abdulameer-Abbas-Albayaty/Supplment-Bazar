//
//  BaseControllers.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit
import CoreLocation
import SVProgressHUD

class BaseCartViewController<T: BaseViewModel>: BaseViewController<T> {
    
    fileprivate let cartButtonHeight: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primary
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: cartButtonHeight),
            button.widthAnchor.constraint(equalToConstant: cartButtonHeight)
        ])
        button.bringSubviewToFront(view)
        button.layer.cornerRadius = cartButtonHeight / 2
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        button.addTarget(self, action: #selector(handleCartTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func handleCartTapped() {
        present(Navigator.toCart(), animated: true, completion: nil)
    }
    
}

class BaseViewController<T: BaseViewModel>: UIViewController, LocationSVD {

    var currentLocation: CLLocationCoordinate2D?
    var viewModel :T!
    let pop = Bundle.main.loadNibNamed("PopUp", owner: nil, options: nil)?.first as! PopUp
    fileprivate let waitingIndicator = UIActivityIndicatorView()
    lazy var emptyView = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! NoDataView

    let locationServices = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()

        waitingIndicator.style = .gray
        waitingIndicator.color = UIColor.textPrimary

        pop.addToView(view)
        emptyView.setupNoDataView(mainView: view)

        viewModel = T()
        viewModel.error.observer { (error) in
            if let error = error {
                self.showError(error: error)
            }
        }
    }

    func askLocation() {
        locationServices.delegate = self
        locationServices.startUpdatingLocation()
    }

    func showError(error: String?) {
        if let error = error {
            if error == tokenExpire {
                if error == tokenExpire {
//                    self.forceLogout()
                    return
                }
                return
            }
            self.pop.configCancelable(messgae: error, image: #imageLiteral(resourceName: "error"))
        }
    }

    func startWaiting() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(.primary)
        SVProgressHUD.setBackgroundColor(UIColor.primary.withAlphaComponent(0.5))
        SVProgressHUD.setRingThickness(3)
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                SVProgressHUD.setDefaultStyle(.dark)
            } else {
                SVProgressHUD.setDefaultStyle(.light)
            }
        }
        SVProgressHUD.setFont(AppFont.title)
        SVProgressHUD.show(withStatus: "waiting".getLocalized())
    }
    
    func endWaiting() {
        SVProgressHUD.dismiss()
    }
    
    func addBarWaitingIndicator() {
        waitingIndicator.startAnimating()
        navigationItem.setRightBarButton(UIBarButtonItem(customView: waitingIndicator), animated: true)
    }

    func removeBarWaitingIndicator() {
        waitingIndicator.stopAnimating()
        navigationItem.setRightBarButton(nil, animated: true)
    }

    @objc
    func handleOpenSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }

    func locationFetchedSuccessfully(location: CLLocationCoordinate2D) {
        self.currentLocation = location
    }

    func unauthorizedLocationAccess() {
        self.pop.configWithAction(messgae: "Turn on the location in order to continue", image: #imageLiteral(resourceName: "error"), actionTitle: "open_settings", action: {
            self.handleOpenSettings()
        })
    }

    func failedFetchingLocation() {
        self.pop.configWithAction(messgae: "Turn on the location in order to continue", image: #imageLiteral(resourceName: "error"), actionTitle: "open_settings", action: {
            self.handleOpenSettings()
        })
    }

}

class AuthBaseViewController<T: BaseViewModel>: UITableViewController {

    var viewModel :T!
    let pop = Bundle.main.loadNibNamed("PopUp", owner: nil, options: nil)?.first as! PopUp

    override func viewDidLoad() {
        super.viewDidLoad()

        if let v = navigationController?.view {
            pop.addToView(v)
        } else {
            pop.addToView(view)
        }

        viewModel = T()
        viewModel.error.observer { (error) in
            if let error = error {
                if error == tokenExpire {
//                    self.forceLogout()
                    return
                }
                self.showError(error: error)
            }
        }
    }

    func showError(error: String) {
        if error == tokenExpire {
//            self.forceLogout()
            return
        }
        self.pop.configCancelable(messgae: error, image: #imageLiteral(resourceName: "error"))
    }

}

class BaseTableViewController<T: BaseViewModel>: UITableViewController, LocationSVD {

    var viewModel :T!
    let pop = Bundle.main.loadNibNamed("PopUp", owner: nil, options: nil)?.first as! PopUp
    fileprivate let waitingIndicator = UIActivityIndicatorView()
    lazy var emptyView = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! NoDataView
    let locationServices = LocationService()

    var currentLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        waitingIndicator.style = .gray
        waitingIndicator.color = UIColor.textPrimary

        if let v = navigationController?.view {
            pop.addToView(v)
        } else {
            pop.addToView(view)
        }

        emptyView.setupNoDataView(mainView: view)

        viewModel = T()
        viewModel.error.observer { (error) in
            if let error = error {
                self.showError(error: error)
            }
        }
    }

    func showError(error: String) {
        if error == tokenExpire {
//            self.forceLogout()
            return
        }
        self.pop.configCancelable(messgae: error, image: #imageLiteral(resourceName: "error"))
    }

    func startWaiting() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(.primary)
        SVProgressHUD.setBackgroundColor(UIColor.primary.withAlphaComponent(0.5))
        SVProgressHUD.setRingThickness(3)
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                SVProgressHUD.setDefaultStyle(.dark)
            } else {
                SVProgressHUD.setDefaultStyle(.light)
            }
        }
        SVProgressHUD.setFont(AppFont.title)
        SVProgressHUD.show(withStatus: "waiting".getLocalized())
    }
    
    func endWaiting() {
        SVProgressHUD.dismiss()
    }

    func addBarWaitingIndicator() {
        waitingIndicator.startAnimating()
        navigationItem.setRightBarButton(UIBarButtonItem(customView: waitingIndicator), animated: true)
    }

    func removeBarWaitingIndicator() {
        waitingIndicator.stopAnimating()
        navigationItem.setRightBarButton(nil, animated: true)
    }

    func askLocation() {
        locationServices.delegate = self
        locationServices.startUpdatingLocation()
    }

    @objc
    func handleOpenSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }

    func locationFetchedSuccessfully(location: CLLocationCoordinate2D) {
        self.currentLocation = location
    }
    
    func unauthorizedLocationAccess() {
        self.pop.configWithAction(messgae: "Turn on the location in order to continue", image: #imageLiteral(resourceName: "error"), actionTitle: "open_settings", action: {
            self.handleOpenSettings()
        })
    }

    func failedFetchingLocation() {
        self.pop.configWithAction(messgae: "Turn on the location in order to continue", image: #imageLiteral(resourceName: "error"), actionTitle: "open_settings", action: {
            self.handleOpenSettings()
        })
    }

}
