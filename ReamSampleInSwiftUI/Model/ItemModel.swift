//
//  ItemModel.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/20.
//

import Foundation
import RealmSwift
import SwiftUI

final class ItemGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    // 一つのItemGroupに属するItemをListとして呼び出すことが可能
    @Persisted var items = RealmSwift.List<Item>()
}


final class Item: Object, ObjectKeyIdentifiable {
    // (primaryKey: true)を追加することによって、プライマリーキーとして設定可能
    @Persisted(primaryKey: true) var _id: ObjectId
    // インスタンス生成時に、ランダムな値が入る。
    @Persisted var name = "\(randomAdjectives.randomElement()!) \(randomNouns.randomElement()!)"
    
    @Persisted var isFavorite = false
    
    @Persisted var itemDescription = ""
    // ItemGroupに属しており、ItemGroupのitemsに属していることを設定可能
    @Persisted(originProperty: "items") var group: LinkingObjects<ItemGroup>
}

let randomAdjectives = [
    "fluffy", "classy", "bumpy", "bizarre", "wiggly", "quick", "sudden",
    "acoustic", "smiling", "dispensable", "foreign", "shaky", "purple", "keen",
    "aberrant", "disastrous", "vague", "squealing", "ad hoc", "sweet"
]

let randomNouns = [
    "floor", "monitor", "hair tie", "puddle", "hair brush", "bread",
    "cinder block", "glass", "ring", "twister", "coasters", "fridge",
    "toe ring", "bracelet", "cabinet", "nail file", "plate", "lace",
    "cork", "mouse pad"
]

extension Item {
    static let item1 = Item(value: ["name": "fluffy coasters", "isFavorite": false, "ownerId": "previewRealm"])
    static let item2 = Item(value: ["name": "sudden cinder block", "isFavorite": true, "ownerId": "previewRealm"])
    static let item3 = Item(value: ["name": "classy mouse pad", "isFavorite": false, "ownerId": "previewRealm"])
}

extension ItemGroup {
    static let itemGroup = ItemGroup(value: ["ownerId": "previewRealm"])
    
    static var previewRealm: Realm {
        var realm: Realm
        let identifier = "previewRealm"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            let realmObjects = realm.objects(ItemGroup.self)
            if realmObjects.count == 1 {
                return realm
            } else {
                try realm.write {
                    realm.add(itemGroup)
                    itemGroup.items.append(objectsIn: [Item.item1, Item.item2, Item.item3])
                }
                return realm
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}
