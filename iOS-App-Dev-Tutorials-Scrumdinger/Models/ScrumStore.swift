//
//  ScrumStore.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/14.
//
//用于保存当前所有scrums到文件里，便于下次启动时使用
import Foundation
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("scrums.data")
    }
    //completion是回调函数，接受一个Result类型的输入
    static func load(completion: @escaping (Result<[DailyScrum], Error>)->Void) {
        //FIFO
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                //如果捕获到异常，就返回错误，因为是异步回调completion函数，所以放到队列里
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    //warpper，把原来的callback风格的load函数包装成async函数
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            load (completion: { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            })
        }
    }
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    //warpper，把原来的callback风格的save函数包装成async函数
    @discardableResult //直接调用忽略返回值，编译器不会警告
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation({ continuation in
            save(scrums: scrums, completion: { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let count):
                    continuation.resume(returning: count)
                }
            })
        })
    }
}
