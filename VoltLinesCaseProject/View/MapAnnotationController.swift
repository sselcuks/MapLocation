//
//  ViewController.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 28.12.2021.
//

import UIKit
import MapKit

class MapAnnotationController: UIViewController {
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var listTrips: UIButton!
    
    private let presenter = MapAnnotationPresenter()
    
    var location = [Location]()
    var index = 0
    var annotationList: [MKPointAnnotation] = []
    
    //Average location coordinate for show the annotations.
    var mainLoc = CLLocation(latitude: 41.11226814001678, longitude: 29.020181739732397)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.getLocations()
        mapView.delegate = self
        setupUI()
        
    }
    
    func setupUI(){
        mapView.averageCenterLocation(mainLoc)
        title = "Bus Stops"
        listTrips.isHidden = true
        listTrips.layer.cornerRadius = 22
        listTrips.clipsToBounds = true
    }
    

    // show the selected station detail.
    @IBAction func tripDetail(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tripDetail = storyboard.instantiateViewController(withIdentifier: "TripListTableViewController") as! TripListTableViewController
        tripDetail.selectedLocation = location[index]
        navigationController?.pushViewController(tripDetail, animated: true)
        
    }
}

// Mapview delegate, show the annotation images.
extension MapAnnotationController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        index = (self.annotationList as NSArray).index(of: annotation!)
        listTrips.setTitle("\(location[index].name)", for: .normal)
        view.image = UIImage(named: "selectedPoint")
        listTrips.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "point")
        listTrips.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "point")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "point")
            annotationView?.canShowCallout = true
        } else{
            annotationView?.annotation = annotation
        }
   
        annotationView?.image = UIImage(named: "point")
        return annotationView

    }
}

extension MapAnnotationController: BookingDelegate {
    func bookNotation(location: [Location]) {
        self.location = location
        for point in location {
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
}
// Zoom to the pin location for the better view.
extension MKMapView {
    func averageCenterLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 15000){
        let averageCoordinate = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        setRegion(averageCoordinate, animated: true)
    }
}
