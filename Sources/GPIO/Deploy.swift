//
//  Deploy.swift
//
//
//  Created by Jake Foster on 11/2/20.
//

import Foundation

#if os(OSX) || os(iOS)
func shell(_ command: String) {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"

    let outputHandler = pipe.fileHandleForReading
    outputHandler.waitForDataInBackgroundAndNotify()

    let notificationCenter = NotificationCenter.default
    let dataNotificationName = NSNotification.Name.NSFileHandleDataAvailable

    var dataObserver: NSObjectProtocol?
    dataObserver = notificationCenter.addObserver(forName: dataNotificationName, object: outputHandler, queue: nil) {  notification in
        let data = outputHandler.availableData
        guard data.count > 0 else {
            notificationCenter.removeObserver(dataObserver!)
            return
        }
        if let line = String(data: data, encoding: .utf8) {
            print(line, terminator: "")
        }
        outputHandler.waitForDataInBackgroundAndNotify()
    }

    task.launch()
    task.waitUntilExit()
}
    	
func deployAndExit() {
    print("================================")
    print("syncing code to the Raspberry Pi")
    print("================================")
    shell(#"rsync -avz "$HOME/workspace/GPIO/Sources/GPIO/" pi@192.168.1.55:workspace/first-swift/Sources/first-swift/"#)

    print("=============")
    print("building code")
    print("=============")
    shell("ssh pi@192.168.1.55 'cd workspace/first-swift && swift build'")

    print("============")
    print("running code")
    print("============")
    shell("ssh -t pi@192.168.1.55 'killall -9 first-swift ; cd workspace/first-swift && swift run --skip-build'")

    exit(0)
}
#endif
