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

protocol MapLocationDelegate: AnyObject{
    func presentAnnotation(location: [Location])
    func presentAlert(title: String, message:String)
}

typealias PresenterDelegate =  MapLocationDelegate & UIViewController

enum LOCATION:String{
    case GET = "stations"
    case POST = ""
    func baseURL() -> String{
        return "https://demo.voltlines.com/case-study/6/\(self.rawValue)"
        
    }
}


class MapPointLocation{
    weak var delegate: MapLocationDelegate?
    
    public func getLocation(){
        
        AF.request(LOCATION.GET.baseURL(), method: .get).validate().responseDecodable(of: [Location].self){
            (response) in

            guard let location = response.value else{
                print("error")
                return
            }
          
            self.delegate?.presentAnnotation(location: location)
        }
        
    }
    

    public func setAnnotationDelegate(delegate: MapLocationDelegate){
        self.delegate = delegate
    }
}
