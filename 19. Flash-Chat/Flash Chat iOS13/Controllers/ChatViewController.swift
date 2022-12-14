//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Mutlu Çalkan on 24.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages : [Messages] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        // Tableview
        tableView.dataSource = self
        tableView.register(UINib(nibName: Core.cellNibName, bundle: nil), forCellReuseIdentifier: Core.cellIdentifier)
    
        // Fetch data from Firestore and display them on the chat screen.
        loadMessages()
    }
    
    
    //MARK: - Load Messages
    func loadMessages(){
        db.collection(FStore.collectionName).order(by: FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let error {
                self.alertMessage(alertTitle: "Error!", alertMesssage: error.localizedDescription)
            }else{
                if let documents = querySnapshot?.documents{
                    for doc in documents{
                        let data = doc.data()
                        if let sender = data[FStore.senderField] as? String, let message = data[FStore.bodyField] as? String{
                            let newMessage = Messages(sender: sender, body: message)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Send Button
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBox = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(FStore.collectionName).addDocument(data: [
                FStore.senderField: messageSender,
                FStore.bodyField: messageBox,
                FStore.dateField: FieldValue.serverTimestamp()
            ]){ error in
                if let error {
                    self.alertMessage(alertTitle: "Error!", alertMesssage: error.localizedDescription)
                }else{
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    //MARK: - Log Out Button
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Core.cellIdentifier, for: indexPath) as? MessageCell else { return UITableViewCell() }
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youAvatarImageView.isHidden = true
            cell.avatarImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: BrandColors.purple)
        }else{
            cell.youAvatarImageView.isHidden = false
            cell.avatarImageView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: BrandColors.purple)
            cell.label.textColor = UIColor(named: BrandColors.lightPurple)
        }
        
        return cell
    }
    
}
