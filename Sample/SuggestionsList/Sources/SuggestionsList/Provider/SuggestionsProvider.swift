//
//  SuggestionsProvider.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

public protocol SuggestionsProvider: AnyObject {
    var contentViewTypesForRegistration: [any SuggestionView.Type] { get }
    var updateDataAction: ([any SuggestionSectionData]) -> Void { get set }
}
