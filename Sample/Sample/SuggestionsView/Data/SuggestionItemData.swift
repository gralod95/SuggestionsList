//
//  SuggestionItemData.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import Foundation

protocol SuggestionItem {
    /// Unique id for view (it is used in UITableView for register reusable cell)
    var id: String { get }
}
