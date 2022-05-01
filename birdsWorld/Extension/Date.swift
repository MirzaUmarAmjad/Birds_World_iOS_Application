//
//  Date.swift
//  birdsWorld
//
//  Created by Umar Amjad on 22/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self.String) // replace Date String
    }
}

