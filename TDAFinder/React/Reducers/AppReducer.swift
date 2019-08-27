//
//  AppReducer.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift


func appReducer(action: Action, state: AppState?) -> AppState {

    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        devicesState: devicesReducer(action: action, state: state?.devicesState)
    )
}

