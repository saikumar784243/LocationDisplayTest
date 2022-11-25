//
//  ViewController+Delegates.swift
//  LocationDisplayTest
//
//  Created by sai kumar on 25/11/22.
//

import Foundation
import CoreLocation
import UIKit

extension ViewController: CLLocationManagerDelegate {
    //MARK: locationManagerDidChangeAuthorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location accessed")
        case .denied, .restricted:
            let alert = UIAlertController(title: ViewCtrl.alertTitle, message: ViewCtrl.alertMsg, preferredStyle: UIAlertController.Style.alert)
            
            // Alert button to open settings
            alert.addAction(UIAlertAction(title: ViewCtrl.settingsTitle, style: UIAlertAction.Style.default, handler: { action in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }))
            alert.addAction(UIAlertAction(title: ViewCtrl.okTitle, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        default:
            print("Location default")
        }
    }
}
