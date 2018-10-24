
import Foundation

protocol GBPostManagerDelegate: class {
    func saveButtonPressed(with content: String)
    func closeButtonPressed()
    func mediaLibraryButtonPressed()
}

@objc (GBPostManager)
public class GBPostManager: RCTEventEmitter {
    public override static func moduleName() -> String! {
        return "GBPostManager"
    }

    var delegate: GBPostManagerDelegate?

    public override static func requiresMainQueueSetup() -> Bool {
        return false
    }

    public override func supportedEvents() -> [String]! {
        return ["mediaSelected"]
    }

    // MARK: - Communication methods

    @objc(savePost:)
    func savePost(with content: String) {
        delegate?.saveButtonPressed(with: content)
    }

    @objc
    func close() {
        delegate?.closeButtonPressed()
    }

    @objc
    func showMediaLibrary() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.mediaLibraryButtonPressed()
        }
    }

    func mediaSelected(with url: String) {
        sendEvent(withName: "mediaSelected", body: ["url": url])
    }
}
