//
//  ConfirmOrderViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 16/07/2021.
//

import UIKit

class ConfirmOrderViewController: BaseViewController<CheckoutViewModel>, UIPickerViewDelegate, UIPickerViewDataSource {

    var totalAmount: String?
    
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblShippingAmount: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    let toolBar = UIToolbar()
    let codePicker  = UIPickerView()
    var codeDataList = Provinces.provinces
    
    struct CountryCode: Codable {
        let value: String
        let name: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Confirm".getLocalized()
        
        lblSubtotal.text = totalAmount
        lblShippingAmount.text = "5000 IQD"
        lblTotalAmount.text = "20000 IQD"
        
        txtProvince.inputView = codePicker
        txtProvince.inputAccessoryView = PickerKeyboardToolBar(#selector(doneTapped))
        
        codePicker.delegate = self
        codePicker.dataSource = self
    }
    
    @objc fileprivate func doneTapped() {
        view.endEditing(true)
        txtProvince.text = codeDataList[codePicker.selectedRow(inComponent: 0)].value
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return codeDataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codeDataList[row].value
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        guard let name = txtName.text, name.count > 3 else {
            self.pop.configCancelable(messgae: "Name field must be filled", image: #imageLiteral(resourceName: "remove"))
            return
        }
        guard let province = txtProvince.text else {
            self.pop.configCancelable(messgae: "You must select a province", image: #imageLiteral(resourceName: "remove"))
            return
        }
        guard let address = txtAddress.text, address.count > 3 else {
            self.pop.configCancelable(messgae: "Address field must be filled", image: #imageLiteral(resourceName: "remove"))
            return
        }
        guard let mobile = txtMobileNumber.text, mobile.count >= 10 else {
            self.pop.configCancelable(messgae: "Mobile number field must be filled", image: #imageLiteral(resourceName: "remove"))
            return
        }
        let body = CheckoutBody(first_name: name, last_name: "A", province: province, address1: address, address2: nil, phone_number: mobile, phone_number2: nil)
        viewModel.checkout(body: body) { (res) in
            if let res = res {
                self.pop.configActionOnly(messgae: res, image: #imageLiteral(resourceName: "tick"), actionTitle: "ok".getLocalized()) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}

enum Provinces: Int {
    case All_PROVINCE = 0
    case BAGHDAD = 1
    case ERBIL = 2
    case ANBAR = 3
    case BABIL = 4
    case NAJAF = 5
    case BASRA = 6
    case HALABJA = 7
    case DOHUK = 8
    case QADISIYAH = 9
    case DIYALA = 10
    case DHIQAR = 11
    case SULAYMANIYAH = 12
    case SALADIN = 13
    case KIRKUK = 14
    case KARBALA = 15
    case MUTHANNA = 16
    case MAYSAN = 17
    case NINEVEH = 18
    case WASIT = 19
    case OTHER = 20
    
    static let provinces = [BAGHDAD, ERBIL, ANBAR, BABIL, NAJAF, BASRA, HALABJA, DOHUK, QADISIYAH, DIYALA, DHIQAR, SULAYMANIYAH, SALADIN, KIRKUK, KARBALA, MUTHANNA, MAYSAN, NINEVEH, WASIT]
    
    var value: String {
        switch self {
        case .All_PROVINCE:
            return "All".getLocalized()
        case .BAGHDAD:
            return "BAGHDAD".getLocalized()
        case .ERBIL:
            return "ERBIL".getLocalized()
        case .ANBAR:
            return "ANBAR".getLocalized()
        case .BABIL:
            return "BABIL".getLocalized()
        case .NAJAF:
            return "NAJAF".getLocalized()
        case .BASRA:
            return "BASRA".getLocalized()
        case .HALABJA:
            return "HALABJA".getLocalized()
        case .DOHUK:
            return "DOHUK".getLocalized()
        case .QADISIYAH:
            return "QADISIYAH".getLocalized()
        case .DIYALA:
            return "DIYALA".getLocalized()
        case .DHIQAR:
            return "DHIQAR".getLocalized()
        case .SULAYMANIYAH:
            return "SULAYMANIYAH".getLocalized()
        case .SALADIN:
            return "SALADIN".getLocalized()
        case .KIRKUK:
            return "KIRKUK".getLocalized()
        case .KARBALA:
            return "KARBALA".getLocalized()
        case .MUTHANNA:
            return "MUTHANNA".getLocalized()
        case .MAYSAN:
            return "MAYSAN".getLocalized()
        case .NINEVEH:
            return "NINEVEH".getLocalized()
        case .WASIT:
            return "WASIT".getLocalized()
        case .OTHER :
            return "OTHER".getLocalized()
        }
    }
    
}
