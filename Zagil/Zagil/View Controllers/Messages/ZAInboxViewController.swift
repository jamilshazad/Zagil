//
//  ZAInboxViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import Firebase

class ZAInboxViewController: ZAViewController {

    
    // MARK: - Class Properties
    @IBOutlet private weak var tableView: UITableView!
    private var users: [User] = []
    
    private var chats: [Chat] = []

    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadInboxMessage()
    }
    

    private func getAppUsers() {
        ZARealTimeDatabaseManager.shared.getAppUsers()
            { (snapshot) in
                //if the reference have some values
                if snapshot.childrenCount > 0 {
                    
                    //clearing the list
                    self.users.removeAll()
                    
                    for users in snapshot.children.allObjects as! [DataSnapshot] {
                        //getting values
                        let userObject = users.value as? [String: AnyObject]
                        let userId = userObject?["id"]
                        let userName  = userObject?["name"]
                        let userImage = userObject?["image"]
                        let token = userObject?["token"]

                        let user = User(iD: userId as! Int,  name: userName as! String,  image: userImage as? String, fcmToken: token as? String)
                        self.users.append(user)
                    }
                  
                }
                else {
                    self.users.removeAll()
                }
                self.tableView.reloadData()
            }
        }
   
    
    func loadInboxMessage() {
        let userIsLogin = self.checkIfUserIsLogin()
        if (!userIsLogin){
            return
        }
        chats.removeAll()
        ZARealTimeDatabaseManager.shared.getInboxMessages(completionHandler: { (snapshot) in
            if snapshot.childrenCount > 0 {
               
                for messages in snapshot.children.allObjects as! [DataSnapshot] {
                    let userSnap = messages
                    let list_user_id = userSnap.key
                    
                    var lastMessage: String?
                    ZARealTimeDatabaseManager.shared.loadLastLineInboxMessages(chatUserID: list_user_id) { (snapshot) in
                        
                        for messages in snapshot.children.allObjects as! [DataSnapshot] {
                            let message = messages.value as? [String: AnyObject]
                            lastMessage = message?["message"] as! String
                        }
                    }
                    
                    var userName: String?
                    var userImage: String?
                    ZARealTimeDatabaseManager.shared.loadUsersInfo(chatUserID: list_user_id) { (snapshot) in
                        
                        //for messages in snapshot.children.allObjects as! [DataSnapshot] {
                       let userInfo = snapshot.value as? [String: AnyObject]
                        userName = userInfo?["name"] as! String
                        userImage = userInfo?["image"] as! String
                        if let name = userName, let image = userImage, let lastUserMessage = lastMessage  {
                             let chatObject = Chat(title: name, imageName: image, latestMessage: lastUserMessage, sender: list_user_id)
                             self.chats.append(chatObject)
                        }
                      self.tableView.reloadData()

                    }
                
                }
                   
               }
           })
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
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: ZAUserTableViewCell.self) else { return UITableViewCell() }
        
        guard let chat = chats[safe: indexPath.row] else { return UITableViewCell() }
        
         cell.confiureCellWithData(userChat: chat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let chat = chats[safe: indexPath.row] else { return }
        let senderData = SenderFeed(iD: 0, name: chat.title, UID: Int(chat.sender! as String)!, source: "", destination: "", weight: "", weightUnit: "", size: "", sizeUnit: "", description: "", price: "", priceUnit: "")
        self.push(viewController: ZAConverstationViewController.self, storyboard: R.storyboard.messages(), configure: { (vC) in
            vC.senderData = senderData
        })
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
