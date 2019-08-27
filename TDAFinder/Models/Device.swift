//
//  Device.swift
//  TDAFinder
//
//  Created by Christian Schneider on 27.08.19.
//  Copyright © 2019 gerzonic. All rights reserved.
//

import RealmSwift
import ObjectMapper


@objcMembers class Device: Object, Mappable {

    enum Property: String {
        case id, title, converter, mechanism
    }

    dynamic var id: String! = UUID().uuidString
    dynamic var title: String! = ""
    dynamic var converter: String! = ""
    dynamic var mechanism: String! = ""


    override static func primaryKey() -> String? {
        return Device.Property.id.rawValue
    }


    convenience init(_ text: String) {
        self.init()
        self.title = text
    }


    required convenience init?(map: Map) {
        self.init()
    }


    func mapping(map: Map) {
        id <- map["id"]
        title <- map["cdplayer"]
        converter <- map["converter"]
        mechanism <- map["cdmechanism"]
    }
}


extension Device {

}
