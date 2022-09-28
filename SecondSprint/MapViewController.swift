//
//  MapViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import MapKit
import CoreLocation

//Class MapViewController starts
class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    //Map view outlet
    @IBOutlet weak var currentLocationMapView: MKMapView!
    @IBOutlet weak var orderNowButton: UIButton!
    
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Testing part
    static func getVC() -> MapViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        return vc
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Necessary conditions
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    // updating location function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //called when we start mamger  loc update
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    //Function to zoom in and add pin
    func render(_ location: CLLocation){
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        currentLocationMapView.setRegion(region, animated: true)
        
        //Pin part
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        currentLocationMapView.addAnnotation(pin)
        pin.title = "Current Location"
        
    }
    
}//End of MapViewController class

    
