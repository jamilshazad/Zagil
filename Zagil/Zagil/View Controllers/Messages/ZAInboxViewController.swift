//
//  ZAInboxViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZAInboxViewController: ZAViewController {

    
    // MARK: - Class Properties
    @IBOutlet private weak var tableView: UITableView!
    private var users: [User] = []

    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Inbox"
    }
    
    private func setupViewController() {
        setupTableView()

      //  addUnderDevelopmentLabel()
    }
    
    private func setupTableView() {
           tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
           tableView.tableFooterView = UIView(frame: .zero)
           tableView.register(types: ZAUserTableViewCell.self)
       }

}

extension ZAInboxViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: ZAUserTableViewCell.self) else { return UITableViewCell() }
        
       // guard let user = users[safe: indexPath.row] else { return UITableViewCell() }
        
       // cell.configure(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        push(viewController: ZAPostedShipmentDetailViewController.self, storyboard: R.storyboard.shipments()) { [weak self] detailVC in
//            guard let self = self,
//                let shipment = self.shipments[safe: indexPath.row] else { return }
//            detailVC.shipment = shipment
//        }
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           cell.selectionStyle = .none
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
           // self.catNames.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
