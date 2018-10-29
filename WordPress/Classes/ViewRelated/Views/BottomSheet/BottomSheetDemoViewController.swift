
import UIKit

// MARK: - BottomSheetDemoViewController

class BottomSheetDemoViewController: UISearchContainerViewController {
    init() {
        let searchController = BottomSheetDemoSearchController()
        super.init(searchController: searchController)
        modalPresentationStyle = .custom
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Location", comment: "Title of Location search in/on Bottom Sheet")

        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(demoActionTapped))
        navigationItem.leftBarButtonItem = cancelItem

        let saveText = NSLocalizedString("Save", comment: "Save button.")
        let saveItem = UIBarButtonItem(title: saveText, style: .done, target: self, action: #selector(demoActionTapped))
        navigationItem.rightBarButtonItem = saveItem

        setupView()
    }
}

private extension BottomSheetDemoViewController {
    func setupView() {
        view.backgroundColor = .white

        guard let navigationController = navigationController else {
            return
        }

        navigationController.preferredContentSize = UIScreen.main.bounds.size

        let navigationBar = navigationController.navigationBar

        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        let barButtonItemColor = WPStyleGuide.wordPressBlue()

        let barButtonItems = [ navigationItem.leftBarButtonItem, navigationItem.rightBarButtonItem ].compactMap { $0 }

        for item in barButtonItems {
            item.tintColor = barButtonItemColor
            item.setTitleTextAttributes([.foregroundColor: barButtonItemColor], for: .normal)
        }
    }

    @objc
    func demoActionTapped() {
        presentingViewController?.dismiss(animated: true)
    }
}
