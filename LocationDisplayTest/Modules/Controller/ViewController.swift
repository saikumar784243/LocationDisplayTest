//
//  ViewController.swift
//  LocationDisplayTest
//
//  Created by sai kumar on 24/11/22.
//

import UIKit
import RxCoreLocation
import CoreLocation
import PermissionKit
import RxSwift
import RxCocoa
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    //MARK: Variables
    let bag = DisposeBag()
    let manager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: Function to SetupUI
    func setupUI() {
        //Declaring mapview delegate
        mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        
        //Declaring start point annotation
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = CLLocationCoordinate2DMake(12.953013054035946, 77.5417514266668)
        
        //Declaring end point annotation
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = CLLocationCoordinate2D(latitude: 12.963481664580394, longitude: 77.58189527185303)
        mapView.addAnnotations([startAnnotation, endAnnotation])
        
        //Setup location manager
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //Location manager:- Subscribe to didUpdateLocations
        manager.rx
            .didUpdateLocations
            .debug(ViewCtrl.didUpdateLocations)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to didChangeAuthorization
        manager.rx
            .didChangeAuthorization
            .debug(ViewCtrl.didChangeAuthorization)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to placemark
        manager.rx
            .placemark
            .debug(ViewCtrl.placemark)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .placemark
            .subscribe(onNext: { placemark in
                guard let name = placemark.name,
                    let isoCountryCode = placemark.isoCountryCode,
                    let country = placemark.country,
                    let postalCode = placemark.postalCode,
                    let locality = placemark.locality,
                    let subLocality = placemark.subLocality else {
                    return print(ViewCtrl.placeMarkError)
                }
                print("name: \(name)")
                print("isoCountryCode hello: \(isoCountryCode)")
                print("country: \(country)")
                print("postalCode: \(postalCode)")
                print("locality: \(locality)")
                print("subLocality: \(subLocality)")
            })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to location
        manager.rx
            .location
            .debug(ViewCtrl.location)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to activityType
        manager.rx
            .activityType
            .debug(ViewCtrl.activityType)
            .subscribe(onNext: {_ in})
            .disposed(by: bag)
        
        //Location manager:- Subscribe to isEnabled
        DispatchQueue.main.async {
            self.manager.rx
                .isEnabled
                .debug(ViewCtrl.isEnabled)
                .subscribe(onNext: { _ in })
                .disposed(by: self.bag)
        }
        
        //Location manager:- Subscribe to didError
        manager.rx
            .didError
            .debug(ViewCtrl.didError)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
                
        //Location manager:- Subscribe to didDetermineState
        manager.rx
            .didDetermineState
            .debug(ViewCtrl.didDetermineState)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to didReceiveRegion
        manager.rx
            .didReceiveRegion
            .debug(ViewCtrl.didReceiveRegion)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        //Location manager:- Subscribe to didResume
        manager.rx
            .didResume
            .debug(ViewCtrl.didResume)
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
    }

}

