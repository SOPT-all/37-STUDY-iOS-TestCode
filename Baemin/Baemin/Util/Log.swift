//
//  Log.swift
//  Domain
//
//  Created by 김호성 on 2025.06.28.
//

import Foundation
import os

public final class Log {
    
    private static let subsystem: String = Bundle.main.bundleIdentifier ?? "com.ccl.collaborativecomputinglab"
    private static let logger: Logger = Logger(subsystem: subsystem, category: "Log")
    
    private static let enabled: Bool = true
    
    private init() { }
    
    public enum OutputMethod {
        public typealias Closure = (_ object: Any?) -> Void
        
        case oslog
        case nslog
        case print
        case custom(Closure)
    }
    
    public class func d(_ object: Any?, method: OutputMethod = .oslog, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        log(object, level: .debug, method: method, filename: filename, line: line, funcName: funcName)
        #endif
    }
    
    public class func i(_ object: Any?, method: OutputMethod = .oslog, filename: String = #file, line: Int = #line, funcName: String = #function) {
        log(object, level: .info, method: method, filename: filename, line: line, funcName: funcName)
    }
    
    public class func n(_ object: Any?, method: OutputMethod = .oslog, filename: String = #file, line: Int = #line, funcName: String = #function) {
        log(object, level: .notice, method: method, filename: filename, line: line, funcName: funcName)
    }
    
    public class func e(_ object: Any?, method: OutputMethod = .oslog, filename: String = #file, line: Int = #line, funcName: String = #function) {
        log(object, level: .error, method: method, filename: filename, line: line, funcName: funcName)
    }
    
    public class func f(_ object: Any?, method: OutputMethod = .oslog, filename: String = #file, line: Int = #line, funcName: String = #function) {
        log(object, level: .fault, method: method, filename: filename, line: line, funcName: funcName)
    }
    
    private enum Level: String {
        case debug  = "DEBUG"
        case info   = "INFO"
        case notice = "NOTICE"
        case error  = "ERROR"
        case fault  = "FAULT"
        
        var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .notice:
                return .default
            case .error:
                return .error
            case .fault:
                return .fault
            }
        }
    }
    
    private class func log(_ object: Any?, level: Level, method: OutputMethod, filename: String, line: Int, funcName: String) {
        guard enabled else { return }
        let object: Any = object ?? "nil"
        let message: String = "\(dateFormatter.string(from: Date())) [\(level.rawValue)] [\(getThreadName())] [\(getFileName(filename)):\(line)] \(funcName) : \(object)"
        switch method {
        case .oslog:
            logger.log(level: level.osLogType, "\(message)")
        case .nslog:
            NSLog(message)
        case .print:
            print(message)
        case .custom(let closure):
            closure(object)
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter
    }()
    
    private class func getFileName(_ file: String) -> String {
        return file.components(separatedBy: "/").last ?? file
    }
    
    private class func getThreadName() -> String {
        if Thread.current.isMainThread {
            return "Main"
        } else {
            // <NSThread: 0x600001709040>{number = 6, name = (null)}
            let threadNumber = Thread.current.description.split(separator: ",").first!.split(separator: "=").last!.trimmingCharacters(in: .whitespaces)
            return "\(threadNumber)"
        }
    }
}
