//
//  SuggestionView.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 27.02.2024.
//

import UIKit

public protocol SuggestionView: UIView {

    associatedtype ItemData: SuggestionItem

    /// Method for configure view about to show
    /// - Parameters:
    ///   - data: data, associated with view
    func configure(with data: ItemData)
}
