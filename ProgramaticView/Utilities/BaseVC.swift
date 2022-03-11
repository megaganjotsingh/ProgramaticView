//
//  BaseVC.swift
//  ProgramaticView
//
//  Created by Admin on 20/01/22.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    /// Properties
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    var setNavigationBarHidden = false {
        didSet {
            navigationController?.setNavigationBarHidden(setNavigationBarHidden, animated: true)
            navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    var hideBackButtonImage = false {
        didSet {
            navigationController?.navigationBar.backIndicatorImage = hideBackButtonImage ? UIImage() :  ImageAssets.backIcon.image
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = hideBackButtonImage ? UIImage() : ImageAssets.backIcon.image
        }
    }
    
    var shouldRemoveShadow = false {
        didSet {
            navigationController?.navigationBar.setValue(shouldRemoveShadow, forKey: "hidesShadow")
        }
    }
    
    var setTransParent = false{
        didSet{
            if setTransParent{
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.isTranslucent = true
                navigationController?.view.backgroundColor = .clear
            }else{
                navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor.myAppBackground), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.isTranslucent = true
                navigationController?.view.backgroundColor = UIColor.myAppBackground
            }
        }
    }

//    private let rightBarButtonSubject = PublishSubject<UIBarButtonItem>()
//    private let leftBarButtonSubject = PublishSubject<UIBarButtonItem>()
}

extension BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backIndicatorImage = ImageAssets.backIcon.image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = ImageAssets.backIcon.image
        navigationController?.navigationBar.tintColor = UIColor.myAppBlue
        navigationItem.backBarButtonItem = UIBarButtonItem(title:" ", style:.plain, target: nil, action: nil)
        setTransParent = true
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTransParent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
    }
}

// MARK: - Setup Functions
extension BaseVC {
    
    @objc func initialSetup() {
        //TODO:- Initial setup for the class, is called in view did load
//        setUpLayoutMargins()
    }
    
    func setUpLayoutMargins() {
        if self.tabBarController != nil {
            let layoutMargins = self.additionalSafeAreaInsets
            self.additionalSafeAreaInsets = UIEdgeInsets(top: layoutMargins.top, left: layoutMargins.left, bottom: 70, right: layoutMargins.right)
        }
    }

//    @discardableResult
//    func setRightBarButton(image : UIImage? = nil, text : String? = nil, customView : UIView? = nil) -> Observable<UIBarButtonItem> {
//        var buttonItem : UIBarButtonItem!
//
//        if let image = image{
//            buttonItem  = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
//        }
//
//        if let text = text {
//            buttonItem = UIBarButtonItem(title: text, style: .plain, target: nil, action: nil)
//            buttonItem.tintColor = EFColor.Assets.EFText_BlackD_Gray.color
//        }
//
//        if let view = customView{
//            buttonItem = UIBarButtonItem(customView: view)
//        }
//
//
//        buttonItem.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] (_) in
//                guard let `self` = self else { return }
//                self.rightBarButtonSubject.onNext(buttonItem)
//            }).disposed(by: rx.disposeBag)
//
//        navigationItem.rightBarButtonItem = buttonItem
//        return rightBarButtonSubject.asObserver()
//    }
    
//    @discardableResult
//    func setLeftBarButton(with image : UIImage? = nil, text : String? = nil, customView : UIView? = nil) -> Observable<UIBarButtonItem>{
//        var buttonItem : UIBarButtonItem!
//
//        if let image = image{
//            buttonItem  = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
//        }
//
//        if let text = text {
//            buttonItem = UIBarButtonItem(title: text, style: .plain, target: nil, action: nil)
//        }
//
//        if let view = customView{
//            buttonItem = UIBarButtonItem(customView: view)
//        }
//
//        buttonItem.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] (_) in
//                guard let `self` = self else { return }
//                self.leftBarButtonSubject.onNext(buttonItem)
//            }).disposed(by: rx.disposeBag)
//
//        navigationItem.leftBarButtonItem = buttonItem
//        return leftBarButtonSubject.asObserver()
//    }
    
    func setNavBarTitle(titleKey: StringConstants? = nil, title: String? = nil) {
        self.navigationItem.title = titleKey?.value ?? title
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.myAppBlue,
            .font: UIFont.myAppSubHeading
        ]
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.myAppBlue,
            .font: UIFont.myAppSubHeading
        ]
    }
    
    func showAlert(
        with title: StringConstants? = .appName,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        cancelTitle: StringConstants? = .cancel,
        cancelAction: ((UIAlertAction) -> Void)? = nil,
        otherActions: [StringConstants: ((UIAlertAction) -> Void)]? = nil
    ) {
        let alert = UIAlertController(title: title?.value, message: "", preferredStyle: style)
        let attributedMessage = NSAttributedString(string: message ?? "", attributes: [
            .foregroundColor: UIColor.myAppBlue,
            .font: UIFont.myAppSubHeading
        ])
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        if otherActions != nil {
            for key in otherActions!.keys {
                let action = UIAlertAction(title: key.value, style: .default, handler: otherActions![key])
                alert.addAction(action)
            }
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle?.value, style: .default, handler: cancelAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
