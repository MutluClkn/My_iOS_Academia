//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 9.11.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import Kingfisher

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let popUpMessage = ViewController()
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    //Firebase
    func fetchData() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                self.popUpMessage.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Veriler yüklenirken bir hata oluştu.")
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postArray.removeAll()
                    for document in snapshot!.documents{
                        if let imageURL = document.get("gorselURL") as? String{
                            if let email = document.get("email") as? String{
                                if let description = document.get("yorum") as? String {
                                    self.postArray.append(Post(email: email, imageURL: imageURL, description: description))
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - TableView Delegate, DataSource
extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        cell.emailLabel.text = self.postArray[indexPath.row].email
        cell.descriptionLabel.text = self.postArray[indexPath.row].description
        let kfURL = URL(string: self.postArray[indexPath.row].imageURL)
        cell.postImageView.kf.setImage(with: kfURL)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 334
    }
}

