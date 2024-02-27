//
//  SuggestionSectionData.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import Foundation

public protocol SuggestionSectionData {
    associatedtype Item: SuggestionItem
    
    /// Items to show in section
    var items: [Item] { get }
}
