//
//  TripListTableViewController.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 2.01.2022.
//

import Foundation
import UIKit


class TripListTableViewController: UIViewController {
    
    @IBOutlet weak var tripListTableView: UITableView!
    
    var selectedLocation: Location?
    var presenter = MapAnnotationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripListTableView.dataSource = self
        tripListTableView.delegate = self
        setupUI()
       
    }
    func setupUI(){
        title = "\(selectedLocation!.name)"
        tripListTableView.register(UINib.init(nibName: "TripCell", bundle: nil), forCellReuseIdentifier: "TripCell")
    }
    
}

extension TripListTableViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedLocation?.trips.count ?? 0
    }
    
    // present the selected station id trips
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripListTableView.dequeueReusableCell(withIdentifier: "TripCell",for: indexPath) as! TripCell
        cell.selectedLoc = selectedLocation?.trips[indexPath.row]
        cell.bookBtn.tag = indexPath.row
        cell.bookBtn.addTarget(self, action: #selector(bookTripBtn), for: .touchUpInside)
        
        return cell
    }
    
    // Get the selected stationID and tripID from the trip list, then make post request.
    @objc func bookTripBtn(sender: UIButton) {
        let myIndex = IndexPath(row: sender.tag, section: 0)
        let stationId = String(selectedLocation!.id)
        let tripId = String(selectedLocation!.trips[myIndex.row].id)
        
        presenter.postBookingRequest(stationId: stationId, tripId: tripId, completion: { success  in
            if success {
                //if post request is sucess, return to the main page.
                self.navigationController?.popViewController(animated: true)
            } else {
                // when the post request is fail, show the alert.
                let alert =   UIAlertController(title: "Selected trip is full", message: "Please select other one.", preferredStyle:.alert)
                let pressOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(pressOK)
                self.present(alert,animated: true)
            }
        })
        
   }
}


