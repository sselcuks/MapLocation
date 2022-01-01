//
//  MapAnnotationPresenter.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 2.01.2022.
//

import Foundation
import UIKit
import MapKit
import Alamofire
protocol MapAnnotationDelegate: AnyObject{
    func presentAnnotation(location: [Location])
    func presentAlert(title: String, message:String)
}


enum LOCATION:String{
    case GET = "stations"
    case POST = ""
    func baseURL() -> String{
        return "https://demo.voltlines.com/case-study/6/\(self.rawValue)"
        
    }
}


class MapAnnotation{
    weak var delegate: MapAnnotationDelegate?
    
    public func getLocation(onSuccess: @escaping ([Location]) -> Void, onError: @escaping (String?) -> Void){
        
        AF.request(LOCATION.GET.baseURL(), method: .get).validate().responseDecodable(of: [Location].self){
            (response) in

            guard let result = response.value else{
                onError(response.debugDescription)
                return
            }
            onSuccess(result)
        }
        
    }
    
    
    public func setAnnotationDelegate(delegate: MapAnnotationDelegate){
        self.delegate = delegate
    }
}
