//
//  String.swift
//  DotA 2 Heroes
//
//  Created by Ridwan Abdurrasyid on 20/07/23.
//

import Foundation

extension String {
    func removeAllButAlphabet() -> String {
        return self.replacingOccurrences( of:"[^a-z]", with: "", options: .regularExpression)
    }
}
