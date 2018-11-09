//
//  AppChainNetwork.swift
//  Neuron
//
//  Created by XiaoLu on 2018/7/31.
//  Copyright © 2018年 cryptape. All rights reserved.
//

import Foundation
import AppChain

struct AppChainNetwork {
    private static let defaultNode = "http://121.196.200.225:1337"

    static func appChain(url: URL = URL(string: defaultNode)!) -> AppChain {
        return AppChain(provider: HTTPProvider(url)!)
    }
}