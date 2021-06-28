//
//  ProductDetailViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit
import GoogleMaps

private let flavorCell = "flavorCell"
private let sizeCell = "sizeCell"

enum ProductOption {
    case flavor
    case size
}

class ProductDetailsViewController: BaseTableViewController<ProductDetailsViewModel> {

    @IBOutlet weak var txtNotes: DizneyTextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDetails: UILabel!

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblCount: UILabel!

    @IBOutlet weak var shopCenterView: UIView!
    @IBOutlet weak var lblMerchantTitle: UILabel!
    @IBOutlet weak var lblMerchantAddress: UILabel!
    @IBOutlet weak var imgMerchantLogo: CircularImageView!

    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerCell: UITableViewCell!
    
    // falvors
    @IBOutlet weak var flavorsSection: UITableViewCell!
    
    // nutrition
    @IBOutlet weak var nutritionSection: UITableViewCell!
    @IBOutlet weak var nutritionImage: UIImageView!
    
    // sizes
    @IBOutlet weak var sizesSection: UITableViewCell!
    
    @IBOutlet weak var storeSection: UITableViewCell!
    
    var productId: String?
    fileprivate var price: Double = Double()
    
    fileprivate var selectedFlavor: Int = 0
    fileprivate var selectedSize: Int = 0
    
    fileprivate var productStrImage: String = ""
    fileprivate var nutritionFacts: String = ""
    
    fileprivate var option: ProductOption = .flavor
    
    fileprivate let optionAlert = UIAlertController()

    fileprivate var details: ProductDetailsResponse? {
        didSet {
            if let details = details {
                updateData(details)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        shopCenterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShopCenterTapped)))
        
        nutritionImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNutriationTapped)))
        callAPI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showPickerInActionSheet(option: .flavor)
        }
    }
    
    @objc fileprivate func handleNutriationTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = (navigationController?.view.bounds)!
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.navigationController?.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }

    fileprivate func hideCells() {
        footerView.isHidden = true
        headerView.isHidden = true
        containerCell.isHidden = true
        flavorsSection.isHidden = true
        nutritionSection.isHidden = true
    }

    fileprivate func setupPickerAlert() {
        optionAlert.title = ""
        optionAlert.message = "\n\n\n\n\n\n\n\n\n\n";
        optionAlert.isModalInPopover = true
        let picker: UIPickerView = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        optionAlert.view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: optionAlert.view.leadingAnchor, constant: 16),
            picker.trailingAnchor.constraint(equalTo: optionAlert.view.trailingAnchor, constant: -16),
            picker.topAnchor.constraint(equalTo: optionAlert.view.topAnchor, constant: 16),
            picker.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        let toolView = UIStackView()
        toolView.translatesAutoresizingMaskIntoConstraints = false
        toolView.spacing = 16
        toolView.alignment = .fill
        toolView.axis = .horizontal
        toolView.distribution = .fillEqually
        
        let buttonCancel: UIButton = UIButton()
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.setTitleColor(UIColor.red, for: .normal)
        toolView.addArrangedSubview(buttonCancel)
        buttonCancel.addTarget(self, action: #selector(cancelSelection), for: .touchDown)
        
        let buttonOk: UIButton = UIButton()
        buttonOk.setTitle("Select", for: .normal)
        buttonOk.setTitleColor(UIColor.primary, for: .normal)
        toolView.addArrangedSubview(buttonOk)
        buttonOk.addTarget(self, action: #selector(handleOk), for: .touchDown)
        optionAlert.view.addSubview(toolView)
        
        NSLayoutConstraint.activate([
            toolView.bottomAnchor.constraint(equalTo: optionAlert.view.bottomAnchor, constant: -16),
            toolView.leadingAnchor.constraint(equalTo: optionAlert.view.leadingAnchor, constant: 16),
            toolView.trailingAnchor.constraint(equalTo: optionAlert.view.trailingAnchor, constant: -16),
            toolView.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 16),
            toolView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    fileprivate func showCells() {
        footerView.isHidden = false
        headerView.isHidden = false
        containerCell.isHidden = false
        flavorsSection.isHidden = false
        nutritionSection.isHidden = false

        footerView.alpha = 0
        headerView.alpha = 0
        containerCell.alpha = 0

        let scale: CGFloat = 0.7
        footerView.transform = CGAffineTransform(scaleX: scale, y: scale)
        headerView.transform = CGAffineTransform(scaleX: scale, y: scale)
        containerCell.transform = CGAffineTransform(scaleX: scale, y: scale)

        UIView.animate(withDuration: 0.5) {
            self.footerView.alpha = 1
            self.headerView.alpha = 1
            self.containerCell.alpha = 1

            self.footerView.transform = .identity
            self.headerView.transform = .identity
            self.containerCell.transform = .identity
        }
        
        setupPickerAlert()
    }
    
    func showPickerInActionSheet(option: ProductOption) {
        self.option = option
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    @objc fileprivate func cancelSelection() {
        optionAlert.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleOk() {
        
    }

    fileprivate func callAPI() {
        if let slug = productId {
            hideCells()
            viewModel.get(slug: slug) { (res) in
                if let res = res {
                    self.showCells()
                    self.details = res
                }
            }
        }
    }

    fileprivate func updateData(_ data: ProductDetailsResponse) {
        self.price = data.price ?? 0
        lblTitle.text = data.name
        lblPrice.text = "\(data.price ?? 0)"
        lblDetails.text = data.description
        
        if let store = data.store {
            lblMerchantTitle.text = store.name
            if let storeLogo = store.logo {
                imgMerchantLogo.load(image: storeLogo)
            }
        } else {
            // hide store section
        }
        
        if let flavors = data.options?.flavors, flavors.count > 0 {
            selectedFlavor = 0
            flavorsSection.isHidden = false
            
        } else {
            flavorsSection.isHidden = true
        }
        
        if let sizes = data.options?.sizes, sizes.count > 0 {
            selectedSize = 0
            sizesSection.isHidden = false
            
        } else {
            sizesSection.isHidden = true
        }
//        if let img = data.image {
//            productImage.load(image: img)
//        }
//        if let nut = data.supplement_facts {
//            nutritionImage.load(image: nut)
//        }
        newFalvorSize()
        tableView.reloadData()
    }

    @objc fileprivate func handleShopCenterTapped() {
        #warning("change shop id")
        if let res = details {
//            self.navigationController?.pushViewController(Navigator.toShopDetails(shopId: res.product.merchant.id), animated: true)
        }
    }

    @IBAction func mapTapped(_ sender: Any) {
        let vc = MapViewController()
        vc.location = CLLocationCoordinate2D(latitude: 33.323, longitude: 44.5345)
        present(vc, animated: true, completion: nil)
    }

    @IBAction func addToCard(_ sender: Any) {
        view.endEditing(true)
        guard let details = details else {return}
        guard let notes = txtNotes.text else {return}
        guard let img = productImage.image?.jpegData(compressionQuality: 0.9) else {return}
        guard let count = (lblCount.text as? NSString)?.integerValue else {return}
//        viewModel.insertToCart(data: details, image: img, quantity: count) { (mess) in
//            if let mess = mess {
//                self.showCanclableAlert(mess, nil, nil)
//            }
//        }
    }
    
    fileprivate func updateOptions() {
        productImage.load(image: productStrImage)
        nutritionImage.load(image: nutritionFacts)
        
        productImage.alpha = 0.5
        nutritionImage.alpha = 0.5
        
        UIView.animate(withDuration: 0.5) {
            self.productImage.alpha = 1
            self.nutritionImage.alpha = 1
        }
    }
    
    func newFalvorSize() {
        let selectedFlavorStr = details?.options?.flavors[selectedFlavor]
        let selectedSizeStr = details?.options?.sizes[selectedSize]
        if let varients = details?.variants {
            for i in 0...varients.count - 1 {
                if varients[i].flavor == selectedFlavorStr && varients[i].size == selectedSizeStr {
                    let obj = varients[i]
                    self.productStrImage = obj.image
                    self.nutritionFacts = obj.supplement_facts
                    self.updateOptions()
                    break
                }
            }
        }
    }

    @IBAction func minusTapped(_ sender: Any) {
        guard let count = (lblCount.text as NSString?)?.intValue else {
            return
        }
        if count > 1 {
            let newCount = count - 1
            lblCount.text = "\(newCount)"
            lblPrice.text = "\(price * Double(newCount)) IQD"
        }
    }

    @IBAction func plusTapped(_ sender: Any) {
        guard let count = (lblCount.text as NSString?)?.intValue else {
            return
        }
        if count < 10 {
            let newCount = count + 1
            lblCount.text = "\(newCount)"
            lblPrice.text = "\(price * Double(newCount)) IQD"
        }
    }

}

extension ProductDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch option {
        case .flavor:
            return details?.options?.flavors.count ?? 0
        case .size:
            return details?.options?.sizes.count ?? 0
        }
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch option {
        case .flavor:
            return details?.options?.flavors[pickerView.selectedRow(inComponent: 0)]
        case .size:
            return details?.options?.sizes[pickerView.selectedRow(inComponent: 0)]
        }
        return nil
    }
    
}
