//
//  SuggestionsViewController.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 27.02.2024.
//

import UIKit

// MARK: - Nested types

private enum SuggestionsViewConstants {
    static let cellId: String = "reusableCell"
}

public final class SuggestionsViewController<
    Provider: SuggestionsProvider,
    ContentView: SuggestionView
>: UIViewController, UITableViewDataSource where Provider.SectionData.Item == ContentView.ItemData {
    // MARK: - Private methods

    private let provider: Provider
    private var data: [Provider.SectionData] = []

    private lazy var rootView: UITableView = .init(frame: .zero, style: .plain)

    // MARK: - Initialization

    public init(provider: Provider) {
        self.provider = provider

        super.init(nibName: nil, bundle: nil)

        provider.updateDataAction = { [weak self] in
            self?.data = $0
            self?.rootView.reloadData()
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods

    public override func loadView() {
        rootView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        rootView.translatesAutoresizingMaskIntoConstraints = false

        rootView.register(
            SuggestionTableViewCell<ContentView>.self,
            forCellReuseIdentifier: SuggestionsViewConstants.cellId
        )
        rootView.dataSource = self

        view = rootView
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
        let tableViewCell = tableView.dequeueReusableCell(
            withIdentifier: SuggestionsViewConstants.cellId,
            for: indexPath
        )

        guard let section = data[safe: indexPath.section],
              let item = section.items[safe: indexPath.item],
              let cell = tableViewCell as? SuggestionTableViewCell<ContentView>
        else { return tableViewCell }

        cell.configure(with: item)

        return cell
    }
}
