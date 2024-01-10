//
//  CollectionListService.swift
//  ERCCollection
//
//  Created by mingshing on 2024/1/4.
//

import RxSwift

enum ServiceError: Error {
    case cannotGetURL
    case cannotParse
}


class CollectionListQueryParameter {
    public var path: String
    public let owner: String
    public let pageSize: Int
    public let pageKey: String?
    
    init(owner: String, pageSize: Int = 20, pageKey: String? = nil) {
        self.owner = owner
        self.pageSize = pageSize
        self.pageKey = pageKey
        self.path = "getNFTsForOwner"
    }
    
    static var firstPage: CollectionListQueryParameter {
        CollectionListQueryParameter(
            owner: "0x85fD692D2a075908079261F5E351e7fE0267dB02"
        )
    }
    static func nextPage(_ pageKey: String) -> CollectionListQueryParameter {
        CollectionListQueryParameter(
            owner: "0x85fD692D2a075908079261F5E351e7fE0267dB02",
            pageSize: 20,
            pageKey: pageKey
        )
    }
}

struct CollectionListResponse: Codable {
    let ownedNfts: [CollectionItem]
    let pageKey: String?
}

class CollectionListService {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func getCollectionList(_ queryParam: CollectionListQueryParameter) -> Observable<([CollectionItem], String?)> {
        
        if let generatedURL = generateURL(queryParam) {
            return session.rx.data(request: URLRequest(url: generatedURL))
                .map { data in
                    let decoder = JSONDecoder()
                    let collectionItems = try decoder.decode(CollectionListResponse.self, from: data)
                    
                    return (collectionItems.ownedNfts, collectionItems.pageKey)
                }
                .asObservable()
        }
        return Observable.error(ServiceError.cannotGetURL)
    }
    private func generateURL(_ queryParam: CollectionListQueryParameter) -> URL? {
        // Create URL components
        var urlComponents = URLComponents()
        urlComponents.scheme = APIContants.scheme
        urlComponents.host = APIContants.host
        urlComponents.path = "\(APIContants.path)\(APIContants.key)/\(queryParam.path)"

        var queryParams: [URLQueryItem] = []
        queryParams.append(URLQueryItem(name: "owner", value: queryParam.owner))
        queryParams.append(URLQueryItem(name: "pageSize", value: "\(queryParam.pageSize)"))
        
        if let pageKey = queryParam.pageKey {
            queryParams.append(URLQueryItem(name: "pageKey", value: pageKey))
        }
        urlComponents.queryItems = queryParams

        if let url = urlComponents.url {
            return url
        } else {
            return nil
        }
    }
}
