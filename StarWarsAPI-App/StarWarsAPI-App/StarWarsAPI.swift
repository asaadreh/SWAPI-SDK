//
//  StarWarsAPI.swift
//  StarWarsAPI-App
//
//  Created by Agha Saad Rehman on 16/07/2021.
//

import Foundation



enum APIErrors: Error {
    case urlCreationError
    case connectionError
    case attributeNotFound
}




class StarWarsAPI {
    
    typealias APIResult = (Result<[String:Any], APIErrors>) -> ()
    typealias APIResultAll = (Result<[[String:Any]], APIErrors>) -> ()
    
    public func getOneWithId(resource: String, withId id: Int?, requiredAttributes attributes: [String], completion: @escaping APIResult) {
        
        guard let url = createURL(path: resource, id: id) else {
            completion(.failure(.urlCreationError))
            return
        }
        
        print(url.absoluteString)
        
        do {
            let data = try Data(contentsOf: url)
            let result = self.findAttributes(attributes: attributes, in: data)
            completion(.success(result))
        } catch {
            completion(.failure(APIErrors.attributeNotFound))
        }
        
    }
    
    public func getAll(resource: String, requiredAttributes attributes: [String], completion: @escaping APIResultAll) {
        // creating URL
        guard let url = createURL(path: resource, id: nil) else {
            completion(.failure(.urlCreationError))
            return
        }
        
        print(url.absoluteString)
        
        // Getting Data from Server
        
        do {
            let data = try Data(contentsOf: url)
            let result = self.findAttributesForAll(attributes: attributes, in: data)
            completion(.success(result))
        } catch {
            completion(.failure(APIErrors.attributeNotFound))
        }
    }
    
    
//    private func dataTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?)->Void) {
//        let session = URLSession(configuration: .default)
//        let dataTask = session.dataTask(with: url) {data, response, error in
//            completion(data,response,error)
//        }
//        dataTask.resume()
//    }
    
    
    private func findAttributesForAll(attributes: [String], in data: Data) -> [[String:Any]] {
        var res = [[String:Any]]()
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                let results = json["results"] as! [[String:Any]]
                
                for result in results {
                    //let name = result["name"] as! String
                    
                    var attributesObject = [String: Any]()
                    for attribute in attributes {
                        let attributeValue = result[attribute]
                        attributesObject[attribute] = attributeValue
                    }
                    res.append(attributesObject)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return res
    }
    
    private func findAttributes(attributes: [String], in data: Data) -> [String:Any] {
        
        var res = [String:Any]()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                for attribute in attributes {
                    if let value = json[attribute] {
                        
                        print(value)
                        res[attribute] = value
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return res
    }
    
    private func createURL(path: String, id: Int?) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "swapi.dev"
        if let id = id {
            components.path = "/api/\(path)/\(id)"
            guard let url = components.url else { return nil }
            return url
        }
        components.path = "/api/\(path)"
        guard let url = components.url else { return nil }
        return url
    }
}
