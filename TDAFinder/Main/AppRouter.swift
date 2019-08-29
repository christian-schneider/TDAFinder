//
//  AppRouter.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import ReSwift


enum RoutingDestination: String, CaseIterable {

    case none           = ""
    case devices        = "DevicesViewController"
    case detail         = "DetailViewController"
}


final class AppRouter {

    let navigationController: UINavigationController


    init(window: UIWindow) {

        navigationController = UINavigationController()
        window.rootViewController = navigationController

        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }


    fileprivate func pushViewController(identifier: String, animated: Bool) {

        let viewController = instantiateViewController(identifier: identifier)
        let newViewControllerType = type(of: viewController)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return
            }
        }

        navigationController.pushViewController(viewController, animated: animated)
    }


    private func instantiateViewController(identifier: String) -> UIViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}


extension AppRouter: StoreSubscriber {

    func newState(state: RoutingState) {

        if state.routingDestination == .none {
            return
        }

        if state.routingDestination.rawValue == navigationController.topViewController?.restorationIdentifier {
            return
        }

        if state.isPop {
            navigationController.popViewController(animated: true)
            return
        }

        if state.resetNavigationStack {
            let menuVC = instantiateViewController(identifier: RoutingDestination.devices.rawValue)
            let newVC = instantiateViewController(identifier: state.routingDestination.rawValue)
            navigationController.setViewControllers([menuVC, newVC], animated: false)
        }
        else {
            let shouldAnimate = navigationController.topViewController != nil
            pushViewController(identifier: state.routingDestination.rawValue, animated: shouldAnimate)
        }
    }
}
