//
//  Landmark.swift
//  Cars
//
//  Created by Serafín Ennes Moscoso on 27/01/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import SwiftUI

struct Landmark: Identifiable, Decodable {
    var id: Int
    var name: String
    var imageName: String
    var state: String
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

class LandmarkMapper: ObservableObject {
    @Published var landmarks = [Landmark]()

    init() { load() }

    func load() {
        guard let url = URL(string: "https://raw.githubusercontent.com/FinsiEnnes/SwiftUI/master/combine/intro/landmarkData.json") else { return }

        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                guard let d = data else { return }
                let landmarks = try JSONDecoder().decode([Landmark].self, from: d)
                DispatchQueue.main.async { self.landmarks = landmarks }
            } catch {
                print ("Error")
            }
        }.resume()
    }
}

struct FetchView: View {
    @ObservedObject var mapper = LandmarkMapper()

    var body: some View {
        NavigationView {
            List(mapper.landmarks) { landmark in
                LandmarkRow(landmark: landmark)
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

