//
//  RoutingReducer.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift


func routingReducer(action: Action, state: RoutingState?) -> RoutingState {

    var state = state ?? RoutingState()

    switch action {

    case let routingAction as RoutingAction:
        state.routingDestination = routingAction.destination
        state.resetNavigationStack = routingAction.resetNavigationStack
        state.isPop = routingAction.isPop

    default:
        break
    }

    return state
}
