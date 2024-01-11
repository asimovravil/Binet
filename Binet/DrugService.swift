//
//  DrugService.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import Foundation

import Foundation

class DrugService {
    func fetchDrugs(completion: @escaping (Result<[Drug], Error>) -> Void) {
        let url = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "", code: -1, userInfo: nil)
                print("No data received. Error: \(dataError)")
                completion(.failure(dataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let drugs = try decoder.decode([Drug].self, from: data)
                completion(.success(drugs))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
