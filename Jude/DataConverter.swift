//
//  DataConverter.swift
//  Jude
//
//  Created by 徐 东 on 2017/2/17.
//  Copyright © 2017年 dx lab. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case invalidJSON
}

extension Data {
    func toJSONString() throws -> String {
        let encodeFlag = self[0..<4]
        switch encodeFlag {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
    }
}
