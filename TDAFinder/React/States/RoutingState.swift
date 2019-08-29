//
//  RoutingState.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift

struct RoutingState: StateType {

    var routingDestination: RoutingDestination

    var isPop = false

    var resetNavigationStack = false

    init(navigationState: RoutingDestination = .devices) {
        self.routingDestination = navigationState
    }
}
