//
//  Message.swift
//  MiniPubSub
//
//  Created by sangmin park on 2/10/25.
//

import Foundation

@objcMembers
public class NodeInfo : NSObject, Codable{
    let messageOwnerId: Int
    let publisherId: Int
    
    init(messageOwnerId: Int, publisherId: Int) {
        self.messageOwnerId = messageOwnerId
        self.publisherId = publisherId
    }
}

@objcMembers
public class MessageInfo : NSObject, Codable{
    let nodeInfo: NodeInfo
    let topic: Topic
    let replyTopic: Topic
    
    init(nodeInfo: NodeInfo, topic: Topic, replyTopic: Topic) {
        self.nodeInfo = nodeInfo
        self.topic = topic
        self.replyTopic = replyTopic
    }
}

@objcMembers
public class Message : NSObject{
    public let info : MessageInfo
    public let payload : Payload
    
    public var key: String{
        return self.info.topic.key
    }
    
    init(info: MessageInfo, payload: Payload) {
        self.info = info
        self.payload = payload
    }
    
    init(nodeInfo: NodeInfo, topic: Topic, replyTopic: Topic, payload: Payload){
        self.info = MessageInfo(nodeInfo: nodeInfo, topic: topic, replyTopic: replyTopic)
        self.payload = payload
    }
    
    public func data<T: Codable>() -> T?{
        return payload.data()
    }
    
}
