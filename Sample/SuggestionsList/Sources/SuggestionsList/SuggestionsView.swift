//
//  SuggestionsView.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

public final class SuggestionsView<Provider: SuggestionsProvider>: UIView, UITableViewDataSource {
    // MARK: - Private properties

    private var data: [Provider.SectionData] = []
    private let provider: Provider

    private let tableView: UITableView = .init(frame: .zero, style: .plain)

    // MARK: - Init

    public init(provider: Provider) {
        self.provider = provider

        super.init(frame: .zero)

        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)

        configureTableView()
        provider.updateDataAction = { [weak self] in
            self?.data = $0
            self?.tableView.reloadData()
            $0.flatMap(\.items)
                .reduce(into: Set<String>()) { $0.insert($1.id) }
                .forEach {
                    self?.tableView.register(SuggestionTableViewCell.self, forCellReuseIdentifier: $0)
                }
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Private methods

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])

        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource implementation

    public func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard data.count > section else { return .zero }

        return data[section].items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = data[safe: indexPath.section],
              let item = section.items[safe: indexPath.item],
              let cell = tableView.dequeueReusableCell(withIdentifier: item.id, for: indexPath) as? SuggestionTableViewCell
        else { return .init(style: .default, reuseIdentifier: nil) }

        if !cell.isConfigured {
            cell.set(content: provider.makeView(for: item))
        }
        if let contentView = cell.content {
            provider.configure(view: contentView, for: item)
        }

        return cell
    }
}
