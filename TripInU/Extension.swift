//
//  Extension.swift
//  TripInU
//
//  Created by 박다미 on 2023/05/10.
//

import Foundation
//이메일 형식
extension String {
    func isValidEmailFormat() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
