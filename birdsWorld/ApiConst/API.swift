//
//  API.swift
//  birdsWorld
//
//  Created by Umar Amjad on 16/04/2020.
//  Copyright © 2020 Umar Amjad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    
    static let url = "http://192.168.0.108:8000/api/"
    static let imageURL = "http://192.168.0.108/birds/public/appAssets/images/"
    static let webViewUrl = "http://192.168.0.108/birds/public/"
    
    class func getHeaders(headers: [String:String] = [:]) -> [String:String]{
        
        let new_headers: [String:String] =  ["Authorization":"application/json"]
        return new_headers
    }
    
    class func getURL(url: String) -> String{
        return API.url+url
        
    }
    
    class func getImage(imageFileName: String) -> UIImage{
        
        let url = URL(string: API.imageURL+imageFileName)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
        
    }
    
    class func login(email:String,password:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["email": email,
                                        "password": password]
        
        Alamofire.request( API.getURL(url: "login"), method: .get, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func register(name:String,email:String,password:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["name": name,
                                          "email": email,
                                          "password": password]
        
        Alamofire.request( API.getURL(url: "register"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    class func otherAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "otherAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func homeDashboard(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "homeDashboard"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func adsListingSingle(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "adsListingSingle/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func allAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "allAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func LovebirdAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "LovebirdAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func budgerigarsAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "budgerigarsAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func finchAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "finchAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func javaAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "javaAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func exoticBirdAllAds(completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "exoticBirdAllAds"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func contactUs(title:String,description:String,userId:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
//        var Id = Int(userId)
        let parameters:[String:String] = ["title": title,
                                        "description": description,
                                        "id":  userId]
        
        Alamofire.request( API.getURL(url: "contactus"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func postAd(ringNumber:String,mutation:String,split:String,user_id:String,parentMaleMutation:String,parentFemaleMutation:String,gender:String,category:String,age:String,city:String,phone:String,description:String,title:String,price:String,addess:String,photos:[Data],completionHandler: @escaping (JSON?, Error?) -> ()){

        let parameters:[String:String] = ["ringNumber": ringNumber, "mutation": mutation, "split":  split, "user_id": user_id, "parentMaleMutation": parentMaleMutation, "parentFemaleMutation": parentFemaleMutation, "gender": gender, "category": category, "age": age, "city": city, "phone": phone, "description": description, "title": title, "price": price, "address": addess]
        
        var count = 1
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for photo in photos{
                multipartFormData.append(photo, withName: "photos[]", fileName: "image\(count).jpg", mimeType: "image/jpg")
            }

        }, usingThreshold: UInt64.init(), to: API.getURL(url: "postAds"),method: .post, headers: API.getHeaders()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded  = \(response)")
                    if let err = response.error{

                        completionHandler(nil, err)
                    }
                    
                    let json = JSON(response.value)
                    completionHandler(json, nil)

                }
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    
    class func chatSayHi(from_id:String,to_id:String,body:String,completionHandler: @escaping (JSON?, Error?) -> ()){
            
    //        var Id = Int(userId)
            let parameters:[String:String] = ["from_id": from_id,
                                            "to_id": to_id,
                                            "body":  body]
            
            Alamofire.request( API.getURL(url: "chatSayHi"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    completionHandler(json, nil)
                
                case .failure(let error):
                    completionHandler(nil, error)
                    
                }
            }
        }
    
    class func reportAnAd(title:String,description:String,userId:String,post_ad_id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
            
            let parameters:[String:String] = ["title": title,
                                            "description": description,
                                            "user_id":  userId,
                                            "post_ad_id": post_ad_id ]
            
            Alamofire.request( API.getURL(url: "reportAnAd"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    completionHandler(json, nil)
                
                case .failure(let error):
                    completionHandler(nil, error)
                    
                }
            }
    }
    
    class func activeAds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "activeAds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func closedAds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "closedAds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func updateActiveAds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "updateActiveAds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    
    class func addBirdsuploadSubmit(ringNumber:String,mutation:String,split:String,user_id:String,gender:String,category:String,dob:String,photos:[Data],completionHandler: @escaping (JSON?, Error?) -> ()){

        let parameters:[String:String] = ["ring_number": ringNumber, "mutation": mutation, "split":  split, "user_id": user_id, "gender": gender, "category": category, "dob": dob]
        
        var count = 1
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for photo in photos{
                multipartFormData.append(photo, withName: "photos[]", fileName: "image\(count).jpg", mimeType: "image/jpg")
            }

        }, usingThreshold: UInt64.init(), to: API.getURL(url: "addBirds"),method: .post, headers: API.getHeaders()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded  = \(response)")
                    if let err = response.error{

                        completionHandler(nil, err)
                    }
                    
                    let json = JSON(response.value)
                    completionHandler(json, nil)

                }
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func allBirds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "allBirds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func lovebirds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "lovebirds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func budgerigars(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "budgerigars/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func finches(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "finches/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func java(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "java/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func exoticBirds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "exoticBirds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func otherBirds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "otherBirds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func birdListingSingle(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "birdListingSingle/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func editBirdSave(ringNumber:String,mutation:String,split:String,bird_id:String,gender:String,category:String,dob:String,photos:[Data],completionHandler: @escaping (JSON?, Error?) -> ()){

        let parameters:[String:String] = ["ring_number": ringNumber, "mutation": mutation, "split":  split, "id": bird_id, "gender": gender, "category": category, "dob": dob]
        
        var count = 1
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for photo in photos{
                multipartFormData.append(photo, withName: "photos[]", fileName: "image\(count).jpg", mimeType: "image/jpg")
            }

        }, usingThreshold: UInt64.init(), to: API.getURL(url: "editBirdSave"),method: .post, headers: API.getHeaders()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded  = \(response)")
                    if let err = response.error{

                        completionHandler(nil, err)
                    }
                    
                    let json = JSON(response.value)
                    completionHandler(json, nil)

                }
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    
    // pair apis
    
    
    class func lovebirdsPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "lovebirdsPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func otherPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

        Alamofire.request( API.getURL(url: "otherPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                completionHandler(json, nil)

            case .failure(let error):
                completionHandler(nil, error)

            }
        }
    }

    class func javaPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

        Alamofire.request( API.getURL(url: "javaPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                completionHandler(json, nil)

            case .failure(let error):
                completionHandler(nil, error)

            }
        }
    }
//
    class func finchesPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

        Alamofire.request( API.getURL(url: "finchesPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                completionHandler(json, nil)

            case .failure(let error):
                completionHandler(nil, error)

            }
        }
    }

    class func exoticBirdsPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

        Alamofire.request( API.getURL(url: "exoticBirdsPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                completionHandler(json, nil)

            case .failure(let error):
                completionHandler(nil, error)

            }
        }
    }

    class func budgerigarsPair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

        Alamofire.request( API.getURL(url: "budgerigarsPair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                completionHandler(json, nil)

            case .failure(let error):
                completionHandler(nil, error)

            }
        }
    }
    
    class func createPair(userId:String,category:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["id": userId,
                                        "category": category]
        
        Alamofire.request( API.getURL(url: "createPair"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }

      class func addPair(maleId:String,femaleId:String,pairingDate:String,userId:String,category:String,cageNo:String,completionHandler: @escaping (JSON?, Error?) -> ()){
            
            let parameters:[String:String] = ["male": maleId,
                                            "female": femaleId,
                                            "pairing_date":  pairingDate,
                                            "user_id":  userId,
                                            "category":  category,
                                            "cageNo":  cageNo]
            
            Alamofire.request( API.getURL(url: "addPair"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    completionHandler(json, nil)
                
                case .failure(let error):
                    completionHandler(nil, error)
                    
                }
            }
        }
    
    
    //inbreeding clutch
    
    class func addClutch(pairId:String,totalEggs:String,totalChicks:String,firstEggDate:String,userId:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["pairId": pairId,
                                        "totalEggs": totalEggs,
                                        "totalChicks":  totalChicks,
                                        "firstEggDate":  firstEggDate,
                                        "user_id":  userId]
        
        Alamofire.request( API.getURL(url: "addClutch"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
        class func lovebirdInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
            
            Alamofire.request( API.getURL(url: "lovebirdInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    completionHandler(json, nil)
                
                case .failure(let error):
                    completionHandler(nil, error)
                    
                }
            }
        }
        
        class func otherInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "otherInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func javaInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "javaInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }
    
        class func finchInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "finchInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func exoticInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "exoticInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func budgerigarInbreedingClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "budgerigarInbreedingClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }
    
    
    //completed clutch
    
    class func lovebirdCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
            
            Alamofire.request( API.getURL(url: "lovebirdCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    completionHandler(json, nil)
                
                case .failure(let error):
                    completionHandler(nil, error)
                    
                }
            }
        }
        
        class func otherCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "otherCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func javaCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "javaCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }
    
        class func finchCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "finchCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func exoticCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "exoticCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }

        class func budgerigarCompletedClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){

            Alamofire.request( API.getURL(url: "budgerigarCompletedClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    completionHandler(json, nil)

                case .failure(let error):
                    completionHandler(nil, error)

                }
            }
        }
        
    class func adminhome(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "adminhome/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func adminUpdateDetail(name:String,id:String,password:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["name": name,
                                          "id": id,
                                          "password": password]
        
        Alamofire.request( API.getURL(url: "adminUpdateDetail"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func deleteActiveAndClosedAds(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "deleteActiveAndClosedAds/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func deleteBird(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "deleteBird/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func deletePair(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "deletePair/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func deleteClutch(id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        Alamofire.request( API.getURL(url: "deleteClutch/\(id)"), method: .get, parameters: nil, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    class func editClutchSave(totalEggs:String,totalChicks:String,firstEggDate:String,id:String,completionHandler: @escaping (JSON?, Error?) -> ()){
        
        let parameters:[String:String] = ["totalEggs": totalEggs,
                                        "totalChicks":  totalChicks,
                                        "firstEggDate":  firstEggDate,
                                        "id":  id]
        
        Alamofire.request( API.getURL(url: "editClutchSave"), method: .post, parameters: parameters, headers: API.getHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json, nil)
            
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
}
