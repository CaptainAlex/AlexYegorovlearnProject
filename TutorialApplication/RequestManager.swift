//
//  RequestManager.swift
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 2/17/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

import UIKit
import Alamofire

class RequestManager: NSObject
{
    static func fetchOrganizations(completionHandler: @escaping ([String : AnyObject]) -> ())
    {
        Alamofire.request("http://gitlab.faifly.com/ios-general/ios-tutorial/uploads/ffffec34fa4a727922bb1e09cc24b21d/tutorial.json").responseJSON
            { response in
            
                if let JSON = response.result.value as? [String : AnyObject]
                {
                    completionHandler(JSON)
                }
        }
    }
    
}

