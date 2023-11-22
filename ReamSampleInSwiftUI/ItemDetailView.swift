//
//  ItemDetailView.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/20.
//

import SwiftUI
import RealmSwift

struct ItemDetailsView: View {
    // @ObservedRealmObjectのプロパティラッパーで宣言することによって、
    // ローカルデータを簡単に書き換え可能。
    @ObservedRealmObject var item: Item

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter a new name:")
            // nameを書き換えることができる
            TextField("New name", text: $item.name)
                .navigationBarTitle(item.name)
            // isFavoriteを書き換えることができる
                .navigationBarItems(trailing: Toggle(isOn: $item.isFavorite) {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                })
        }.padding()
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetailsView(item: Item.item2)
        }
    }
}
