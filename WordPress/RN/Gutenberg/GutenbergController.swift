
import UIKit
import React
import MobileCoreServices

class GutenbergController: UIViewController, PostEditor {
    var onClose: ((Bool, Bool) -> Void)?

    var isOpenedDirectlyForPhotoPost: Bool = false

    let post: AbstractPost

    /// Media Library Data Source
    ///
    fileprivate lazy var mediaLibraryDataSource: MediaLibraryPickerDataSource = {
        return MediaLibraryPickerDataSource(post: self.post)
    }()

    required init(post: AbstractPost) {
        guard let post = post as? Post else {
            fatalError()
        }
        self.post = post
        super.init(nibName: nil, bundle: nil)

        GutenbergBridge.shared.mediaProvider.post = post
        GutenbergBridge.shared.postManager.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        let props: [AnyHashable: Any] = [
            "initialData": post.content ?? ""]
        let bridge = GutenbergBridge.shared
        view = RCTRootView(bridge: bridge.rnBridge, moduleName: "gutenberg", initialProperties: props)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post.titleForDisplay()
    }

    @objc private func close(sender: UIBarButtonItem) {
        close(didSave: false)
    }

    private func close(didSave: Bool) {
        GutenbergBridge.shared.mediaProvider.post = nil
        GutenbergBridge.shared.postManager.delegate = nil
        onClose?(didSave, false)
    }

    private func presentMediaPickerFullScreen(animated: Bool, dataSourceType: MediaPickerDataSourceType = .device) {

        let options = WPMediaPickerOptions()
        options.showMostRecentFirst = true
        options.filter = [.all]
        options.allowCaptureOfMedia = false
        options.showSearchBar = true
        options.badgedUTTypes = [String(kUTTypeGIF)]

        let picker = WPNavigationMediaPickerViewController()

        switch dataSourceType {
        case .device:
//            picker.dataSource = devicePhotoLibraryDataSource
            break;
        case .mediaLibrary:
            picker.startOnGroupSelector = false
            picker.showGroupSelector = false
            picker.dataSource = mediaLibraryDataSource
//            registerChangeObserver(forPicker: picker.mediaPicker)
        }

//        picker.selectionActionTitle = Constants.mediaPickerInsertText
        picker.mediaPicker.options = options
        picker.delegate = self
        picker.modalPresentationStyle = .currentContext
//        if let previousPicker = mediaPickerInputViewController?.mediaPicker {
//            picker.mediaPicker.selectedAssets = previousPicker.selectedAssets
//        }

        present(picker, animated: true)
    }
}

extension GutenbergController: GBPostManagerDelegate {
    func closeButtonPressed() {
        close(didSave: false)
    }

    func saveButtonPressed(with content: String) {
        guard let post = post as? Post else {
            return
        }
        post.content = content
        PostCoordinator.shared.save(post: post)
        DispatchQueue.main.async { [weak self] in
            self?.close(didSave: true)
        }
    }

    func mediaLibraryButtonPressed() {
        presentMediaPickerFullScreen(animated: true, dataSourceType: .mediaLibrary)
    }
}


// MARK: - MediaPickerViewController Delegate Conformance
//
extension GutenbergController: WPMediaPickerViewControllerDelegate {

    func emptyViewController(forMediaPickerController picker: WPMediaPickerViewController) -> UIViewController? {
//        if picker != mediaPickerInputViewController?.mediaPicker {
//            return noResultsView
//        }
        return nil
    }

    func mediaPickerController(_ picker: WPMediaPickerViewController, didUpdateSearchWithAssetCount assetCount: Int) {
//        noResultsView.removeFromView()
//        noResultsView.configureForNoSearchResult()
    }

    func mediaPickerControllerWillBeginLoadingData(_ picker: WPMediaPickerViewController) {
//        updateSearchBar(mediaPicker: picker)
//        noResultsView.configureForFetching()
    }

    func mediaPickerControllerDidEndLoadingData(_ picker: WPMediaPickerViewController) {
//        updateSearchBar(mediaPicker: picker)
//        noResultsView.removeFromView()
//        noResultsView.configureForNoAssets(userCanUploadMedia: false)
    }

    func mediaPickerControllerDidCancel(_ picker: WPMediaPickerViewController) {
//        if picker != mediaPickerInputViewController?.mediaPicker {
//            unregisterChangeObserver()
//            mediaLibraryDataSource.searchCancelled()
            dismiss(animated: true, completion: nil)
//        }
    }

    func mediaPickerController(_ picker: WPMediaPickerViewController, didFinishPicking assets: [WPMediaAsset]) {
//        if picker != mediaPickerInputViewController?.mediaPicker {
//            unregisterChangeObserver()
//            mediaLibraryDataSource.searchCancelled()
//            dismiss(animated: true, completion: nil)
//            mediaSelectionMethod = .fullScreenPicker
//        } else {
//            mediaSelectionMethod = .inlinePicker
//        }

        dismiss(animated: true, completion: nil)

//        closeMediaPickerInputViewController()

//        if assets.isEmpty {
//            return
//        }

        for asset in assets {
            switch asset {
//            case let phAsset as PHAsset:
//                insertDeviceMedia(phAsset: phAsset)
            case let media as Media:
                insertSiteMediaLibrary(media: media)
            default:
                continue
            }
        }
    }

    private func insertSiteMediaLibrary(media: Media) {
        if media.hasRemote {
            insertRemoteSiteMediaLibrary(media: media)
        } else {
            insertLocalSiteMediaLibrary(media: media)
        }
    }

    private func insertRemoteSiteMediaLibrary(media: Media) {
        let url = media.remoteURL ?? ""
        GutenbergBridge.shared.postManager.mediaSelected(with: url)
    }

    private func insertLocalSiteMediaLibrary(media: Media) {

    }


    func mediaPickerController(_ picker: WPMediaPickerViewController, selectionChanged assets: [WPMediaAsset]) {
        updateFormatBarInsertAssetCount()
    }

    func mediaPickerController(_ picker: WPMediaPickerViewController, didSelect asset: WPMediaAsset) {
        updateFormatBarInsertAssetCount()
    }

    func mediaPickerController(_ picker: WPMediaPickerViewController, didDeselect asset: WPMediaAsset) {
        updateFormatBarInsertAssetCount()
    }

    func mediaPickerController(_ picker: WPMediaPickerViewController, previewViewControllerFor assets: [WPMediaAsset], selectedIndex selected: Int) -> UIViewController? {
//        mediaPreviewHelper = MediaPreviewHelper(assets: assets)
//        return mediaPreviewHelper?.previewViewController(selectedIndex: selected)
        return nil
    }

    private func updateFormatBarInsertAssetCount() {
//        guard let assetCount = mediaPickerInputViewController?.mediaPicker.selectedAssets.count else {
//            return
//        }
//
//        if assetCount == 0 {
//            formatBar.trailingItem = nil
//        } else {
//            insertToolbarItem.setTitle(String(format: Constants.mediaPickerInsertText, NSNumber(value: assetCount)), for: .normal)
//
//            if formatBar.trailingItem != insertToolbarItem {
//                formatBar.trailingItem = insertToolbarItem
//            }
//        }
    }
}
