//
//  DetailsView.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class DetailsView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private var topLeftImageView: UIImageView!
    private var vStackDetailsView: UIStackView!
    private var hListernersStackView: UIStackView!
    private var hListernersStackViewConstraint_Height: NSLayoutConstraint!
    private var scrollViewContainer: UIView!
    private var wiki: UILabel!
    weak var viewModel: DetailsViewModel?
    
    convenience init(viewModel: DetailsViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        setupViews()
        self.viewModel?.refreshData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //Custom View - build view hierarcy
    private func setupViews() {
        let view = self
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        view.addConstraint(activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        view.addConstraint(activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        scrollViewContainer = UIView()
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        setTopLeftAlbumImageView()
        detailsStackView()
        listenersHorizStackView()
        wikiLabel()
        
        guard let stats = viewModel?.status else {
            return
        }
        if stats == .loading {
            activityIndicator.startAnimating()
        }
        
    }
    
    private func setTopLeftAlbumImageView(){
        topLeftImageView = UIImageView()
        topLeftImageView.translatesAutoresizingMaskIntoConstraints = false
        topLeftImageView.image = UIImage()
        topLeftImageView.backgroundColor = .white
        topLeftImageView.contentMode = .scaleAspectFit
        scrollViewContainer.addSubview(topLeftImageView)
        
        topLeftImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.3).isActive = true
        topLeftImageView.heightAnchor.constraint(equalTo: topLeftImageView.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
        topLeftImageView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16).isActive = true
        topLeftImageView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: 16).isActive = true
    }
    
    private func detailsStackView(){
        vStackDetailsView = UIStackView()
        vStackDetailsView.axis = .vertical
        vStackDetailsView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.addSubview(vStackDetailsView)
        vStackDetailsView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: 16).isActive = true
        vStackDetailsView.leadingAnchor.constraint(equalTo: topLeftImageView.trailingAnchor, constant: 16).isActive = true
        vStackDetailsView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16).isActive = true
        vStackDetailsView.heightAnchor.constraint(lessThanOrEqualTo: topLeftImageView.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    private func listenersHorizStackView() {
        hListernersStackView = UIStackView()
        hListernersStackView.axis = .horizontal
        hListernersStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.addSubview(hListernersStackView)
        hListernersStackViewConstraint_Height = hListernersStackView.heightAnchor.constraint(equalToConstant: 50)
        hListernersStackViewConstraint_Height.isActive = true
        hListernersStackView.leadingAnchor.constraint(equalTo: topLeftImageView.leadingAnchor, constant: 0).isActive = true
        hListernersStackView.trailingAnchor.constraint(equalTo: vStackDetailsView.trailingAnchor).isActive = true
        hListernersStackView.topAnchor.constraint(equalTo: topLeftImageView.bottomAnchor, constant: 16).isActive = true
        hListernersStackView.alignment = .center
        hListernersStackView.distribution = .fillEqually
        hListernersStackView.spacing = 8.0
    }
    
    private func wikiLabel(){
        wiki = UILabel()
        wiki.translatesAutoresizingMaskIntoConstraints = false
        wiki.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        scrollViewContainer.addSubview(wiki)
        wiki.numberOfLines = 0
        wiki.lineBreakMode = .byWordWrapping
        wiki.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16).isActive = true
        wiki.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16).isActive = true
        wiki.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor, constant: -16).isActive = true
        wiki.topAnchor.constraint(equalTo: hListernersStackView.bottomAnchor, constant: 16).isActive = true
    }
    
    private func addVInStack(stackView: UIStackView, view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    private func getLabel(withText: String) -> UILabel{
        let l = UILabel()
        l.text = withText
        return l
    }
    
    private func removeViewsFromStacks(sv: UIStackView){
        sv.arrangedSubviews.forEach { (v) in
            sv.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
    }
    
    func setPageDetails(imageUrl: String?, title: String?, subTitle: String?, listeners: String?, totalPlayCountr: String?, wiki: String?){
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.removeViewsFromStacks(sv: strongSelf.vStackDetailsView)
            
            if let albName = title {
                strongSelf.addVInStack(stackView: strongSelf.vStackDetailsView, view: strongSelf.getLabel(withText: albName))
            }
            
            if let artistName = subTitle {
                strongSelf.addVInStack(stackView: strongSelf.vStackDetailsView, view: strongSelf.getLabel(withText: artistName))
            }
            
            strongSelf.removeViewsFromStacks(sv: strongSelf.hListernersStackView)
            
            if let lners = listeners {
                strongSelf.addVInStack(stackView: strongSelf.hListernersStackView, view: strongSelf.getLabel(withText: "Listeners : " + lners))
            }
            if let pcount = totalPlayCountr {
                strongSelf.addVInStack(stackView: strongSelf.hListernersStackView, view: strongSelf.getLabel(withText: "Played : " + pcount))
            }
            if let wt = wiki {
                strongSelf.wiki.text = "WIKI: \n\n" + wt
            }
            strongSelf.setImage(url: imageUrl)
            strongSelf.activityIndicator.hidesWhenStopped = true
            strongSelf.activityIndicator.stopAnimating()
        }
        
        
        
    }
    
    func failureUpdate(){
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeViewsFromStacks(sv: strongSelf.hListernersStackView)
            let label = strongSelf.getLabel(withText: "Unable to fetch details!!")
            label.textAlignment = .center
            strongSelf.hListernersStackView.addArrangedSubview(label)
            strongSelf.activityIndicator.hidesWhenStopped = true
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    private func setImage(url: String?) {
        if let unwrappedString = url, let urlObj = URL(string: unwrappedString){
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "placeholder"),
                transition: .fadeIn(duration: 0.33)
            )
            DispatchQueue.main.async {
                Nuke.loadImage(with: urlObj, options: options, into: self.topLeftImageView)
            }
        }
    }
    
}
