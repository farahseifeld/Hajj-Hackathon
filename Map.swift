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
    var ID:Int = 0
    let defaultLocation = CLLocationCoordinate2D(latitude: 21.61718286110076, longitude:39.15622320958255)
    
    // Location Variables
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0

    var tents = Tents()
    var pilgrims = Pilgrims()
    
    var tentspic: [GMSMarker] = []
    
    var makkah: CLLocationCoordinate2D?
    var madinah: CLLocationCoordinate2D?
    var mina: Int?
    
    var chose:String?
    
    
    func drawtentspic()
    {
        var ind = 0
        tents.getlocations()
        for i in tents.locations
        {
            tentspic.insert(GMSMarker(position: CLLocationCoordinate2D(latitude: i.latitude,longitude: i.longitude)), at: ind)
            tentspic[ind].icon = #imageLiteral(resourceName: "tent-2")
            tentspic[ind].map = self.mapView
            
            ind = ind + 1
            
        }
        
        let camera = GMSCameraPosition.camera(withTarget: tents.locations[0], zoom: 18)
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        mapView.animate(to: camera)
        mapView.animate(toViewingAngle: 50)
        CATransaction.commit()
        
        
    }
    
    func draw(src: CLLocationCoordinate2D, dst: CLLocationCoordinate2D, color : UIColor)
    {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=driving&key=AIzaSyAvtSN3jDbBKZVVkY4wt-PrXDXYSCC_TcU")!
        
        let task = session.dataTask(with: url, completionHandler:
        {
            (data, response, error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        
                        let preRoutes = json["routes"] as! NSArray
                        let routes = preRoutes[0] as! NSDictionary
                        let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
                        let polyString = routeOverviewPolyline.object(forKey: "points") as! String
                        
                        DispatchQueue.main.async(execute: {
                            let path = GMSPath(fromEncodedPath: polyString)
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5.0
                            polyline.strokeColor = color
                            polyline.map = self.mapView
                        })
                    }
                    
                } catch
                {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    
     //Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")

            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:

            print("Location status is OK.")
        }
    }
    
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
        

        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        
        //
        let marker=GMSMarker()
        //marker.position=CLLocationCoordinate2D(latitude: 30.01993969705579,longitude: 31.50071656349587)
        marker.position = defaultLocation
        marker.title="HolidayInn"
        marker.snippet="Jeddah, Saudi"
        marker.map=mapView
        drawtentspic()
        
        //draw(src: (self.currentLocation?.coordinate)!, dst: tents.locations[0], color: .green)
        print("Cuurent location: ",mapView.myLocation?.coordinate)
        
        
        var locs:CLLocationCoordinate2D?
        if(chose=="mak")
        {
            locs = makkah
        }
        else if(chose=="mad")
        {
            locs = madinah
        }
        else if(chose == "mina")
        {
            locs = tents.locations[mina!]
        }
        
        draw(src: defaultLocation, dst: locs!, color: .blue)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
extension Map: GMSAutocompleteViewControllerDelegate
{
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        let position = place.coordinate
        
        
        mapView.camera = GMSCameraPosition.camera(withTarget: position, zoom: 15)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
