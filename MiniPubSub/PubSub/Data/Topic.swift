//
//  Topic.swift
//  MiniPubSub
//
//  Created by sangmin park on 3/23/25.
//

import Foundation


@objcMembers
public class Topic: NSObject, Codable{
    public let key: String
    public let target: SdkType
    
    static let `default` = Topic(key: "", target: SdkType.native)
    
    public init(key: String, target: SdkType) {
        self.key = key
        self.target = target
    }
}

