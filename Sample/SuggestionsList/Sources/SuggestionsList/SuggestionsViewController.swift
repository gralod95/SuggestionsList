//
//  SuggestionsViewController.swift
//  SuggestionsList
//
//  Created by Odinokov G. A. on 27.02.2024.
//

import UIKit

public final class SuggestionsViewController<Provider: SuggestionsProvider>: UIViewController, UITableViewDataSource {
    // MARK: - Private methods

    private let provider: Provider
    private var data: [any SuggestionSectionData] = []

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

        provider.contentViewTypesForRegistration.forEach { type in
            registerCellType(type: type)
        }
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
        guard let section = data[safe: indexPath.section]
        else { return .init() }

        return section.getCell(rootView: rootView, indexPath: indexPath)
    }

    private func registerCellType<ContentType: SuggestionView>(type: ContentType.Type) {
        rootView.register(
            SuggestionTableViewCell<ContentType>.self,
            forCellReuseIdentifier: String(describing: SuggestionTableViewCell<ContentType>.self)
        )
    }
}

private extension SuggestionSectionData {
    func getCell(
        rootView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = rootView.dequeueReusableCell(
            withIdentifier: String(describing: SuggestionTableViewCell<ContentView>.self),
            for: indexPath
        )

        if let item = items[safe: indexPath.item] {
            (cell as? SuggestionTableViewCell<ContentView>)?.configure(with: item)
        }

        return cell
    }
}
