//
//  MapViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
import MapKit

class MapViewController: Controller<MapPresenter> {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocationManager()
        setupMKAnnotations()
    }

}

// MARK: - Presetting
extension MapViewController {
    
    private func setupMapView() {
        mapView.delegate = self
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    private func setupMKAnnotations() {
        for announcement in presenter!.announcementRepository.feed {
            let annotation = AnnouncementPointAnnotation(id: announcement.id)
            annotation.coordinate = CLLocationCoordinate2D(latitude: announcement.latitude, longitude: announcement.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is AnnouncementPointAnnotation else { return nil }
        
        let identifier = "AnnouncementAnnotationView"
        
        var announcementAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if announcementAnnotationView == nil {
            announcementAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //announcementAnnotationView!.canShowCallout = false
        } else {
            announcementAnnotationView!.annotation = annotation
        }

        announcementAnnotationView!.image = UIImage(named: "map-marker-blue")!

        return announcementAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect: MKAnnotationView) {
        guard let annotation = didSelect.annotation as? AnnouncementPointAnnotation else { return }
        let announcementId = annotation.id
        let announcement = presenter!.announcementRepository.feed.first(where: {$0.id == announcementId})!
        
        #if DEBUG
        print("Annotation with announcement id \(announcementId) has selected")
        #endif
        
        presenter?.pushInspectAnnouncementViewController(with: announcement)
        
        self.mapView.deselectAnnotation(annotation, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect: MKAnnotationView) {
        #if DEBUG
        print("Annotation has deselected")
        #endif
    }
    
}

