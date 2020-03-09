//
//  LandmarkRow.swift
//  Cars
//
//  Created by Serafín Ennes Moscoso on 27/01/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import Foundation

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(landmark.name).bold()
                Text(landmark.state).font(.caption)
            }.padding()
            Spacer()
        }
    }
}

