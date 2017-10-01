//
//  MainViewController.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 11/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift

class MainViewController: UIViewController {
    var context: NSManagedObjectContext!
    let reachability = Reachability()!
    
    @IBOutlet weak var noConnectionView: UITextView!
    
    @IBOutlet weak var closeOpenImageView: UIImageView!
    
    @IBOutlet weak var shopsButton: UIButton!
    
    @IBAction func shopsButtonTouched(_ sender: Any) {
        print("Shops button pressed")
        performSegue(withIdentifier: "ShowShopsSegueFromMenuButtons", sender: sender as! UIButton)
    }
    
    @IBOutlet weak var activitiesButton: UIButton!
    
    @IBAction func activitiesButtonTouched(_ sender: Any) {
        print("Activities button pressed")
        performSegue(withIdentifier: "ShowShopsSegueFromMenuButtons", sender: sender as! UIButton)
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noConnectionView.isHidden = true
        
        closeOpenImageView.image = UIImage(named: "closed.jpg")
        let myImage = UIImage(named: "closed.jpg")
        let myImageView = UIImageView(image: myImage)
        myImageView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        shopsButton.isHidden = true
        activitiesButton.isHidden = true
        
        ExecuteOnceInteractorImpl().execute2(initializeClosure: {
            self.testingConnection()
        }) {
            print("Data was initialized previously.")
            openAndShowLiterals()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    // MARK: - Fetched results controller
    var _fetchedResultsControllerForShops: NSFetchedResultsController<ShopCD>? = nil
    var _fetchedResultsControllerForActivities: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsControllerForShops: NSFetchedResultsController<ShopCD> {
        if _fetchedResultsControllerForShops != nil {
            return _fetchedResultsControllerForShops!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the predicate format as appropriate.
        let predicate = NSPredicate(format: "entityType == %@", "shop")
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        _fetchedResultsControllerForShops = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        
        do {
            try _fetchedResultsControllerForShops!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsControllerForShops!
    }
    
    var fetchedResultsControllerForActivities: NSFetchedResultsController<ShopCD> {
        if _fetchedResultsControllerForActivities != nil {
            return _fetchedResultsControllerForActivities!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the predicate format as appropriate.
        let predicate = NSPredicate(format: "entityType == %@", "activity")
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        _fetchedResultsControllerForActivities = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        
        do {
            try _fetchedResultsControllerForActivities!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsControllerForActivities!
    }
    
    func initializeData() {
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        
        downloadShopsInteractor.execute(urlString: "https://madrid-shops.com/json_new/getShops.php") { (shops: ModelObjects) in
            // All OK
            
            let cacheInteractor = SaveAllShopsInteractorImpl()
            
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: {
                print("1️⃣ Shops saved")
                let downloadActivitiesInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
                
                downloadActivitiesInteractor.execute(urlString: "https://madrid-shops.com/json_new/getActivities.php", onSuccess: { (activities: ModelObjects) in
                    let cacheInteractor2 = SaveAllShopsInteractorImpl()
                    
                    cacheInteractor2.execute(shops: activities, context: self.context, onSuccess: {
                        print("2️⃣ Activities saved")
                        SetExecutedOnceInteractorImpl().execute()
                        
                        self.reachability.stopNotifier()
                        
                        self._fetchedResultsControllerForShops = nil
                        self._fetchedResultsControllerForActivities = nil
                        
                        print("Data initialized.")
                        self.hideActivity()
                        self.openAndShowLiterals()
                    })
                })
                
                //                SetExecutedOnceInteractorImpl().execute()
                //
                //                self._fetchedResultsControllerForShops = nil
                //                self._fetchedResultsControllerForActivities = nil
                //
                //                print("Data initialized.")
                //                self.openAndShowLiterals()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegueFromMenuButtons" {
            let vc = segue.destination as! ViewController
            vc.context = self.context
            vc.fetchedResultsControllerForShops = self.fetchedResultsControllerForShops
            vc.fetchedResultsControllerForActivities = self.fetchedResultsControllerForActivities
            
            if (sender as? UIButton == shopsButton) {
                vc.idButton = "tenda"
            } else {
                vc.idButton = "activitat"
            }
            
            vc.firstTimeMapRendered = true
        }
    }
    
    func openAndShowLiterals() {
        closeOpenImageView.image = UIImage(named: "open.jpg")
        shopsButton.setTitle(String.obtainLiteral(es: "Tiendas", en: "Shops"), for: .normal)
        activitiesButton.setTitle(String.obtainLiteral(es: "Actividades", en: "Activities"), for: .normal)
        shopsButton.isHidden = false
        activitiesButton.isHidden = false
    }
    
    func showActivity() {
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        activityIndicator.stopAnimating()
    }
    
    func testingConnection() {
        reachability.whenReachable = { reachability in
            if reachability.description == "WiFi" {
                print("1️⃣ Reachable via WiFi")
            } else {
                print("2️⃣ Reachable via Cellular")
            }
            
            OperationQueue.main.addOperation {
                self.noConnectionView.isHidden = true
                self.showActivity()
            }
            
            self.initializeData()
        }
        
        reachability.whenUnreachable = { _ in
            OperationQueue.main.addOperation {
                assert(Thread.current == Thread.main)
                self.noConnectionView.text = String.obtainLiteral(es: "No hay conexión. Intentando conectar...", en: "No connection. Trying to connect...")
                self.noConnectionView.isHidden = false
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("4️⃣ Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.description {
        case "WiFi":
            print("Reachable via WiFi")
        case "Cellular":
            print("Reachable via Cellular")
        default:
            print("Network not reachable")
        }
    }
}
