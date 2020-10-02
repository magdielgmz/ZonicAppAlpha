//
//  Service.swift
//  ZonicApp
//
//  Created by MagdielG on 08/05/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import Firebase


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {
    
    static let shared  = Service()
    let currentUid = Auth.auth().currentUser?.uid
    
    func fetchUserData(completion: @escaping(User) -> Void ){
        REF_USERS.child(currentUid!).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let user = User(dictionary: dictionary)
            print("DEBUG: User email is \(user.email)")

            completion(user)
        }
    }
}
