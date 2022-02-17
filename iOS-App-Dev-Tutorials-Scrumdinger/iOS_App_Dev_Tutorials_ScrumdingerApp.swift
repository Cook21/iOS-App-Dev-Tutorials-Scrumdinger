//
//  iOS_App_Dev_Tutorials_ScrumdingerApp.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/1/26.
//

import SwiftUI

@main
struct iOS_App_Dev_Tutorials_ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums,saveAction: {
                /*
                 //原本callback风格的异步执行
                 ScrumStore.save(scrums: store.scrums, completion: {result in
                 if case .failure(let error) = result {
                 fatalError(error.localizedDescription)
                 }
                 })
                 */
                Task {
                    do {
                        try await ScrumStore.save(scrums: store.scrums)
                    } catch {
                        fatalError("Error saving scrums.")
                    }
                }
                
            })
            /*
             .onAppear {
             //callback风格的异步，执行完成之后回调闭包里的函数，同时用Result类型避免了抛出异常
             ScrumStore.load { result in
             switch result {
             case .failure(let error):
             fatalError(error.localizedDescription)
             case .success(let scrums):
             store.scrums = scrums
             }
             }
             }
             */
                .task {
                    do {
                        store.scrums = try await ScrumStore.load()
                    } catch {
                        fatalError("Error loading scrums.")
                    }
                }
        }
    }
}
