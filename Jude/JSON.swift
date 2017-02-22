//
//  JSON.swift
//  Jude
//
//  Created by 徐 东 on 2017/2/17.
//  Copyright © 2017年 dx lab. All rights reserved.
//

import Foundation

public enum JSONObjectType {
    case number
    case string
    case array
    case dict
    case literalFalse
    case literalTrue
    case literalNull
}

public struct JSONObject {
    public private(set) var raw: String
    public let type: JSONObjectType
    
    public init(raw: String, type: JSONObjectType) {
        self.raw = raw
        self.type = type
    }
}

public extension JSONObject {
    
    func int64(key: String, defaultValue: Int64? = nil) -> Int64? {
        guard case .dict = type else {
            return defaultValue
        }
        guard case .number = type else {
            return defaultValue
        }
        return defaultValue
    }
    func uint64(key: String, defaultValue: UInt64? = nil) -> UInt64? {
        return defaultValue
    }
    func int32(key: String, defaultValue: Int32? = nil) -> Int32? {
        return defaultValue
    }
    func uint32(key: String, defaultValue: UInt32? = nil) -> UInt32? {
        return defaultValue
    }
    func double(key: String, defaultValue: Double? = nil) -> Double? {
        return defaultValue
    }
    func string(key: String, defaultValue: String? = nil) -> String? {
        return defaultValue
    }
    func bool(key: String) -> Bool {
        return false
    }
    func isNull(key: String) -> Bool {
        return false
    }
    func array(key: String, defaultValue: [JSONObject]? = nil) -> [JSONObject]? {
        return defaultValue
    }
    func dictionary(key: String, defaultValue: [String: JSONObject]? = nil) -> [String: JSONObject]? {
        return defaultValue
    }
    
    func asInt64(defaultValue: Int64? = nil) -> Int64? {
        guard case .number = type else {
            return defaultValue
        }
        return defaultValue
    }
    func asUInt64(defaultValue: UInt64? = nil) -> UInt64? {
        return defaultValue
    }
    func asInt32(defaultValue: Int32? = nil) -> Int32? {
        return defaultValue
    }
    func asUInt32(defaultValue: UInt32? = nil) -> UInt32? {
        return defaultValue
    }
    func asDouble(defaultValue: Double? = nil) -> Double? {
        return defaultValue
    }
    func asString(defaultValue: String? = nil) -> String? {
        return defaultValue
    }
    func asBool() -> Bool {
        return false
    }
    func isNull() -> Bool {
        return false
    }
    func asArray(defaultValue: [JSONObject]? = nil) -> [JSONObject]? {
        return defaultValue
    }
    func asDictionary(defaultValue: [String: JSONObject]? = nil) -> [String: JSONObject]? {
        return defaultValue
    }
    
    func int64(index: Int, defaultValue: Int64? = nil) -> Int64? {
        return defaultValue
    }
    func uint64(index: Int, defaultValue: UInt64? = nil) -> UInt64? {
        return defaultValue
    }
    func int32(index: Int, defaultValue: Int32? = nil) -> Int32? {
        return defaultValue
    }
    func uint32(index: Int, defaultValue: UInt32? = nil) -> UInt32? {
        return defaultValue
    }
    func double(index: Int, defaultValue: Double? = nil) -> Double? {
        return defaultValue
    }
    func string(index: Int, defaultValue: String? = nil) -> String? {
        return defaultValue
    }
    func bool(index: Int) -> Bool {
        return false
    }
    func isNull(index: Int) -> Bool {
        return false
    }
    func array(index: Int, defaultValue: [JSONObject]? = nil) -> [JSONObject]? {
        return defaultValue
    }
    func dictionary(index: Int, defaultValue: [String: JSONObject]? = nil) -> [String: JSONObject]? {
        return defaultValue
    }
}

public protocol JSONBuilderContext {
    func append(json: JSONObject)
}

public class JSONObjectBuilder: JSONBuilderContext {
    
    public var jsonObject: JSONObject?
    
    public init() {
        jsonObject = nil
    }
    
    public func beginDict() -> JSONDictBuilder<JSONObjectBuilder> {
        jsonObject = nil
        return JSONDictBuilder(context: self)
    }
    
    public func beginArray() -> JSONArrayBuilder<JSONObjectBuilder> {
        jsonObject = nil
        return JSONArrayBuilder(context: self)
    }
    
    public func append(json: JSONObject) {
        jsonObject = json
    }
}

public class JSONDictBuilder<Context: JSONBuilderContext>: JSONBuilderContext {
    public var context: Context
    private var store: [String: JSONObject]
    private var pendingKeyStack: [String]
    
    public init(context: Context) {
        self.context = context
        store = [:]
        pendingKeyStack = []
    }
    
    public func append(json: JSONObject) {
        let key = pendingKeyStack.removeLast()
        put(key: key, value: json)
    }
    
    public func end() -> Context {
        let content = store.map { (kv) -> String in
            return "\"\(kv.key)\":\(kv.value.raw)"
            }.joined(separator: ",")
        let raw = "{\(content)}"
        let jsonObj = JSONObject(raw: raw, type: .dict)
        context.append(json: jsonObj)
        return context
    }
    
    public func put(key: String, value: JSONObject) -> JSONDictBuilder<Context> {
        store[key] = value
        return self
    }
    
    public func put(entries: [String: JSONObject]) -> JSONDictBuilder<Context> {
        store += entries
        return self
    }
    
    public func beginArray(key: String) -> JSONArrayBuilder<JSONDictBuilder<Context>> {
        pendingKeyStack.append(key)
        return JSONArrayBuilder(context: self)
    }
    
    public func beginDict(key: String) -> JSONDictBuilder1<JSONDictBuilder<Context>> {
        pendingKeyStack.append(key)
        return JSONDictBuilder1(context: self)
    }
}

public class JSONDictBuilder1<Context: JSONBuilderContext>: JSONBuilderContext {
    public var context: Context
    private var store: [String: JSONObject]
    private var pendingKeyStack: [String]
    
    public init(context: Context) {
        self.context = context
        store = [:]
        pendingKeyStack = []
    }
    
    public func append(json: JSONObject) {
        let key = pendingKeyStack.removeLast()
        put(key: key, value: json)
    }
    
    public func end() -> Context {
        let content = store.map { (kv) -> String in
            return "\"\(kv.key)\":\(kv.value.raw)"
        }.joined(separator: ",")
        let raw = "{\(content)}"
        let jsonObj = JSONObject(raw: raw, type: .dict)
        context.append(json: jsonObj)
        return context
    }
    
    public func put(key: String, value: JSONObject) -> JSONDictBuilder1<Context> {
        store[key] = value
        return self
    }
    
    public func put(entries: [String: JSONObject]) -> JSONDictBuilder1<Context> {
        store += entries
        return self
    }
    
    public func beginArray(key: String) -> JSONArrayBuilder<JSONDictBuilder1<Context>> {
        pendingKeyStack.append(key)
        return JSONArrayBuilder(context: self)
    }
    
    public func beginDict(key: String) -> JSONDictBuilder<JSONDictBuilder1<Context>> {
        pendingKeyStack.append(key)
        return JSONDictBuilder(context: self)
    }
}

public class JSONArrayBuilder<Context: JSONBuilderContext>: JSONBuilderContext {
    public var context: Context
    private var store: [JSONObject]
    
    public init(context: Context) {
        self.context = context
        store = []
    }
    
    public func append(json: JSONObject) {
        store.append(json)
    }
    
    public func end() -> Context {
        let content = store.map({ (json) -> String in
            return json.raw
        }).joined(separator: ",")
        let raw = "[\(content)]"
        let jsonObj = JSONObject(raw: raw, type: .array)
        context.append(json: jsonObj)
        return context
    }
    
    public func append(value: JSONObject) -> JSONArrayBuilder<Context> {
        store.append(value)
        return self
    }
    
    public func append(value: [JSONObject]) -> JSONArrayBuilder<Context> {
        store += value
        return self
    }
    
    public func beginDict() -> JSONDictBuilder<JSONArrayBuilder<Context>> {
        return JSONDictBuilder(context: self)
    }
    
    public func beginArray() -> JSONArrayBuilder1<JSONArrayBuilder<Context>> {
        return JSONArrayBuilder1(context: self)
    }
}

public class JSONArrayBuilder1<Context: JSONBuilderContext>: JSONBuilderContext {
    public var context: Context
    private var store: [JSONObject]
    
    public init(context: Context) {
        self.context = context
        store = []
    }
    
    public func append(json: JSONObject) {
        store.append(json)
    }
    
    public func end() -> Context {
        let content = store.map({ (json) -> String in
            return json.raw
        }).joined(separator: ",")
        let raw = "[\(content)]"
        let jsonObj = JSONObject(raw: raw, type: .array)
        context.append(json: jsonObj)
        return context
    }
    
    public func append(value: JSONObject) -> JSONArrayBuilder1<Context> {
        store.append(value)
        return self
    }
    
    public func append(value: [JSONObject]) -> JSONArrayBuilder1<Context> {
        store += value
        return self
    }
    
    public func beginDict() -> JSONDictBuilder<JSONArrayBuilder1<Context>> {
        return JSONDictBuilder(context: self)
    }
    
    public func beginArray() -> JSONArrayBuilder<JSONArrayBuilder1<Context>> {
        return JSONArrayBuilder(context: self)
    }
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
