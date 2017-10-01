//
//  ViewController+MapViewController.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 21/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit
import MapKit

extension ViewController: MKMapViewDelegate {    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        if let annotation = annotation as? MapPin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequedView.annotation = annotation
                view = dequedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            configureAnnotationView(annotation: annotation, view: view)
            
            return view
        }
        
        return nil
    }
    
    func zoomToFitMapAnnotations(mapView: MKMapView) {
        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
        
        for annotation in mapView.annotations {
            if annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude,
                annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude {
                continue
            }
            
            topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = max(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = max(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = min(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        let latitudeCenter = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        let longitudeCenter = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        let centerRegion = CLLocationCoordinate2D(latitude: latitudeCenter, longitude: longitudeCenter)
        let latitudeDelta = abs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.5
        let longitudeDelta = abs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.5
        let spanRegion = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        let region = MKCoordinateRegion(center: centerRegion, span: spanRegion)
        mapView.setRegion(region, animated: true)
    }
    
    func zoomToCenterInMadrid(mapView: MKMapView) {
        let latitudeCenter = 40.416775
        let longitudeCenter = -3.703790
        let centerRegion = CLLocationCoordinate2D(latitude: latitudeCenter, longitude: longitudeCenter)
        let latitudeDelta = 0.1
        let longitudeDelta = 0.1
        let spanRegion = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        let region = MKCoordinateRegion(center: centerRegion, span: spanRegion)
        mapView.setRegion(region, animated: true)
    }
    
    func addMapPins() {
        print("addingMapPins")
        var chooseEntityType: String = ""
        
        if idButton == "tenda" {
            fetchedResultsController = fetchedResultsControllerForShops
            chooseEntityType = "shop"
        } else {
            fetchedResultsController = fetchedResultsControllerForActivities
            chooseEntityType = "activity"
        }
        
        if fetchedResultsController.fetchedObjects != nil {
            for shopCD in fetchedResultsController.fetchedObjects! {
                // Only show in the map the annotations related with the button 
                if shopCD.entityType == chooseEntityType {
                    let latitude = shopCD.latitude
                    let longitude = shopCD.longitude
                    
                    let myPin = MapPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), entityType: shopCD.entityType!, entity: shopCD)
                    myPin.title = shopCD.name!
                    myPin.logoData = shopCD.logoData
                    myPin.imageData = shopCD.imageData
                    self.map.addAnnotation(myPin)
                }
                
                // break
            }
        } else {
            print("No elements in fetchedResultsController")
        }
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("mapViewWillStartRenderingMap")
        // zoomToFitMapAnnotations(mapView: self.map)
        // self.zoomToFitMapAnnotations(mapView: self.map)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("mapViewDidFinishRenderingMap")
        
        if firstTimeMapRendered {
            firstTimeMapRendered = false
            self.zoomToCenterInMadrid(mapView: self.map)
        }
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        // print("mapViewWillStartLoadingMap")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // print("mapViewDidFinishLoadingMap")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: (view.annotation as! MapPin).entity)
    }
    
    func configureAnnotationView(annotation: MapPin, view: MKPinAnnotationView) {
        switch annotation.entityType {
        case "shop":
            view.pinTintColor = MKPinAnnotationView.redPinColor()
        default:
            view.pinTintColor = MKPinAnnotationView.greenPinColor()
        }
        
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        if let data = annotation.logoData {
            if let image = UIImage(data: data, scale: 5) {
                view.leftCalloutAccessoryView = UIImageView(image: image) as UIView
            }
        }
    }
}
