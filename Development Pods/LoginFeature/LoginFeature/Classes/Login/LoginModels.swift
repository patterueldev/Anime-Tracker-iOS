//
//  LoginModels.swift
//  Pods
//
//  Created by John Patrick Teruel on 4/19/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Login
{
    // MARK: Use cases
    
    enum Authorization
    {
        struct Request
        {
        }
        struct Response
        {
            let oauthURL: URL
        }
        struct ViewModel
        {
            let oauthURL: URL
        }
    }
    
    enum Redirect
    {
        struct Request
        {
            let url: URL?
        }
        
        struct Response
        {
            
        }
        struct ViewModel
        {
            
        }
    }
}
