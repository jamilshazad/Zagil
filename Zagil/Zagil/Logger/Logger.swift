//
//  Logger.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import CocoaLumberjack

class Logger: NSObject {
    
    // MARK: - Class Properties
    
    public static var shared: Logger = Logger()
    
    // MARK: - Initialization Methods
    
    private override init() {
        super.init()
        
        // Adding OSLogger to show Logs on App Console
        DDLog.add(DDOSLogger.sharedInstance)
        
        // Adding TTYLogge to show Logs on XCode Console
        DDLog.add(DDTTYLogger.sharedInstance!)
        
        // Adding FileLogger to save Logs on disk
        let fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    
    // MARK: - Public Methods
    
    func log(message: String, type: LogType) {
        switch type {
        case .verbose: DDLogVerbose(message)
        case .debug: DDLogDebug(message)
        case .info: DDLogInfo(message)
        case .warn: DDLogWarn(message)
        case .error: DDLogError(message)
        }
    }
    
}

// MARK: - Log Types

enum LogType {
    case verbose
    case debug
    case info
    case warn
    case error
}
