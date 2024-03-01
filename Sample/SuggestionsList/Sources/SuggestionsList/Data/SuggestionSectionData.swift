//
//  SuggestionSectionData.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import Foundation

public protocol SuggestionSectionData {
    associatedtype Item: SuggestionItem
    associatedtype ContentView: SuggestionView where ContentView.ItemData == Item

    /// Items to show in section
    var items: [Item] { get }
}
