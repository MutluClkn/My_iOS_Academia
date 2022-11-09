//
//  ListViewController.swift
//  Map App
//
//  Created by Mutlu Çalkan on 22.06.2022.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    
    var placeNameArray = [String]()
    var idArray = [UUID]()
    var chosenPlaceName = ""
    var chosenID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didAddButtonPressed))
        
        fetchReq()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchReq), name: NSNotification.Name("newLocationAdded"), object: nil)
    }
    
    // Fetch request from Core Data
    @objc func fetchReq(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                placeNameArray.removeAll(keepingCapacity: false)
                idArray.removeAll(keepingCapacity: false )
                
                for result in results as! [NSManagedObject]{
                    if let placeName = result.value(forKey: "placeName") as? String{
                        placeNameArray.append(placeName)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                    }
                }
                listTableView.reloadData()
            }
        }
        catch{
            print("Error")
        }
    }
    
    @objc func didAddButtonPressed() {
        chosenPlaceName = ""
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
    
    
    // MARK: - TableView Settings
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPlaceName = placeNameArray[indexPath.row]
        chosenID = idArray[indexPath.row]
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
    // Prepare for the segue to push VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapsVC"{
            let destinationVC = segue.destination as! MapsViewController
            destinationVC.chosenPlaceName = chosenPlaceName
            destinationVC.chosenID = chosenID
        }
    }
    
    // Removing saved data on the tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
                fetchRequest.returnsObjectsAsFaults = false
                let uuidString = idArray[indexPath.row].uuidString
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                
                do{
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let id = result.value(forKey: "id") as? UUID {
                                if id == idArray[indexPath.row] {
                                    context.delete(result)
                                    placeNameArray.remove(at: indexPath.row)
                                    idArray.remove(at: indexPath.row)
                                    
                                    listTableView.reloadData()
                                    do{
                                        try context.save()
                                    }catch{
                                        print("Error!")
                                    }
                                    break
                                }
                            }
                        }
                    }
                    
                    
                    
                }catch{
                    print("Error!")
                }
                
            }
                
        }


}
