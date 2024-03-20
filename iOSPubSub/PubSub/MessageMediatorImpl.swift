//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private var idFilter : [Int32 : ReceivablePublisher]
    
    init(){
        idFilter = [:]
    }
    
    func register(node: ReceivablePublisher) {
        idFilter[node.id] = node
    }
    
    func publish(envelope: Envelope, tag: Tag){
        if(envelope.hasReceiverID){
            let receiver = idFilter[envelope.receiverID]
            if(receiver != nil)
            {
                let channel = ChannelConnection(envelope, receiver!.id, tag)
                receiver!.onReceive(channel)
            }
            else
            {
                self.broadcast(envelope, tag)
            }
        }
        else{
            self.broadcast(envelope, tag)
        }
    }
    
    private func broadcast(_ envelope: Envelope, _ tag: Tag){
        idFilter.values.filter{node in
            node.matchTag(tag: tag) && node.id != envelope.senderID
        }.forEach { node in
            let channel = ChannelConnection(envelope, node.id, tag)
            node.onReceive(channel)
        }
    }
}
