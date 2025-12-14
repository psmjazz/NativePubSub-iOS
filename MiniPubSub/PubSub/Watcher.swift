//
//  Watcher.swift
//  MiniPubSub
//
//  Created by sangmin park on 7/27/24.
//

import Foundation

@objcMembers
public class Watcher: Node{
    
    private static let watcherKey = "Key_Watcher_Reserved"
    
    private let target: SdkType
    
    public init(target: SdkType = .native) {
        self.target = target
    }
    
    public func watch(delegate: @escaping ReceiveDelegate){
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: self.id, key: Watcher.watcherKey, target: self.target, delegate: delegate))
    }

    public func unwatch(){
        MessageManager.shared.mediator.unregister(id: self.id, key: Watcher.watcherKey)
    }

}
