//
//  DetailReducer.swift
//  TDAFinder
//
//  Created by Christian Schneider on 28.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift

func detailReducer(action: Action, state: DetailState?) -> DetailState {

    var state = state ?? DetailState()

    switch action {

    case let action as SelectDetailAction:
        state.device = action.device

    default:
        break
    }

    return state
}
