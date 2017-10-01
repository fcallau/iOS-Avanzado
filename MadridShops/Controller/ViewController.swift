//
//  ViewController.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 7/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var idButton: String = ""
    var firstTimeMapRendered: Bool = false
    
    var context: NSManagedObjectContext!
    var fetchedResultsControllerForShops: NSFetchedResultsController<ShopCD>!
    var fetchedResultsControllerForActivities: NSFetchedResultsController<ShopCD>!
    var fetchedResultsController: NSFetchedResultsController<ShopCD>!
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    @IBAction func zoomButton(_ sender: UIBarButtonItem) {
        // self.zoomToFitMapAnnotations(mapView: self.map)
        self.zoomToCenterInMadrid(mapView: self.map)
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if idButton == "tenda" {
            self.title = String.obtainLiteral(es: "Tiendas", en: "Shops")
        } else {
            self.title = String.obtainLiteral(es: "Actividades", en: "Activities")
        }
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        self.map.delegate = self
        self.addMapPins()
        
        
        let madridLocation = CLLocation(latitude: 40.41, longitude: -3.6)
        self.map.setCenter(madridLocation.coordinate, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop: ShopCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController
            
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
        }
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let location = locations[0]
    //
    //        self.map.setCenter(location.coordinate, animated: true)
    //    }
}

