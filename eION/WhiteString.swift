//
//  WhiteString.swift
//  eION
//
//  Created by Jorge Mora Campoy on 29/12/21.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return String(self.replace(string: ",", replacement: ".").prefix(9))
    }
  }


