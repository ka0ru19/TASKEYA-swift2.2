//
//  MapViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/07.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapTitle: UINavigationItem!
    
    
    var myLocationManager:CLLocationManager!
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    // 緯度、経度
    //    var focusedLatitude: CLLocationDegrees!
    //    var focusedLongitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mapTitle.title = "タップして位置を指定"
        
        // 現在地を取得します
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        // 承認されていない場合はここで認証ダイアログを表示します.
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 100
        myLocationManager.startUpdatingLocation()
        
        
        // 初期位置を表示
        let coordinate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(region, animated:true)
        
    }
    
    // 位置情報取得成功時に呼ばれます
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        print("緯度：\(manager.location!.coordinate.latitude)")
        print("経度：\(manager.location!.coordinate.longitude)")
        // 初期位置を表示
        let coordinate = CLLocationCoordinate2DMake(manager.location!.coordinate.latitude, manager.location!.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(region, animated:true)
        
    }
    
    
    // 位置情報をnavigationBarに表示
    func displayLocationInfo(placemark: CLPlacemark) {
        var address: String = ""
        //        address += placemark.country != nil ? placemark.country! : ""
        address += placemark.administrativeArea != nil ? placemark.administrativeArea! : ""
        address += placemark.locality != nil ? placemark.locality! : ""
        //        address += ","
        //        address += placemark.postalCode != nil ? placemark.postalCode! : ""
        //        address += ","
        //        address += ","
        
        print(address)
        mapTitle.title = address
    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("error:位置情報取得失敗")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSearchBar(sender: UIBarButtonItem) {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        
    }
    
    // Searchボタンが押されたら
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            // 検索結果のピンの座標をprint
            print("検索:\(searchBar.text) => latitude: \(localSearchResponse!.boundingRegion.center.latitude), longitude: \(localSearchResponse!.boundingRegion.center.longitude)")
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            
            let location = CLLocation(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                if placemarks!.count > 0 {
                    let pm = placemarks![0] as CLPlacemark
                    self.displayLocationInfo(pm)
                    //stop updating location to save battery life
                    //                self.lm.stopUpdatingLocation()
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
            
        }
    }
    
    func putPin(lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        // 以前のピンを全削除
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove)
        
        pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        //        mapView.centerCoordinate = self.pointAnnotation.coordinate
        mapView.addAnnotation(self.pinAnnotationView.annotation!)
        
        
    }
    
    // map上をタップで位置を取得
    @IBAction func mapViewDidTap(sender: UITapGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Ended {
            let tapPoint = sender.locationInView(mapView)
            let center = mapView.convertPoint(tapPoint, toCoordinateFromView: mapView)
            print("ピン=> 緯度:\(center.latitude) 経度:\(center.longitude)")
            putPin(center.latitude, center.longitude)
            
            let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                if placemarks!.count > 0 {
                    let pm = placemarks![0] as CLPlacemark
                    self.displayLocationInfo(pm)
                    //stop updating location to save battery life
                    //                self.lm.stopUpdatingLocation()
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
            
        }
    }
    
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.placeAdress = mapTitle.title
        appDelegate.placePoint = String(pointAnnotation.coordinate.latitude) + "," + String(pointAnnotation.coordinate.longitude)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//    }
    
    
//    // Segue 準備
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        let backVC: NewPostInputViewController = (segue.destinationViewController as? NewPostInputViewController)!
//        // SubViewController のselectedImgに選択された画像を設定する
//        //            nextVC.userImage = userImage
//        backVC.placeInfoString = String(pointAnnotation.coordinate.latitude) + "," + String(pointAnnotation.coordinate.longitude)
//        backVC.mapButtonLabel = navigationItem.title!
//        
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
