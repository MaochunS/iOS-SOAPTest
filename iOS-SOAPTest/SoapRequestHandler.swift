//
//  SoapRequestTest.swift
//  iOS-SOAPTest
//
//  Created by maochun on 2021/2/14.
//

import Foundation

class SoapRequestHandler {
    
    private static let RequestTimeout : TimeInterval = 5
    private static let LogSvrRequestDetails = true
    
    
    func sendRequestSync(urlstr: String,
                         host: String,
                         soapAction: String,
                         param: Data?,
                         withTimeout timeout:TimeInterval = RequestTimeout) -> (Bool, String){
        guard let url = URL(string: urlstr) else
        {
            print("sendRequestSync invalid url")
            return (false, "Invalid url \(urlstr)")
        }
      
      
        var request : URLRequest = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = timeout
        
        request.addValue(host, forHTTPHeaderField: "Host")
        request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        
     
        if let param = param{
            request.httpBody = param
        }
        

        return processURLRequestSync(request: request)
    }
    
    func processURLRequestSync(request: URLRequest) -> (Bool, String){
          
        var strRet: String = ""
        var taskRet = false
        
          
        let taskDG = DispatchGroup()
        taskDG.enter()
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
          
            if let response = response as? HTTPURLResponse{
                
                if SoapRequestHandler.LogSvrRequestDetails{
                    print(request.url ?? "")
                    
                    if let requestData = request.httpBody{
                        print(String(decoding: requestData, as: UTF8.self))
                    }
                    
                    if let data = data{
                        print(String(decoding: data, as: UTF8.self))
                    }
                }
                
                
                if response.statusCode == 200{
                    
                    if let data = data{
                        strRet = String(data: data, encoding: .utf8) ?? ""
                    }
                    taskRet = true
                  
                }else{
                    
                    print("Error: \(error?.localizedDescription ?? "") url request response \(request) \(response.statusCode)")
                    
                    if let url = request.url{
                        print("request url = \(url)")
                    }
                    
                    
                    if let data = data, let dataStr = String(data: data, encoding: String.Encoding.utf8){
                        print("\(dataStr)")
                        
                        strRet = dataStr
                        
                    }else{
                        strRet = "Error: \(error?.localizedDescription ?? "") response code = \(response.statusCode)"
                    }
                    
                }
          }

          taskDG.leave()
          return
        }

        task.resume()
        taskDG.wait()

        return (taskRet, strRet)
    }
    
}
