//
//  SuggestionTableViewCell.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

final class SuggestionTableViewCell: UITableViewCell {
    var isConfigured: Bool { content != .none }

    private(set) var content: UIView?

    func set(content: UIView) {
        guard !isConfigured else {
            assertionFailure("content view has been set already!")
            return
        }

        self.content = content

        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
