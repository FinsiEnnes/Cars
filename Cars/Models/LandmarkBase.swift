//
//  Landmark.swift
//  Cars
//
//  Created by Serafín Ennes Moscoso on 27/01/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import SwiftUI
import Combine

struct LandmarkData: Identifiable, Decodable {
    var id: Int
    var name: String
    var imageName: String
    var state: String
}

extension LandmarkData {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

enum NetworkErrors:Error {
    case BadContent
}

class LandmarkMapper: ObservableObject {
    @Published var landmarks = [LandmarkData]()
    var cancellable: AnyCancellable?

    init() { loadWithCombine() }

    func load() {
        guard let url = URL(string: "https://raw.githubusercontent.com/FinsiEnnes/SwiftUI/master/combine/intro/landmarkData.json") else { return }

        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                guard let d = data else { return }
                let landmarks = try JSONDecoder().decode([LandmarkData].self, from: d)
                DispatchQueue.main.async { self.landmarks = landmarks }
            } catch {
                print ("Error")
            }
        }.resume()
    }

    func loadWithCombine() {

        guard let url = URL(string: "https://raw.githubusercontent.com/FinsiEnnes/SwiftUI/master/combine/intro/landmarkData.json") else { return }

        cancellable = URLSession.shared
        .dataTaskPublisher(for: url)
        .tryMap {
            guard let response = $1 as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkErrors.BadContent }
                return $0
        }
        .decode(type: [LandmarkData].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
               switch completion {
                  case .failure(let failure):
                   print("Error \(failure)")
                  case .finished:
                  print("Hecho")
               }
           }, receiveValue: {
            self.landmarks = $0
           })

    }
}

//struct FetchView: View {
//    @ObservedObject var mapper = LandmarkMapper()
//
//    var body: some View {
//        NavigationView {
//            List(mapper.landmarks) { landmark in
//                LandmarkRow(landmark: landmark)
//            }
//            .navigationBarTitle(Text("Landmarks"))
//        }
//    }
//}

