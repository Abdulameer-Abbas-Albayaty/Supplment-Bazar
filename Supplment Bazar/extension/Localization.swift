//
//  Localization.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation
extension String {
    func getLocalized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
