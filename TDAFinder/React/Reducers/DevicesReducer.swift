//
//  DevicesReducer.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift

func devicesReducer(action: Action, state: DevicesState?) -> DevicesState {

    var state = state ?? DevicesState()

    switch action {

    case let action as SearchAction:
        state.searchString = action.searchString

    default:
        break
    }

    return state
}
