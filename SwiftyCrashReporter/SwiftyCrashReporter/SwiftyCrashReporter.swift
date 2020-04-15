//
//  SwiftyCrashReporter.swift
//  SwiftyCrashReporter
//
//  Created by Eidinger, Marco on 4/15/20.
//  Copyright © 2020 Eidinger, Marco. All rights reserved.
//

import Foundation
import CrashReporter

public class SwiftyCrashReporter {
    public static let shared = SwiftyCrashReporter()

    private let crashReporter = PLCrashReporter()

    public func initOnStartup() -> Bool {
        return crashReporter.enable()
    }

    public func hasPendingCrashReport() -> Bool {
        return crashReporter.hasPendingCrashReport()
    }

    public func getPendingCrashReport() -> String {
        guard let crashData = try? crashReporter.loadPendingCrashReportDataAndReturnError(), let report = try? PLCrashReport(data: crashData), !report.isKind(of: NSNull.classForCoder()) else {
            return ""
        }

        let crash: NSString = PLCrashReportTextFormatter.stringValue(for: report, with: PLCrashReportTextFormatiOS)! as NSString
        return crash as String
    }

    public func deleteCrashReports() {
        crashReporter.purgePendingCrashReport()
    }

}
