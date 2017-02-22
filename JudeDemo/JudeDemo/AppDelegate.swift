//
//  AppDelegate.swift
//  JudeDemo
//
//  Created by 徐 东 on 2017/2/22.
//  Copyright © 2017年 dx lab. All rights reserved.
//

import UIKit
import Jude

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        // Override point for customization after application launch.
//        self.window!.backgroundColor = UIColor.whiteColor()
//        self.window!.makeKeyAndVisible()
        
        let test = JSONObject(raw: "\"1\"", type: .string)
        let jsonBuilder = JSONObjectBuilder()
            .beginDict()
            .put(key: "foo", value: test)
            .put(key: "bar", value: test)
            .beginDict(key: "foz")
                .put(key: "inner", value: test)
                .end()
            .beginArray(key: "baz")
                .append(value: test)
                .append(value: [test, test])
                .end()
            .end()
        let json = jsonBuilder.jsonObject!.raw
        debugPrint("json : ", json)
        
        
        let charStream = ANTLRInputStream(json)
        let lexer = JSONLexer(charStream)
        let tokenStream = CommonTokenStream(lexer)
        let parser = try! JSONParser(tokenStream)
        do {
            let jv = try parser.object()
            debugPrint("json value: ", jv.children)
        } catch {
            
        }

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

