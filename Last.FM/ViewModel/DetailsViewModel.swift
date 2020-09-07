//
//  DetailsViewModel.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

enum DetailsViewState {
    case loading
    case done
}

class DetailsViewModel {
    
    private var searchPaarams: [String: String]
    private var searchType: SearchType
    private var albumInfo: AlbumInfoWrapper?
    private var artistDetails: ArtistInfoWrapper?
    private var trackInfo: TrackInfoWrapper?
    
    var status: DetailsViewState = .loading
    
    weak var view: DetailsView?
    
    init(searchPaarams: [String: String], searchType: SearchType) {
        self.searchType = searchType
        self.searchPaarams = searchPaarams
    }
    
    func refreshData() {
        fetchContenst()
    }
    
    private func fetchContenst(){
        switch searchType {
        case .albumSearch:
            fetchAlbumDetails()
            break
        case .artistSearch:
            fetchArtistDetails()
            break
        default:
            fetchTrackDetails()
            break
        }
    }
    
    var imageUrl: String? {
        switch searchType {
        case .albumSearch:
            let imgUrl = albumInfo?.album.image?.first(where: { (im) -> Bool in
                        return im.size == .mega || im.size == .extralarge || im.size == .large
                        })?.text
            return imgUrl
        case .artistSearch:
            let imgUrl = artistDetails?.artist?.image?.first(where: { (im) -> Bool in
                        return im.size == .mega || im.size == .extralarge || im.size == .large
                        })?.text
            return imgUrl
        default:
            let imgUrl = trackInfo?.track?.album?.image.first(where: { (im) -> Bool in
            return im.size == .mega || im.size == .extralarge || im.size == .large
            })?.text
            return imgUrl
        }
    }
    
    var title: String? {
        switch searchType {
        case .albumSearch:
            return albumInfo?.album.name
            
        case .artistSearch:
            return artistDetails?.artist?.name
        default:
            return trackInfo?.track?.name
        }
    }
    
    var subTitle: String? {
        switch searchType {
        case .albumSearch:
            return albumInfo?.album.artist
        case .artistSearch:
            return artistDetails?.artist?.ontour ?? "" == "0" ? "Not in Tour" : "In Tour"
        default:
            return trackInfo?.track?.album?.artist
        }
    }
    
    var listeners: String? {
        switch searchType {
        case .albumSearch:
            return albumInfo?.album.listeners
        case .artistSearch:
            return artistDetails?.artist?.stats?.listeners
        default:
            return trackInfo?.track?.listeners
        }
    }
    
    var playCount: String? {
        switch searchType {
        case .albumSearch:
            return albumInfo?.album.playcount
        case .artistSearch:
            return artistDetails?.artist?.stats?.playcount
        default:
            return trackInfo?.track?.playcount
        }
    }
    
    var wikiContent: String? {
        switch searchType {
        case .albumSearch:
            return albumInfo?.album.wiki?.content
        case .artistSearch:
            return artistDetails?.artist?.bio?.content
        default:
            return trackInfo?.track?.wiki?.content
        }
    }
    
    private func updateViews(){
        view?.setPageDetails(imageUrl: imageUrl, title: title, subTitle: subTitle, listeners: listeners, totalPlayCountr: playCount, wiki: wikiContent)
    }
    
    private func fetchAlbumDetails(){
        let request = LastFmGetAlbumInfo<AlbumInfoWrapper>(params: searchPaarams, success: { [weak self] albumInfo in
            
            guard let strongSelf = self else { return }
            guard let albumInfo = albumInfo else { return }
            strongSelf.albumInfo = albumInfo
            strongSelf.status = .done
             
            strongSelf.updateViews()
             
            }, failure: { [weak self]
                message in
                self?.view?.failureUpdate()
        })
        NetworkService.shared.get(request: request)
    }
    
    private func fetchArtistDetails() {
        
        let request = LastFmGetArtistInfo<ArtistInfoWrapper>(params: searchPaarams, success: { [weak self] artistInfo in
            
            guard let strongSelf = self else { return }
            guard let artistDetails = artistInfo else { return }
            strongSelf.artistDetails = artistDetails
            strongSelf.status = .done
            
            strongSelf.updateViews()

            }, failure: { [weak self]
                message in
                
                self?.view?.failureUpdate()
                
        })
        NetworkService.shared.get(request: request)
    }
    
    private func fetchTrackDetails() {
        let request = LastFmGetTrackInfo<TrackInfoWrapper>(params: searchPaarams, success: { [weak self] trackInfoRes in
            
            guard let strongSelf = self else { return }
            guard let trackInfo = trackInfoRes else { return }
            strongSelf.trackInfo = trackInfo
            strongSelf.status = .done
            
            strongSelf.updateViews()
            
            }, failure: { [weak self]
                message in
                
                self?.view?.failureUpdate()
        })
        NetworkService.shared.get(request: request)
    }
}
