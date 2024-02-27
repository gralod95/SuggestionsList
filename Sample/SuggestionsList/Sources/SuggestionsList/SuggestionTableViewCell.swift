//
//  SuggestionTableViewCell.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

final class SuggestionTableViewCell<ContentView: SuggestionView>: UITableViewCell {
    // MARK: - Public properties

    private(set) var content: ContentView = .init(frame: .zero)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureSubview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureSubview()
    }
    
    // MARK: - Public methods

    func configure(with data: ContentView.ItemData) {
        content.configure(with: data)
    }

    // MARK: - Private methods

    private func configureSubview() {
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
