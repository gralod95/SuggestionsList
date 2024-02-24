//
//  SuggestionsProvider.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

public protocol SuggestionsProvider: AnyObject {
    associatedtype SectionData: SuggestionSectionData
    associatedtype ItemData: SuggestionItem where SectionData.Item == ItemData

    var updateDataAction: ([SectionData]) -> Void { get set }

    /// Method for making new view for data type
    /// - Parameter data: model, witch will be used for configure view
    /// - Returns: view for showing in suggestionList
    func makeView(for data: ItemData) -> UIView

    /// Method for configure view about to show
    /// - Parameters:
    ///   - view: view about to show
    ///   - data: data, associated with view
    func configure(view: UIView, for data: ItemData)
}
