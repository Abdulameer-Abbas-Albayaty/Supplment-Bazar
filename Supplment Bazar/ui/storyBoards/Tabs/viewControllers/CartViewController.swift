//
//  CartViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import UIKit

class CartViewController: BaseViewController<CartViewModel>, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var items = [Cart]()
    
    fileprivate var totalAmount = Double()
    
    fileprivate let footerView = Bundle.main.loadNibNamed("CartFooter", owner: nil, options: nil)?.first as! CartFooter
    
    override func viewDidLoad() {
        super.viewDidLoad()

        askLocation()
        tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        viewModel.items.observer { (items) in
            self.totalAmount = self.viewModel.totalAmount
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        let item = items[indexPath.row]
        cell.setData(data: item)
        cell.minusAction = { [self] in
            if item.quantity > 1 {
                viewModel.changeQuantity(id: item.id ?? "", quantity: Int(item.quantity) - 1)
            }
        }
        cell.plusAction = { [self] in
            viewModel.changeQuantity(id: item.id ?? "", quantity: Int(item.quantity) + 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView.totalAmount = totalAmount
        footerView.orderAction = {
            // ordder tapped
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteActionTitle = NSLocalizedString("Remove", comment: "")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [self] (action, view, completionHandler) in
            completionHandler(false)
            viewModel.deleteItem(id: items[indexPath.row].id ?? "")
        }
        if #available(iOS 13.0, *) {
            deleteAction.image = #imageLiteral(resourceName: "error")
            deleteAction.backgroundColor = UIColor.red
        } else {
            deleteAction.image = #imageLiteral(resourceName: "error")
            deleteAction.backgroundColor = UIColor.red
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
