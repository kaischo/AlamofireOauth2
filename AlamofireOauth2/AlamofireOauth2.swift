
import Foundation
import UIKit
import KeychainAccess

public func UsingOauth2(_ settings: Oauth2Settings?, performWithToken: @escaping (_ token: String, _ jsonResponse: Any?) -> (),  errorHandler: @escaping () -> () )  {
    if settings == nil {
        print("ERROR: No Oauth2 settings provided")
        errorHandler()
        return
    }
    let client = OAuth2Client(outh2Settings: settings!)
    client.retrieveAuthToken(token: { (authToken, jsonResponse) -> Void in
        if let optionnalAuthToken = authToken {
            if authToken != "" {
                print("Received access token " + optionnalAuthToken)
                performWithToken(optionnalAuthToken, jsonResponse)
                return
            }
        }
        print("ERROR: Unable to get access token ")
        errorHandler()
        
    })
}

public func Oauth2ClearTokensFromKeychain(_ settings: Oauth2Settings) {
    let keychain = Keychain(service: settings.baseURL)
    keychain[kOAuth2AccessTokenService] = nil
    keychain[kOAuth2RefreshTokenService] = nil
}
