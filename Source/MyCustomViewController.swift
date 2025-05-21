//
//  MyCustomViewController.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import Foundation
import UIKit

class MyCustomViewController: UIViewController {
    
    private var childNavigationController: UINavigationController!
    
    private var groupCallWithChatViewController: GroupCallWithChatViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
      
        
        let groupCallLabel = UILabel()
        groupCallLabel.text = "Join a group call and chat thread that user is a participant of before joining."
        groupCallLabel.lineBreakMode = .byWordWrapping
        groupCallLabel.numberOfLines = 0
        groupCallLabel.sizeToFit()
        groupCallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let groupCallButton = UIButton()
        groupCallButton.layer.cornerRadius = 10
        groupCallButton.backgroundColor = .systemBlue
        groupCallButton.setTitle("Demo Goup call with chat", for: .normal)
        groupCallButton.addTarget(self, action: #selector(startGroupCallMeetingDemo), for: .touchUpInside)
        groupCallButton.translatesAutoresizingMaskIntoConstraints = false
        
        let margin: CGFloat = 32.0
        let verticalStackView = UIStackView(arrangedSubviews: [
            groupCallLabel,
            groupCallButton])
        verticalStackView.setCustomSpacing(margin / 2, after: groupCallLabel)
        verticalStackView.setCustomSpacing(margin, after: groupCallButton)
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        
        //move it here
        let groupCallWithChatViewController = GroupCallWithChatViewController()
        self.groupCallWithChatViewController = groupCallWithChatViewController
        childNavigationController = UINavigationController(rootViewController: groupCallWithChatViewController)
        addChild(childNavigationController)
        childNavigationController.view.frame = view.bounds
        view.addSubview(childNavigationController.view)
        childNavigationController.didMove(toParent: self)
        
        let margins = view.safeAreaLayoutGuide
        let constraints = [
            verticalStackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: margin),
            verticalStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -margin),
        ]
        NSLayoutConstraint.activate(constraints)

    
    }
    
    @objc private func startGroupCallMeetingDemo(){
     //   let groupCallWithChatViewController = GroupCallWithChatViewController()
    //    self.groupCallWithChatViewController = groupCallWithChatViewController
        //groupCallWithChatViewController.modalPresentationStyle = .popover // works .fullScreen
        // present(groupCallWithChatViewController,animated: true, completion: nil)
        self.groupCallWithChatViewController!.modalPresentationStyle = .fullScreen
        present(self.groupCallWithChatViewController!,animated: true, completion: nil)
    }
}



