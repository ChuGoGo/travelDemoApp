//
//  MapViewController.swift
//  travelDemoApp
//
//  Created by Chu Go-Go on 2022/5/6.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var infoTextView: UITextView!
    var taiwanInfo: Taiwan?
    var latitude:Double = 0.0
    let locationManager = CLLocationManager()
    let pin = MKPointAnnotation()
    required init?(coder: NSCoder,taiwanInfo:Taiwan) {
        super.init(coder: coder)
        self.taiwanInfo = taiwanInfo
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        詢問是否同意使用你的位置
  
        mapView.delegate = self
        setPinLocation()
        mapView.showsUserLocation = true
       
        print("end\(pin)")
//        changelatitude(loction: (taiwanInfo?.Py)!)
//        taiwanMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: changelatitude(loction: (taiwanInfo?.Py)!), longitude: changelatitude(loction: (taiwanInfo?.Px)!)), latitudinalMeters: 20000, longitudinalMeters: 20000)
        UserDefaults.standard.set("zh", forKey: "AppleLanguages")
        
        infoTextView.text = taiwanInfo?.Travellinginfo
                // Do any additional setup after loading the view.
    }
    func setPinLocation(){
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        var region = MKCoordinateRegion()
        let endLocation = CLLocationCoordinate2D(latitude: changelatitude(loction: (taiwanInfo?.Py)!), longitude: changelatitude(loction: (taiwanInfo?.Px)!))
        pin.coordinate = endLocation
        pin.title = taiwanInfo?.Name
        pin.subtitle = taiwanInfo?.Add
        region.span = span
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
    }
    func changelatitude(loction:String?)-> CLLocationDegrees{
      
        guard let double = Double(loction!) else { return 23.33 }
            return CLLocationDegrees(double)
        
    }
//    開啟導航
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let start = mapView.userLocation.coordinate
        let end = pin.coordinate
        print("end\(end)")
        myTrip(star: start, end: end)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let identitfier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identitfier) as?
        MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identitfier)
        }
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        let dropButtob = UIButton(type: .infoLight)
        annotationView?.rightCalloutAccessoryView = dropButtob
        return annotationView
    }
    func myTrip(star: CLLocationCoordinate2D,end: CLLocationCoordinate2D){
        let locationStar = MKPlacemark(coordinate: star, addressDictionary: nil)
        let locationEnd = MKPlacemark(coordinate: end, addressDictionary: nil)
        
        let mapItemStart = MKMapItem(placemark: locationStar)
        let mapItemEnd = MKMapItem(placemark: locationEnd)
        mapItemStart.name = "我的位置"
        mapItemEnd.name = taiwanInfo?.Name
        
        let mapItems = [mapItemStart,mapItemEnd]
        let mode = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: mapItems, launchOptions: mode)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
