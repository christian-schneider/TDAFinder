//
//  RoutingAction.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift

struct RoutingAction: Action {

    let destination: RoutingDestination
    let resetNavigationStack: Bool
    let isPop: Bool


    init(destination: RoutingDestination) {
        self.destination = destination
        self.resetNavigationStack = false
        self.isPop = false
    }


    init(destination: RoutingDestination, resetNavigationStack: Bool) {
        self.destination = destination
        self.resetNavigationStack = resetNavigationStack
        self.isPop = false
    }


    init(destination: RoutingDestination, resetNavigationStack: Bool, isPop: Bool) {
        self.destination = destination
        self.resetNavigationStack = resetNavigationStack
        self.isPop = isPop
    }

    
    init(destination: RoutingDestination, isPop: Bool) {
        self.destination = destination
        self.resetNavigationStack = false
        self.isPop = isPop
    }
}


