//
//  Atomic.swift
//
//
//  Created by Anton Pomozov on 24.07.2021.
//

import Foundation

public protocol BaseErrorCode: RawRepresentable where RawValue == Int {
    var localizedDescription: String { get }
}

open class BaseError<ErrorCode: BaseErrorCode>: NSError {
    public static var domain: String { String(describing: type(of: self)) }

    public let errorCode: ErrorCode
    public var errorCodeName: String { String(describing: errorCode) }
    public var underlyingError: NSError? { userInfo[NSUnderlyingErrorKey] as? NSError }
    public var shortErrorIdentifier: String { makeShortErrorIdentifier(from: self) }
    public var erroCodePrefix: String { NSLocalizedString("BaseError.CodePrefix", comment: "The text before a error code at the bottom of an error pop-up") }

    open var domainShortName: String { "BE" }

    public required init(
        code: ErrorCode,
        localizedDescription: String? = nil,
        localizedFailureReason: String? = nil,
        localizedRecoverySuggestion: String? = nil,
        debugDescription: String? = nil,
        underlying: Error? = nil
    ) {
        self.errorCode = code

        let description = [
            NSLocalizedDescriptionKey: (localizedDescription ?? code.localizedDescription) as Any
        ]
        let userInfo = [
            NSUnderlyingErrorKey: underlying as Any,
            NSLocalizedFailureReasonErrorKey: localizedFailureReason as Any,
            NSLocalizedRecoverySuggestionErrorKey: localizedRecoverySuggestion as Any,
            NSDebugDescriptionErrorKey: debugDescription as Any
        ]
        super.init(
            domain: Self.domain,
            code: code.rawValue,
            userInfo: userInfo.merging(description, uniquingKeysWith: { _, source in source })
        )
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseError: ErrorIdentifiable {
    var errorCodePrintable: Int { errorCode.rawValue }
}

private extension BaseError {
    func makeShortErrorIdentifier(from error: NSError?) -> String {
        guard let error = error else { return "" }
        guard let identifiable = error as? ErrorIdentifiable else { return "" }
        let lastErrorIdentifier = makeShortErrorIdentifier(from: error.userInfo[NSUnderlyingErrorKey] as? NSError)

        let errorIdentifier = "\(identifiable.domainShortName)\(identifiable.errorCodePrintable)"
        return lastErrorIdentifier.isEmpty ? errorIdentifier : "\(errorIdentifier)-\(lastErrorIdentifier)"
    }
}

private protocol ErrorIdentifiable: AnyObject {
    var domainShortName: String { get }
    var errorCodePrintable: Int { get }
}
