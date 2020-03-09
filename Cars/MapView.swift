//
//  MapView.swift
//  Cars
//
//  Created by Serafín Ennes Moscoso on 12/01/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: landmarkData[0].locationCoordinate)
//    }
//}
