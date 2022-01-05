//
//  NetworkManager.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 3.01.2022.
//

import Foundation
import Alamofire

// Make Request for location data.
class MapPointLocation {
    
    static let shared = MapPointLocation()
    
    var delegate: BookingDelegate?
    
    // Fetch json from api and decode.
    public func getResponse(completion: @escaping (_ data: [Location]?,_ success: Bool ) -> Void) {
        AF.request(LOCATION.GET.baseURL(),
                   method: .get).validate().responseDecodable(of: [Location].self){
            (response) in
        switch (response.result) {
            case .success:
                completion(response.value, true)
            case .failure:
                completion(nil, false)
            }
        }
    }
    // Make post request for the selected station id and trip id.
    public func postRequest(stationId: String, tripId: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = "https://demo.voltlines.com/case-study/6/stations/\(stationId)/trips/\(tripId)"
        AF.request(url,method: .post).validate().responseJSON { response in
            switch (response.result){
            case .success:
                completion(true)
            case.failure:
                completion(false)
            }
        }
    }
}

 // API end points extension.
extension MapPointLocation {
    
    enum LOCATION: String {
        case GET = "stations"
        //case POST = "https://demo.voltlines.com/case-study/6/stations/<station_id>/trips/<trip_id>"
        func baseURL() -> String{
            return "https://demo.voltlines.com/case-study/6/\(self.rawValue)"
        }
    }
}
