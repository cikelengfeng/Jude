//
//  JSON.swift
//  Jude
//
//  Created by 徐 东 on 2017/2/17.
//  Copyright © 2017年 dx lab. All rights reserved.
//

import Foundation

enum JSON {
    case number
    case string
    case bool
    case array
    case object
    case null
}

let charStream = ANTLRInputStream("{\"hey\":\"jude\"}")
let lexer = JSONLexer(charStream)
let tokenStream = CommonTokenStream(lexer)
let parser = try! JSONParser(tokenStream)
func parse() {
    do {
        try parser.value()
    } catch {
        
    }
}
