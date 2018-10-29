
import UIKit

// MARK: - BottomSheetDemoSearchController

class BottomSheetDemoSearchController: UISearchController {
    init() {
        super.init(searchResultsController: nil)
        initialize()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension BottomSheetDemoSearchController {
    func initialize() {
        modalPresentationStyle = .custom

        hidesNavigationBarDuringPresentation = false
        obscuresBackgroundDuringPresentation = false

        searchBar.searchBarStyle = .default
        searchBar.placeholder = NSLocalizedString("Search", comment: "Search")
        searchBar.showsBookmarkButton = false
        searchBar.showsCancelButton = false
        searchBar.tintColor = .white    // influences Color of "Cancel" button text

        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.isSecureTextEntry = false
        searchBar.keyboardAppearance = .default
        searchBar.keyboardType = .default
        searchBar.returnKeyType = .search
        searchBar.spellCheckingType = .yes

        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self, BottomSheetDemoSearchController.self])
        textFieldAppearance.tintColor = WPStyleGuide.darkGrey() // Influences cursor color

        view.backgroundColor = .white
    }
}
