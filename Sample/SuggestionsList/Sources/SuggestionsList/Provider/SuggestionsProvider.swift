//
//  SuggestionsProvider.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

public protocol SuggestionsProvider: AnyObject {
    associatedtype SectionData: SuggestionSectionData

    var updateDataAction: ([SectionData]) -> Void { get set }
}
