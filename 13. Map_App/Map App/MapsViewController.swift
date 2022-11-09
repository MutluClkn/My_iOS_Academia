//
//  MapsViewController.swift
//  Map App
//
//  Created by Mutlu Çalkan on 20.06.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var longitude = Double()
    var latitude = Double()
    
    var chosenPlaceName = ""
    var chosenID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLongitude = Double()
    var annotationLatitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(locationPicker(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.minimumPressDuration = 1.3

        fetchData()
        
    }
    
    @objc func locationPicker(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let chosenPoint = gestureRecognizer.location(in: mapView)
            let chosenLocation = mapView.convert(chosenPoint, toCoordinateFrom: mapView)
            
            longitude = chosenLocation.longitude
            latitude = chosenLocation.latitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = chosenLocation
            annotation.title = placeNameTF.text
            annotation.subtitle = noteTF.text
            mapView.addAnnotation(annotation)
        }
    }
    
    func fetchData(){
        if chosenPlaceName != "" {
            //Fetch data from Core Data
            if let uuidString = chosenID?.uuidString{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
                fetchRequest.returnsObjectsAsFaults = false
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                
                do{
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0{
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "placeName") as? String {
                                annotationTitle = name
                                if let note = result.value(forKey: "note") as? String {
                                    annotationSubtitle = note
                                    if let latitude = result.value(forKey: "latitude") as? Double {
                                        annotationLatitude = latitude
                                        if let longitude = result.value(forKey: "longitude") as? Double {
                                            annotationLongitude = longitude
                                            
                                            let annotation = MKPointAnnotation()
                                            annotation.title = annotationTitle
                                            annotation.subtitle = annotationSubtitle
                                            let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                            annotation.coordinate = coordinate
                                            
                                            mapView.addAnnotation(annotation)
                                            placeNameTF.text = annotationTitle
                                            noteTF.text = annotationSubtitle
                                            
                                            locationManager.stopUpdatingLocation()
                                            
                                            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                            let region = MKCoordinateRegion(center: coordinate, span: span)
                                            mapView.setRegion(region, animated: true)
                                            
                                        }
                                    }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if chosenPlaceName == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // Customize the pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let pinViewID = "annotationID"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinViewID)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: pinViewID)
            pinView?.canShowCallout = true
            pinView?.tintColor = .blue
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    // The action when pressing on callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if chosenPlaceName != "" {
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarkArray, error in
                if let placemarks = placemarkArray {
                    if placemarks.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        
                        // Set the transport option
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        // Openning apple map
                        item.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
        }
    }
    

    @IBAction func didSaveButtonPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        
        newLocation.setValue(placeNameTF.text, forKey: "placeName")
        newLocation.setValue(noteTF.text, forKey: "note")
        newLocation.setValue(longitude, forKey: "longitude")
        newLocation.setValue(latitude, forKey: "latitude")
        newLocation.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            // Alert Pop-up
            let okAction = UIAlertAction(title: "OK", style: .default)
            let alert = UIAlertController(title: "Saved", message: "Location has been succesfully saved", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            alert.addAction(okAction)
            
        }catch{
            print("Error")
            let alert = UIAlertController(title: "Something went wrong", message: "Fatal Error", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newLocationAdded"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}

