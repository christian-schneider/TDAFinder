//
//  AppState.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift

struct AppState: StateType {

    let routingState:       RoutingState
    let devicesState:       DevicesState
    let detailState:        DetailState
}


