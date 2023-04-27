//
//  ViewController.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - property 變數常數
    
    var product: Product!
    
    
    var mytext = ""
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    
    lazy var saveBtn = createButton(title: "Save")
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 5
        field.backgroundColor = .white3
        field.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return field
    }()
    
    // MARK: - lifecycle 生命週期

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK: - private functions
    
    private func setupViews(){
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.heightAnchor.constraint(equalToConstant: 150),
            vStack.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        vStack.addArrangedSubview(textField)
        vStack.addArrangedSubview(saveBtn)
    }
    
    // 產生一個Button
    private func createButton(title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        
        let action = UIAction { _ in
            self.updateUserActivity()
        }
        btn.addAction(action, for: .touchUpInside)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }
    
    func updateUserActivity(){
//        var currentUserActivity = view.window?.windowScene?.userActivity
//
//        if currentUserActivity == nil {
//            /** Note: You must include the activityType string below in your Info.plist file under the `NSUserActivityTypes` array.
//                More info: https://developer.apple.com/documentation/foundation/nsuseractivity
//            */
////            currentUserActivity = NSUserActivity(activityType: SceneDelegate.MainSceneActivityType())
//            currentUserActivity = NSUserActivity(activityType: "com.gmail.-023-StateRestoringPractice")
//        }
//
//        print("ViewController: currentUserActivity:\(currentUserActivity)")
//
//        currentUserActivity?.addUserInfoEntries(from: ["testKey": "12345"])
        
        let userActivity = NSUserActivity(activityType: "com.gmail.-023-StateRestoringPractice")
        userActivity.title = "Main scene restoration activity"
        
//        view.window?.windowScene?.userActivity = userActivity
        
        print("view.window?.windowScene?.userActivity:\(view.window?.windowScene?.userActivity)")
    }
    
    @objc private func textFieldDidChanged(_ textField: UITextField){
        if let newText = textField.text {
            mytext = newText
        }
    }
    
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        print("🇨🇦")

        // 以DetailParentViewController.restoreProductKey，儲存當前的product的identifier。
        coder.encode(mytext, forKey: "testKey")
        
    }
    
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        print("🐞 decodeRestorableState")

        guard let decodedText = coder.decodeObject(forKey: "testKey") as? String else {
            fatalError("A product did not exist in the restore. In your app, handle this gracefully.")
        }
        
        print("decodedText: \(decodedText)")
//        product = DataModelManager.sharedInstance.product(fromIdentifier: decodedProductIdentifier)
        
//        restoredSelectedTab = coder.decodeInteger(forKey: DetailParentViewController.restoreSelectedTabKey)
        
        

        // Note: The child view controllers inside the tab bar and the EditViewController each restore themselves.
    }

}

