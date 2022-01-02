//
//  ViewController.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 28.12.2021.
//

import UIKit
import MapKit
class MapAnnotationController: UIViewController {
    private var location = [Location]()
    var index = 0
    var annotationList: [MKPointAnnotation] = []
    @IBOutlet weak var mapView: MKMapView!
    
    private let presenter = MapPointLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Bus Stops"
        presenter.setAnnotationDelegate(delegate: self)
        presenter.getLocation()
        mapView.delegate = self
       
    }
    
}
extension MapAnnotationController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        index = (self.annotationList as NSArray).index(of: annotation!)
        view.image = UIImage(named: "selectedPoint")
    
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "point")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "point")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "selectedPoint")
       
        return annotationView
        
        
        
//        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//        pin.canShowCallout = true
//        pin.image = UIImage(named: "point")
//
//        return pin
        
    }
  
    
}
extension MapAnnotationController:MapLocationDelegate{
    func presentAnnotation(location: [Location]) {
        
        //Set the coordinates on the map.
        
        for point in location{
            
            let location = point.centerCoordinates.components(separatedBy: ",")
            let lat = Double(location[0])
            let long = Double(location[1])
            let annotation = MKPointAnnotation()
            let loc = CLLocationCoordinate2D(latitude: lat ?? 0  , longitude: long ?? 0 )
          
            annotation.coordinate = loc
            annotation.title = point.name
            annotation.subtitle = "Trips Count: \(point.trips.count)"
            
            mapView.addAnnotation(annotation)
            annotationList.append(annotation)
        }
    }
    
    // show alert when selected bus is full.
    func presentAlert(title: String, message: String) {
        
    }
    
    
}

