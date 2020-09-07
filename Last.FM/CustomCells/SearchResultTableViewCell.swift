//
//  SearchResultTableViewCell.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/6/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit
import Nuke


class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var albArtistImageView: UIImageView!
    @IBOutlet private weak var albArtisttitleLabel: UILabel!
    @IBOutlet private weak var albArtistSubtitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albArtistImageView.image = nil
        albArtisttitleLabel.text = nil
        albArtistSubtitleLabel.text = nil
    }
    
    func configureData(imageUrl: String, albArtist: String?, albArtistSub: String?) {
        albArtisttitleLabel.text = albArtist
        albArtistSubtitleLabel.text = albArtistSub
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.33)
        )
        guard let loadableUrl = URL.init(string: imageUrl) else {
            return
        }
        Nuke.loadImage(with: loadableUrl, options: options, into: albArtistImageView)
    }
}
