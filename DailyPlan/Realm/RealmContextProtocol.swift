//
//  RealmContextProtocol.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation
import RealmSwift

protocol RealmContextProtocol {
    var dataBase: Realm? { get }
    var token: NotificationToken? { get }
    var realmQueue: DispatchQueue { get }
    
    func getRealm(_ completion:
                  @escaping (Result<Realm, ErrorRealm>) -> Void)
}

extension RealmContextProtocol {
    func getRealm(_ completion:
                  @escaping (Result<Realm, ErrorRealm>) -> Void) {
        
        realmQueue.async {
            do {
                completion(.success(try Realm()))
            } catch let error as NSError {
                completion(.failure(.dataBaseAccessError("\(error.code)")))
            }
        }
    }
}
