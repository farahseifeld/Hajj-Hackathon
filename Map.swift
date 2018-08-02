//
//  Map.swift
//  TentsMap
//
//  Created by Noura El-Ghamry on 8/2/18.
//  Copyright © 2018 Mayada El-Ghamry. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class Map: UIViewController , GMSMapViewDelegate ,  CLLocationManagerDelegate
{

    var mapnumber: String = ""
    let defaultLocation = CLLocationCoordinate2D(latitude: 21.484020900094272, longitude:39.2084990302933)
    
    // Location Variables
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0

    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(mapnumber)
        GMSServices.provideAPIKey("AIzaSyAvtSN3jDbBKZVVkY4wt-PrXDXYSCC_TcU")
        GMSPlacesClient.provideAPIKey("AIzaSyAvtSN3jDbBKZVVkY4wt-PrXDXYSCC_TcU")
        //var camera=GMSCameraPosition.camera(withLatitude: 21.484020900094272, longitude: 39.2084990302933, zoom: 18)
        var camera = GMSCameraPosition.camera(withTarget: defaultLocation, zoom: 18)
        mapView=GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view=mapView
        
        //my location
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
       
        //
        let marker=GMSMarker()
        //marker.position=CLLocationCoordinate2D(latitude: 30.01993969705579,longitude: 31.50071656349587)
        marker.position = defaultLocation
        marker.title="HolidayInn"
        marker.snippet="Jeddah, Saudi"
        marker.map=mapView
     
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
