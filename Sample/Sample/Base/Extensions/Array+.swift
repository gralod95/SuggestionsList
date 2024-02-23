//
//  Array+.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
}
