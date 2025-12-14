//
//  Publisher.swift
//  MiniPubSub
//
//  Created by sangmin park on 8/31/24.
//

import Foundation

@objcMembers
public class Publisher : Node{
    static let idCounter = IdConuter()
    
    public func publish(topic: Topic){
        publish(topic: topic, payload: Payload(json: "{}"))
    }
    
    public func publish(topic: Topic, replyCallback: @escaping ReceiveDelegate){
        publish(topic: topic, payload: Payload(json: "{}"), replyCallback: replyCallback)
    }
        
    public func publish(topic: Topic, payload: Payload){
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, topic: topic, replyTopic: Topic.default, payload: payload)
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    public func publish(topic: Topic, payload: Payload, replyCallback: @escaping ReceiveDelegate){
        let replyKey = "\(topic.key)_id\(Publisher.idCounter.getNext())"
        let replyTopic = Topic(key: replyKey, target: SdkType.native)
        
        let receiver = Receiver(nodeId: -1, key: replyKey, target: SdkType.native, delegate: replyCallback)
        MessageManager.shared.mediator.registerInstantReceiver(receiver: receiver)
        
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, topic: topic, replyTopic: replyTopic, payload: payload)
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    public func reply(received: MessageInfo, payload: Payload){
        self.publish(topic: received.replyTopic, payload: payload)
    }
    
    public func sendSync(topic: Topic, payload: Payload) -> Payload{
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, topic: topic, replyTopic: Topic.default, payload: payload)
        return MessageManager.shared.mediator.sendSync(message: message)
    }
}
