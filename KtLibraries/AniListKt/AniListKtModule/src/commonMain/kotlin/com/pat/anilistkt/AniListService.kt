package com.pat.anilistkt

class AniListService(
    val clientId: String,
    val clientSecret: String,
    val redirectURI: String
) {
    var session: AniListSession? = null

    fun oauth2URL(): String {
        return "https://anilist.co/api/v2/oauth/authorize?response_type=token&client_id=$clientId"
    }

    fun parseToken(url: String): OAuthToken? {
        val match = "$redirectURI#"
        val replace = "$redirectURI?"
        val components = url.replace(match, replace)
        val query = components.split("?")
        val params = query[1].split("&")
        val accessToken = params[0].split("=")[1]
        val tokenType = params[1].split("=")[1]
        val expiresIn = params[2].split("=")[1].toInt()
        return OAuthToken(accessToken = accessToken, tokenType = tokenType, expiresIn = expiresIn)
    }

    suspend fun authorizeUser(token: OAuthToken) {
        this.session = AniListSession(token = token)
    }
}

/*
from swift
    public func parseUrl(_ url: URL?) -> Oauth2Response? {
        let match = "\(redirectURI)#"
        let replace = "\(redirectURI)?"
        guard let url = url,
              url.absoluteString.contains(redirectURI),
              let components = URLComponents(string: url.absoluteString.replacingOccurrences(of: match, with: replace)) else {
            return nil
        }
        // attempt to extract code and state from the url components
        guard let accessToken = components.queryItems?.first(where: { $0.name == "access_token"})?.value,
              let tokenType = components.queryItems?.first(where: { $0.name == "token_type"})?.value,
              let expiresInRaw = components.queryItems?.first(where: { $0.name == "expires_in"})?.value,
              let expiresIn = Int(expiresInRaw) else {
            return nil
        }
        return Oauth2Response(accessToken: accessToken, tokenType: tokenType, expiresIn: expiresIn)
    }
 */