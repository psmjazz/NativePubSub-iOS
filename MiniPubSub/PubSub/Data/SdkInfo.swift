//
//  SdkInfo.swift
//  MiniPubSub
//
//  Created by sangmin park on 2/11/25.
//

import Foundation

@objc
public enum SdkType : Int, Codable{
    case native     = 0
    case game       = 1
}

public class IdConuter{
    private var idSource : Int = SdkType.native.rawValue
    private var lock = os_unfair_lock_s()
    public func getNext() -> Int{
        os_unfair_lock_lock(&lock)
        let id = idSource
        idSource += 2
        os_unfair_lock_unlock(&lock)
        return id
    }
}
