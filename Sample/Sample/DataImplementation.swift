//
//  DataImplementation.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit
import SuggestionsList

public struct SuggestionItemImpl: SuggestionItem {
    let text: String
}

struct SuggestionSectionDataImpl: SuggestionSectionData {
    let items: [SuggestionItemImpl]
}


let mockDataImpl: SuggestionSectionDataImpl  = .init(
    items: [.init(text: "first item"), .init(text: "second \nitem")]
)

let mockDataImpl1: SuggestionSectionDataImpl  = .init(
    items: [.init(text: "first item"), .init(text: "second \nitem"), .init(text: "third item")]
)

class SuggestionsProviderImpl: SuggestionsProvider {

    var updateDataAction: ([SuggestionSectionDataImpl]) -> Void = { _ in }

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateDataAction([mockDataImpl])
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateDataAction([mockDataImpl1])
        }
    }
}

extension UITextView: SuggestionView {
    public func configure(with data: SuggestionItemImpl) {
        text = data.text
    }
}
