//
//  Node.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public class Node : NSObject{
    private static let idCounter = IdConuter()
    let id: Int = idCounter.getNext()
}

