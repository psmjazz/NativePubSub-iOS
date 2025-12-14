//
//  MessageManager.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

@objcMembers
public class MessageManager : NSObject{
    public static let shared = MessageManager()
    
    private override init(){
        mediator = MessageMediatorImpl()
    }
    
    let mediator : MessageMediator

}
