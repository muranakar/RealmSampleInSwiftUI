//
//  ItemView.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/20.
//

import SwiftUI
import RealmSwift

struct ItemsView: View {
    // @ObservedRealmObjectのプロパティラッパーで宣言することによって、
    // ローカルデータを簡単に書き換え可能。
    @ObservedRealmObject var itemGroup: ItemGroup

    var leadingBarButton: AnyView?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(itemGroup.items) { item in
                        ItemRow(item: item)
                    }
                    // 削除の実装。ローカルデータも書き換えられる
                    .onDelete(perform: $itemGroup.items.remove)
                    // 並び替え実装。
                    .onMove(perform: $itemGroup.items.move)
                }
                .listStyle(GroupedListStyle())
                    .navigationBarItems(
                        leading: self.leadingBarButton,
                        trailing: EditButton())
                HStack {
                    Spacer()
                    Button(action: {
                        // itemGroupに属するItemを新規追加できる
                        $itemGroup.items.append(Item())
                    }) { Image(systemName: "plus") }
                }.padding()
            }
        }
    }
}


