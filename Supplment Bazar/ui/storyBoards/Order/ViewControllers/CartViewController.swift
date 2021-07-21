//
//  CartViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import UIKit

private let toConfirm = "toConfirm"

class CartViewController: BaseViewController<CartViewModel>, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    fileprivate var items = [CartData]()
    fileprivate var totalAmount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        askLocation()
        tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        viewModel.items.observe { (res) in
            if let res = res {
                self.totalAmount = res.total_cart_price
                self.lblTotalAmount.text = "\(res.total_cart_price) IQD"
                self.items = res.items
                self.tableView.reloadData()
            }
        }
        viewModel.getCart()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        let item = items[indexPath.row]
        cell.setData(data: item)
        cell.minusAction = { [self] in
            if item.quantity > 1 {
                viewModel.edit(id: item.id, body: ChangeQuantityBody(quantity: item.quantity - 1))
            }
        }
        cell.plusAction = { [self] in
            viewModel.edit(id: item.id, body: ChangeQuantityBody(quantity: item.quantity + 1))
        }
        cell.deleteAction = { [self] in
            handleDelete(id: item.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderTapped(_ sender: Any) {
        if items.count > 0 {
            self.performSegue(withIdentifier: toConfirm, sender: totalAmount)
        } else {
            self.pop.configCancelable(messgae: "Please add items to the cart to continue", image: #imageLiteral(resourceName: "remove"))
        }
    }
    
    fileprivate func handleDelete(id: String) {
        let alert = UIAlertController(title: "Do you want to delete this item?", message: "Item deletion", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "delete".getLocalized(), style: .destructive) { (_) in
            self.viewModel.delete(id: id)
        }
        let cancel = UIAlertAction(title: "cancel".getLocalized(), style: .cancel)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toConfirm {
            if let dest = segue.destination as? ConfirmOrderViewController {
                dest.totalAmount = sender as? String
            }
        }
    }
    
}
