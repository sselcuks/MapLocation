
// MapAnnotationPresenter.swift
// VoltLinesCaseProject

// Created by Selcuk on 2.01.2022.

protocol BookingDelegate: AnyObject{
    func bookNotation(location: [Location])
}

class MapAnnotationPresenter {
    
    var delegate: BookingDelegate?
    
    var locationList = [Location]()
    var stationId: Int?
    
    // show the fetched location map view.
    func getLocations() {
        MapPointLocation.shared.getResponse(completion: { result, success  in
            if success {
                self.delegate?.bookNotation(location: result ?? [])
                self.locationList = result ?? []
            } else {
                print("Error Fetching Data...")
            }
        })
    }
    
    //get the station data from the tableview list and make POST request.
    func postBookingRequest(stationId: String,
                            tripId: String,
                            completion: @escaping (_ success: Bool) -> Void) {
        
        MapPointLocation.shared.postRequest(stationId: String(stationId), tripId: String(tripId)) { success in
            if success {
                print("Successfully Booked...")
                completion(true)
             
                //check mark for booked location..
                do {
                    self.delegate?.bookNotation(location: self.locationList)
                }
                
            } else {
                completion(false)
                print("wrong")
            }
        }
    }
}
