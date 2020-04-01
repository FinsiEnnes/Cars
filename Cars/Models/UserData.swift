//
//  UserData.swift
//  Cars
//
//  Created by Serafín Ennes Moscoso on 01/04/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import Foundation
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavorites = false
    @Published var landmarks = landmarkData
}
