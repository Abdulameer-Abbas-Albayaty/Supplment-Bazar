//
//  BaseControllers.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit
import CoreLocation

class BaseViewModel: NSObject {

    var error: LiveData<String?> = LiveData(nil)

    required override init() {

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
            self.pop.config(messgae: error, image: #imageLiteral(resourceName: "error"), actionTitle: nil)
        }
    }

//    func startWaiting() {
//        SVProgressHUD.setDefaultMaskType(.clear)
//        SVProgressHUD.show()
//    }
//
//    func endWaiting() {
//        SVProgressHUD.dismiss()
//    }

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

class BaseCollectionViewController<T: BaseViewModel>: UICollectionViewController {

    var viewModel :T!
    let pop = Bundle.main.loadNibNamed("PopUp", owner: nil, options: nil)?.first as! PopUp

    override func viewDidLoad() {
        super.viewDidLoad()

        pop.addToView(view)
        viewModel = T()
        viewModel.error.observer { (error) in
            if let error = error {
                if error == tokenExpire {
//                    self.forceLogout()
                    return
                }
                self.pop.config(messgae: error, image: #imageLiteral(resourceName: "error"), actionTitle: nil)
            }
        }
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
        self.pop.config(messgae: error, image: #imageLiteral(resourceName: "error"), actionTitle: nil)
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
        self.pop.config(messgae: error, image: #imageLiteral(resourceName: "error"), actionTitle: nil)
    }

//    func startWaiting() {
//        SVProgressHUD.setDefaultMaskType(.clear)
//        SVProgressHUD.show()
//    }
//
//    func endWaiting() {
//        SVProgressHUD.dismiss()
//    }

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
