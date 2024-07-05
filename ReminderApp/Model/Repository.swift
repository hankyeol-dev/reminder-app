//
//  Repository.swift
//  ReminderApp
//
//  Created by 강한결 on 7/4/24.
//

import Foundation
import RealmSwift

final class Repository<T: Object> {
    private let db = try! Realm()
    
    func getRealmURL() -> URL? {
        return db.configuration.fileURL
    }
    
    func getRecordById(_ id: ObjectId) -> Output<T> {
        
        guard let record = db.object(ofType: T.self, forPrimaryKey: id) else {
            return Output(ok: false, error: "해당 데이터 찾을 수 없어요 🥲", output: nil)           }
        return Output(ok: true, error: nil, output: record)
    }
    
    func getRecords() -> Output<Results<T>> {
        let records = db.objects(T.self)
        return Output(ok: true, error: nil, output: records)
    }
    
    
    func addSingleRecord(_ recordData: T) -> Output<T> {
        do {
            try db.write {
                db.add(recordData)
            }
            return Output(ok: true, error: nil, output: nil)
        } catch {
            return Output(ok: false, error: "데이터 저장에 실패했어요. 🥲", output: nil)
        }
    }
    
    func addRecordWithHandler(_ recordData: T, handler: @escaping (T) -> ())  -> Output<T> {
        do {
            try db.write {
                db.add(recordData)
                handler(recordData)
            }
            return Output(ok: true, error: nil, output: nil)
        } catch {
            return Output(ok: false, error: "데이터 저장에 실패했어요. 🥲", output: nil)
        }
    }
    
    func updateSingleRecordById(id: ObjectId, updateHandler: @escaping (T) -> ()) -> Output<T> {
        let record = self.getRecordById(id)
        if record.ok {
            do {
                try db.write {
                    if let record = record.output {
                        updateHandler(record)
                        db.add(record, update: .modified)
                    }
                }
                
                return Output(ok: true, error: nil, output: nil)
            } catch {
                return Output(ok: false, error: "데이터 업데이트에 실패했어요. 🥲", output: nil)
            }
        } else {
            return Output(ok: false, error: "업데이트 할 데이터를 찾지 못했어요. 🥲", output: nil)
        }
    }
    
    func deleteSingleRecordById(id: ObjectId) -> Output<T> {
        let record = self.getRecordById(id)
        if record.ok {
            do {
                try db.write {
                    if let record = record.output {
                        db.delete(record)
                    }
                }
                
                return Output(ok: true, error: nil, output: nil)
            } catch {
                return Output(ok: false, error: "데이터 업데이트에 실패했어요. 🥲", output: nil)
            }
        } else {
            return Output(ok: false, error: "업데이트 할 데이터를 찾지 못했어요. 🥲", output: nil)
        }
    }
}
