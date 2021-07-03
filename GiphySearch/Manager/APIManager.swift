//
//  APIManager.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/03.
//

import Foundation
import Alamofire

class APIManager {
    typealias APIResponse<T> = Swift.Result<T, APIError>
    
    enum APIError: Error {
        case failWithMessage(String)
    }
    static func requestWithName<T: Decodable>(_ requestUrl: String, method: HTTPMethod, parameters: [String: Any]?, progress: Bool = true, encoding:Bool = false, responseType: T.Type, response: @escaping (APIResponse<T>) -> Void) {
        let url = URL(string: requestUrl)
        let hTTPHeaders = APIManager.getAPIHeader()
        var urlEncoding: ParameterEncoding = URLEncoding.default
        
        let manager = Alamofire.Session.default

        if encoding {
            urlEncoding = JSONEncoding.default //get, post에 따라 파라미터 인코딩 방식 다름
        } else {
            urlEncoding = URLEncoding.default
        }

        
        LOG("request url : ['\(String(describing: url))]")
        LOG("REQUEST Params: '\(String(describing: parameters))")
        
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        _ = manager.request(url!, method: method, parameters: parameters, encoding: urlEncoding, headers: hTTPHeaders).validate().responseJSON { (responseData) in
            
            LOG("Response url : ['\(String(describing: url!))]")
            LOG("JSON: '\(responseData)")
            
            DispatchQueue.main.async {
                
                switch responseData.result {
                case .success(let successData):
                    guard let data = try? JSONSerialization.data(withJSONObject: successData, options: .prettyPrinted) else {
                        // 성공 -> Json 파싱 실패
                        response(.failure(APIError.failWithMessage("Success -> Fail json parsing")))
                        break
                    }
                    
                    if let json = successData as? [String: Any], let _ = json["data"] {
                        if let object = try? JSONDecoder().decode(responseType, from: data) {
                            // 성공 -> Object 파싱 성공
                            response(.success(object))
                        } else {
                            // 성공 -> Object 파싱 실패
                            response(.failure(APIError.failWithMessage("Success -> Fail object parsing")))
                        }
                    } else {
                        // 실패 -> 에러 Object 파싱 실패
                        response(.failure(APIError.failWithMessage("Failure -> Fail object parsing")))
                    }
                case .failure(let error):
                    response(.failure(APIError.failWithMessage(error.localizedDescription)))
                }
            }
        }
    }
    
    internal static func getAPIHeader() -> HTTPHeaders {
            var header = HTTPHeaders()
            header["Content-Type"] = "application/json"
            return header
        }
}
