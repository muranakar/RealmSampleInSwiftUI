//
//  ItemRow.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/22.
//

import SwiftUI
import RealmSwift

struct ItemRow: View {
    @ObservedRealmObject var item: Item

    var body: some View {
        NavigationLink(destination: ItemDetailsView(item: item)) {
            Text(item.name)
            if item.isFavorite {
                Image(systemName: "heart.fill")
            }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        let realm = ItemGroup.previewRealm
        let itemGroup = realm.objects(ItemGroup.self)
        ItemsView(itemGroup: itemGroup.first!)
    }
}
