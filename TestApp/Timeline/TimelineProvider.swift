//
//  TimelineProvider.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import Foundation

final class TimelineProvider {
    
    func fetchTimeline(queryParams: [String: String], completion: @escaping (Result<TimelineResponseModel, Error>) -> Void) {
        let route = "https://api.tjournal.ru/v2.1/timeline"
        var urlComponents = URLComponents(string: route)
        urlComponents?.queryItems = queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let url = urlComponents?.url else {
            return completion(.failure(RuntimeError("Invalid URL")))
        }
        fetchTimeline(url: url) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func fetchTimeline(url: URL, completion: @escaping (Result<TimelineResponseModel, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completion(.failure(error!))
            }
            guard let data = data else {
                return completion(.failure(RuntimeError("No data")))
            }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                let model = try JSONDecoder().decode(TimelineResponseModel.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
