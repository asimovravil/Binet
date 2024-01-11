//
//  DrugService.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import Foundation

class DrugService {
    func fetchDrugs(completion: @escaping (Result<[Drug], Error>) -> Void) {
        let url = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/")! 

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            do {
                let drugs = try JSONDecoder().decode([Drug].self, from: data)
                completion(.success(drugs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

