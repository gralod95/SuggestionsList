//
//  SuggestionSectionData.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import Foundation

public protocol SuggestionSectionData {
    /// Ids for register any unique view in list for reusing
    var itemsIds: [String] { get }
    /// Items to show in section
    var items: [SuggestionItem] { get }
}
