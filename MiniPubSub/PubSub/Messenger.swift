//
//  Messenger.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

@objcMembers
public final class Messenger : Publisher{
    
    private let target: SdkType
    
    public init(target: SdkType = .native) {
        self.target = target
    }

    public func subscribe(key: String, delegate: @escaping ReceiveDelegate) {
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: self.id, key: key, target: self.target, delegate: delegate))
    }
    
    public func unsubscribe(key: String) {
        MessageManager.shared.mediator.unregister(id: self.id, key: key)
    }
    
    public func handle(key: String, delegate: @escaping HandleDelegate) {
        let handler = Handler(nodeId: self.id, key: key, target: target, delegate: delegate)
        MessageManager.shared.mediator.handle(key: key, handler: handler)
    }
}
