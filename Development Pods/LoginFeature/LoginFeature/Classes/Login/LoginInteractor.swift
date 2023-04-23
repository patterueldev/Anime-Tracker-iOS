//
//  LoginInteractor.swift
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

protocol LoginBusinessLogic
{
    func requestAuthorization(request: Login.Authorization.Request)
    func handleRedirect(request: Login.Redirect.Request)
}

protocol LoginDataStore
{
    var moduleData: LoginModuleData! { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var moduleData: LoginModuleData!
    //var name: String = ""
    
    // MARK: Do something
    
    func requestAuthorization(request: Login.Authorization.Request) {
        let url = moduleData.loginService.getOauth2URL()
        print("Oauth2 URL: \(url.absoluteString)")
        presenter?.presentAuthorizationWebView(response: .init(oauthURL: url))
    }
    
    func handleRedirect(request: Login.Redirect.Request) {
        guard let response = moduleData.loginService.parseUrl(request.url) else {
            print("Unable to parse URL: \(request.url?.absoluteString)")
            return
        }
        presenter?.presentHUD()
        presenter?.dismissWebView()
        
        // start processing
        Task {
            do {
                try await moduleData.loginService.authorizeUser(oauthResponse: response)
                // if success, will proceed to the landing screen
                print("Succesfully logged in!")
                presenter?.presentAlert(title: "Success", message: "Logged in!")
            } catch {
                presenter?.presentAlert(title: "Error", message: error.localizedDescription)
            }
            presenter?.dismissHUD()
        }
    }
}
