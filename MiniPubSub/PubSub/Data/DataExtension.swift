//
//  DataExtension.swift
//  MiniPubSub
//
//  Created by sangmin park on 12/14/25.
//

import Foundation

public extension Payload{
    convenience init(dict: NSDictionary){
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) else {
            self.init(json: "{}")
            return
        }
        self.init(json: String(data: jsonData, encoding: .utf8) ?? "{}")
    }
    
    convenience init(nsObject: NSObject){
        let dict = NSMutableDictionary()
        
        var count: UInt32 = 0
        let properties = class_copyPropertyList(nsObject.classForCoder, &count)
        
        for i in 0..<Int(count){
            let property = properties?[i]
            let key = String(cString: property_getName(property!))
            dict[key] = nsObject.value(forKey: key)
        }
        self.init(dict: dict)
    }
    
    func toNSDictionary() -> NSDictionary {
        guard let jsonData = json.data(using: .utf8) else {
            return NSDictionary()
        }
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData) as? NSDictionary else {
            return NSDictionary()
        }
        return dict
    }
}

public extension Message{
    func data() -> NSDictionary{
        return payload.toNSDictionary()
    }
}
