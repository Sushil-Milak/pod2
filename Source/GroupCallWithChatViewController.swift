//
//  GroupCallWithChatViewController.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import Foundation
import UIKit
import AzureCommunicationCalling
import AzureCommunicationUICalling
import AzureCommunicationUIChat

class GroupCallWithChatViewController: UIViewController {
    private let displayName = "USER_NAME"
    private let endpoint = "ACS_ENDPOINT"
    private let groupId = "GROUP_ID"

    private let communicationUserId = "USER_ID"
    private var userToken = "USER_ACCESS_TOKEN"
    private var roomId = "roomId"
    private var chat_user_identity = "chat_user_identity"
    private var chat_user_token = "chat_user_token"
    
    private var chatThreadId = "CHAT_THREAD_ID"
    private var video_user_identity = "video_user_identity"
    private var video_user_token = "video_user_token"
    private var chat_csr_token = "chat_csr_token"
    private var chat_csr_identity = "chat_csr_identity"
    
    
    
    private let chat_endPoint = "https://acsicatest.unitedstates.communication.azure.com/"
    
    private var callComposite: CallComposite?
    private var chatAdaptor: ChatAdapter?
    private var chatCompositeViewController: ChatCompositeViewController?
    
    private var startCallButton: UIButton?
    private var endCallButton: UIButton?
    private var connectChatButton: UIButton?
    private var showHideChatButton: UIButton?
    private var chatContainerView: UIView?
    
   
    func getchatThreadId() -> String {
        return UserDefaults.standard.string(forKey: "chatThreadId") ?? "NoValue"
    }
    func getRoomId() -> String {
        return UserDefaults.standard.string(forKey: "roomId") ?? "NoValue"
    }
    
    func getchat_user_identity() -> String {
        return UserDefaults.standard.string(forKey: "chat_user_identity") ?? "NoValue"
    }
    
    func getchat_user_token() -> String {
        return UserDefaults.standard.string(forKey: "chat_user_token") ?? "NoValue"
    }
    
    func getvideo_user_identity() -> String {
        return UserDefaults.standard.string(forKey: "video_user_identity") ?? "NoValue"
    }
    
    func getvideo_user_token() -> String {
        return UserDefaults.standard.string(forKey: "video_user_token") ?? "NoValue"
    }
    
    func getchat_csr_token() -> String {
        return UserDefaults.standard.string(forKey: "chat_csr_token") ?? "NoValue"
    }
    
    func getchat_csr_identity() -> String {
        return UserDefaults.standard.string(forKey: "chat_csr_identity") ?? "NoValue"
    }
    func getdeepLink() -> String {
        return UserDefaults.standard.string(forKey: "deepLink") ?? "NoValue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initControlBar()
    }
    
    @objc private func startCallComposite(){
        startCallButton?.isHidden = true
        endCallButton?.isHidden = false
        
        let callCompositeOptions = CallCompositeOptions(
            enableMultitasking: true,
            enableSystemPictureInPictureWhenMultitasking: true,
            displayName: "V1"
        )
        
        let communicationTokenCredential = try! CommunicationTokenCredential(token: userToken)
        let callComposite = self.callComposite ?? CallComposite(credential: communicationTokenCredential,
                                                                withOptions: callCompositeOptions)
        
        self.callComposite = callComposite
        
        callComposite.events.onDismissed = { [weak self] callState in
            self?.startCallButton?.isHidden = false
            self?.endCallButton?.isHidden = true
        }
        
        let chatCustomButton = CustomButtonViewData (
            id: UUID().uuidString,
            image: UIImage(named: "cbe-44")!,
            title: "Chat") { [weak self] _ in
                self?.callComposite?.isHidden = true
                self?.showChat()
            }
        let callScreenHeaderViewData = CallScreenHeaderViewData(customButtons: [chatCustomButton])
        let localOptions = LocalOptions(callScreenOptions: CallScreenOptions(headerViewData: callScreenHeaderViewData))
        //callComposite.launch(locator: .groupCall(groupId: UUID(uuidString: groupId)!), localOptions: localOptions)
        /*
         DispatchQueue.main.async {
             self.callComposite?.launch(locator: .roomCall(roomId: self.roomId), localOptions: localOptions)
             
             
                  }
         */
       // self.callComposite.launch(locator: .roomCall(roomId: self.roomId), localOptions: localOptions)
        callComposite.launch(locator: .roomCall(roomId: self.roomId), localOptions: localOptions)
    
                                        
                                    
            
       
    }
    
    @objc private func dismissCallComposite(){
        callComposite?.dismiss()
    }
    
    @objc private func connectChat(){
        let communicationIdentifier = CommunicationUserIdentifier(self.chat_user_identity) //communicationUserId)
        guard let communicationTokenCredential = try? CommunicationTokenCredential(token: self.chat_user_token) else {
            return
        }
        
        self.chatAdaptor = ChatAdapter(
            endpoint: self.chat_endPoint,
            identifier: communicationIdentifier,
            credential: communicationTokenCredential,
            threadId: self.chatThreadId,
            displayName: "Bene Chat"
        )
        
        Task {
            @MainActor in
            guard let chatAdapter = self.chatAdaptor else {
                return
            }
            try await chatAdapter.connect()
        }
        self.connectChatButton?.isHidden = true
        self.showHideChatButton?.isHidden = false
    }
    
    @objc private func showHideChat(){
        
        guard let chatAdapter = self.chatAdaptor,
              let chatContainerView = self.chatContainerView else {
            return
        }
        
        if let chatCompositeViewController = self.chatCompositeViewController {
            chatCompositeViewController.willMove(toParent: nil)
            chatCompositeViewController.view.removeFromSuperview()
            chatCompositeViewController.removeFromParent()
            self.chatCompositeViewController = nil
        }else{
            showChat()
        }
        
    }
    
    @objc private func showChat(){
        //check if exist
        guard let chatAdapter = self.chatAdaptor,
              let chatContainerView = self.chatContainerView,
              self.chatCompositeViewController == nil else {
            return
        }
        
        let chatCompositeViewController = ChatCompositeViewController(with: chatAdapter)
        self.addChild(chatCompositeViewController)
        chatContainerView.addSubview(chatCompositeViewController.view)
        
        chatCompositeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        //constraint
        NSLayoutConstraint.activate([
            chatCompositeViewController.view.topAnchor.constraint(equalTo: chatContainerView.topAnchor),
            chatCompositeViewController.view.bottomAnchor.constraint(equalTo: chatContainerView.bottomAnchor),
            chatCompositeViewController.view.leadingAnchor.constraint(equalTo: chatContainerView.leadingAnchor),
            chatCompositeViewController.view.trailingAnchor.constraint(equalTo: chatContainerView.trailingAnchor)
        ])
        
        
        chatCompositeViewController.didMove(toParent: self)
        self.chatCompositeViewController = chatCompositeViewController
    }
    
    private func initControlBar() {
        self.roomId = getRoomId()
        self.chatThreadId = getchatThreadId()
        self.chat_user_identity = getchat_user_identity()
        self.chat_user_token = getchat_user_token()
        self.userToken =  getchat_user_token() //changed to consolidate.
        
        self.video_user_identity = getvideo_user_identity()
        //self.userToken = getvideo_user_token()
        self.video_user_token = getvideo_user_token()
        
        self.chat_csr_identity = getchat_csr_identity()
        self.chat_csr_token = getchat_csr_token()
        

        
        
        let startCallButton = UIButton()
        self.startCallButton = startCallButton
        startCallButton.layer.cornerRadius = 10
        startCallButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        startCallButton.backgroundColor = .systemBlue
        startCallButton.setTitle("Call", for: .normal)
        
        startCallButton.addTarget(self, action: #selector(startCallComposite), for: .touchUpInside)
        startCallButton.translatesAutoresizingMaskIntoConstraints = false
        
        let endCallButton = UIButton(type: .custom)
          self.endCallButton = endCallButton
          endCallButton.layer.cornerRadius = 10
          endCallButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
          endCallButton.backgroundColor = .systemBlue
          endCallButton.setTitle("End Call", for: .normal)
          endCallButton.addTarget(self, action: #selector(dismissCallComposite), for: .touchUpInside)
          endCallButton.translatesAutoresizingMaskIntoConstraints = false
          endCallButton.isHidden = true
        
        let connectChatButton = UIButton(type: .custom)
        self.connectChatButton = connectChatButton
        connectChatButton.layer.cornerRadius = 10
        connectChatButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        connectChatButton.backgroundColor = .systemBlue
        connectChatButton.setTitle("Connect chat", for: .normal)
        connectChatButton.addTarget(self, action: #selector(connectChat), for: .touchUpInside)
        connectChatButton.translatesAutoresizingMaskIntoConstraints = false

        let showHideChatButton = UIButton(type: .custom)
        self.showHideChatButton = showHideChatButton
        showHideChatButton.layer.cornerRadius = 10
        showHideChatButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        showHideChatButton.backgroundColor = .systemBlue
        showHideChatButton.setTitle("Show/Hide chat", for: .normal)
        showHideChatButton.addTarget(self, action: #selector(showHideChat), for: .touchUpInside)
        showHideChatButton.translatesAutoresizingMaskIntoConstraints = false
        showHideChatButton.isHidden = true

        
        let margin: CGFloat = 32.0
        
        let buttonsContainerView = UIView()
        buttonsContainerView.backgroundColor = .clear
        
        let buttonsStackView = UIStackView(arrangedSubviews: [
            startCallButton,
            endCallButton,
            connectChatButton,
            showHideChatButton
        ])
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.spacing = 10
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonsContainerView.addSubview(buttonsStackView)

        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 8),
            buttonsStackView.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: -8),
            buttonsStackView.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor, constant: 16),
        ])

        
        let chatContainerView = UIView()
        self.chatContainerView = chatContainerView
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            buttonsContainerView,
            chatContainerView
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(verticalStackView)
        let margins = view.safeAreaLayoutGuide
        let constraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: margins.topAnchor, constant: margin),
            verticalStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -margin)
        ]
        NSLayoutConstraint.activate(constraints)

        
        
    }
}
