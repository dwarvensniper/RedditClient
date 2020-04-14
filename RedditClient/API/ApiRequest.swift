//
//  ApiRequest.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//
import Foundation

class ApiRequest{
    
    func send<T: Request>(request: T, completion: @escaping ResultCallback<T.Response>){
        guard let url = UrlEncoder().getFullUrl(subUrl: request.subUrl, urlType: request.urlType, parameter: request.queryParameters) else { return }
        URLSession.shared.dataTask(with: url){(data, response, err) in
            if let data = data{
                do{
                    if let httpResponse = response as? HTTPURLResponse {
                        switch (httpResponse.statusCode) {
                        case 200, 201, 202:
                            let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                            completion(.success(decodedResponse))
                            break;
                        default:
                            let decodedResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(.responseError(decodedResponse))
                            break;
                        }
                    }
                    
                }catch _{
                    completion(.failure("Data Decode Error!"))
                }
            }else{
                completion(.failure("Request Error!"))
            }
            }.resume()
        }
    
}
