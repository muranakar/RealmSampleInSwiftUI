//
//  ContentView.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/20.
//

import SwiftUI
import RealmSwift

struct LocalOnlyContentView: View {
    @State var searchFilter: String = ""
    @ObservedResults(ItemGroup.self) var itemGroups
    
    var body: some View {
        // itemGroupsでローカルに保存されている全てのItemGroupを呼び出して、一つだけ取り出す
        // ローカルデータにItemGroupが存在しない場合は、ItemGroupを生成する。
        if let itemGroup = itemGroups.first {
            ItemsView(itemGroup: itemGroup)
        } else {
            ProgressView().onAppear {
                $itemGroups.append(ItemGroup())
            }
        }
    }
}
