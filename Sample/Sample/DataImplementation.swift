//
//  DataImplementation.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

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
    let itemsIds: [String]
    let items: [SuggestionItem]
}


let mockDataImpl: SuggestionSectionDataImpl  = .init(
    itemsIds: ["title", "image"],
    items: [SuggestionItemImpl.title("some \nmm"), SuggestionItemImpl.image(.init(systemName: "star")!)]
)

let mockDataImpl1: SuggestionSectionDataImpl  = .init(
    itemsIds: ["title", "image"],
    items: [SuggestionItemImpl.title("some \nmm"), SuggestionItemImpl.title("some1"), SuggestionItemImpl.image(.init(systemName: "star")!)]
)

class SuggestionsProviderImpl: SuggestionsProvider {

    var updateDataAction: ([SuggestionSectionData]) -> Void = { _ in }
    
    func makeView(for data: SuggestionItem) -> UIView {
        guard let data = data as? SuggestionItemImpl else { return .init() }

        switch data {
        case .title:
            return UITextView(frame: .zero)
        case .image:
            return UIImageView(frame: .zero)
        }
    }
    
    func configure(view: UIView, for data: SuggestionItem) {
        guard let data = data as? SuggestionItemImpl else { return }

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
