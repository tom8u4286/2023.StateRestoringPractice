//
//  ViewController.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - property 變數常數
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.showBorder()
        
        return stack
    }()
    
    let action1 = UIAction { _ in
        print("action1")
    }
    lazy var button1 = createButton(title: "Page1", action: action1)
    
    
    let action2 = UIAction { _ in
        print("action2")
    }
    lazy var button2 = createButton(title: "Page2", action: action2)
    
    // MARK: - lifecycle 生命週期

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .devYellow
        
        setupViews()
        
    }
    
    
    // MARK: - private functions
    
    private func setupViews(){
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.heightAnchor.constraint(equalToConstant: 100),
            vStack.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createButton(title: String, action: UIAction) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.addAction(action, for: .touchUpInside)
        
        return btn
        
    }


}

