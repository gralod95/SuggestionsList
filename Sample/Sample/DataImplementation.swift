//
//  DataImplementation.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit
import SuggestionsList

struct SuggestionSectionDataImpl: SuggestionSectionData {
    typealias ContentView = UITextView

    let items: [SuggestionItemImpl]
}

public struct SuggestionItemImpl: SuggestionItem {
    let text: String
}

struct SuggestionSectionDataImpl2: SuggestionSectionData {
    typealias ContentView = UIImageView

    let items: [SuggestionItemImpl2]
}

public struct SuggestionItemImpl2: SuggestionItem {
    let image: UIImage?
}


let mockDataImpl: SuggestionSectionDataImpl = .init(
    items: [.init(text: "first item"), .init(text: "second \nitem")]
)

let mockDataImpl1: SuggestionSectionDataImpl = .init(
    items: [.init(text: "first item"), .init(text: "second \nitem"), .init(text: "third item")]
)

let mockDataImpl2: SuggestionSectionDataImpl2 = .init(
    items: [.init(image: .init(systemName: "star"))]
)

class SuggestionsProviderImpl: SuggestionsProvider {
    var contentViewTypesForRegistration: [any SuggestionView.Type] = [UITextView.self, UIImageView.self]


    var updateDataAction: ([any SuggestionSectionData]) -> Void = { _ in }

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateDataAction([mockDataImpl, mockDataImpl2])
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateDataAction([mockDataImpl1, mockDataImpl2])
        }
    }
}

extension UITextView: SuggestionView {
    public func configure(with data: SuggestionItemImpl) {
        text = data.text
    }
}

extension UIImageView: SuggestionView {
    public func configure(with data: SuggestionItemImpl2) {
        image = data.image
    }
}
