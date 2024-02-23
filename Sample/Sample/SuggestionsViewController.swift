import UIKit

final class SuggestionsViewController: UIViewController {
    private lazy var rootView: SuggestionsView = .init(provider: SuggestionsProviderImpl())

    override func loadView() {
        view = rootView
    }
}
