//
//  String+Extensions.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import Foundation

extension String {

    func replacingLastOccurrenceOfString(_ searchString: String, with replacementString: String, caseInsensitive: Bool = true) -> String {

        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }

        if let range = self.range(of: searchString,
                                  options: options,
                                  range: nil,
                                  locale: nil) {

            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
}
