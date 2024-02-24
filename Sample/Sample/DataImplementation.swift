//
//  DataImplementation.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit
import SuggestionsList

enum SuggestionItemImpl: SuggestionItem {
    case title(String)
    case image(UIImage)

    var id: String {
        switch self {
        case .title:
            return "title"
        case .image:
            return "image"
        }
    }
}

struct SuggestionSectionDataImpl: SuggestionSectionData {
    let items: [SuggestionItemImpl]
}


let mockDataImpl: SuggestionSectionDataImpl  = .init(
    items: [SuggestionItemImpl.title("some \nmm"), SuggestionItemImpl.image(.init(systemName: "star")!)]
)

let mockDataImpl1: SuggestionSectionDataImpl  = .init(
    items: [SuggestionItemImpl.title("some \nmm"), SuggestionItemImpl.title("some1"), SuggestionItemImpl.image(.init(systemName: "star")!)]
)

class SuggestionsProviderImpl: SuggestionsProvider {

    var updateDataAction: ([SuggestionSectionDataImpl]) -> Void = { _ in }

    func makeView(for data: SuggestionItemImpl) -> UIView {
        switch data {
        case .title:
            return UITextView(frame: .zero)
        case .image:
            return UIImageView(frame: .zero)
        }
    }
    
    func configure(view: UIView, for data: SuggestionItemImpl) {
        switch data {
        case .title(let string):
            (view as? UITextView)?.text = string
        case .image(let image):
            (view as? UIImageView)?.image = image
        }
    }

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateDataAction([mockDataImpl])
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateDataAction([mockDataImpl1])
        }
    }
}
