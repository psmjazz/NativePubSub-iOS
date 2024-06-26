//
//  MessageManager.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public class MessageManager{
    public static let shared = MessageManager()
    
    private init(){
        mediator = MessageMediatorImpl()
    }
    
    let mediator : MessageMediator
    
    public func register(node: ReceivablePublisher){
        mediator.register(node: node)
    }
}
