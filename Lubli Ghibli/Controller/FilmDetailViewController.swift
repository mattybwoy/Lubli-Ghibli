//
//  SearchResultsController.swift
//  Lubli Ghibli
//
//  Created by Matt Lock on 14/10/2021.
//

import UIKit
import Nuke
import SafariServices

class FilmDetailViewController: UIViewController {
    
    private let film: Film
    @IBOutlet var filmYear: UILabel!
    @IBOutlet var filmTitle: UILabel!
    @IBOutlet var filmDirector: UILabel!
    @IBOutlet var filmDescriptionLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var filmDescription: UITextView!
    @IBOutlet var runtime: UILabel!
    @IBOutlet var imdbLink: UIButton!
    
    let fontName = "AvantGarde-Medium"
    
    private let contentView = UIView()
    
    init(film: Film) {
        self.film = film
        super.init(nibName: "FilmDetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        navigationController?.navigationBar.tintColor = .darkGray
        title = film.title
        filmTitle.font = UIFont.boldSystemFont(ofSize: 22)
        filmTitle.font = UIFont(name: fontName, size: 20)
        filmTitle.text = film.title

        filmTitle.sizeToFit()
        filmYear.font = UIFont(name: fontName, size: 14)
        filmYear.text = film.release_date
        filmDirector.font = UIFont(name: fontName, size: 15)
        filmDirector.text = film.director
        filmDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        filmDescriptionLabel.font = UIFont(name: fontName, size: 18)
        filmDescriptionLabel.text = "Description"
        filmDescription.font = UIFont(name: fontName, size: 14)
        filmDescription.text = film.description
        runtimeLabel.text = "Runtime"
        runtimeLabel.font = UIFont(name: fontName, size: 14)
        runtime.font = UIFont(name: fontName, size: 14)
        runtime.text = String(film.runtime)
        imdbLink.setTitle("Go to IMDB" , for: .normal)
        imdbLink.setTitleColor(.systemBlue, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewSafeAreaInsetsDidChange()
        contentView.frame = CGRect(x: 0, y: 90, width: view.frame.size.width, height: 315)
        
        let imageView = UIImageView(frame: CGRect(x: (view.frame.size.width-180)/2, y: (contentView.frame.size.height-250)/2, width: 180, height: 250))
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        Nuke.loadImage(with: URL(string: self.film.image)!, into: imageView)
        contentView.addSubview(imageView)
        
        let backgroundImageView = UIImageView(frame: contentView.bounds)
        backgroundImageView.contentMode = .scaleToFill
        contentView.addSubview(backgroundImageView)

        Nuke.loadImage(with: URL(string: self.film.image)!, into: backgroundImageView)
        contentView.sendSubviewToBack(backgroundImageView)
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = contentView.bounds
        contentView.addSubview(blurView)
        
        contentView.sendSubviewToBack(blurView)
        contentView.sendSubviewToBack(backgroundImageView)
    }
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func imdbButtonTapped(_ sender: UIButton) {
        if let url = URL(string: film.imdb_link) {
            let sfSafariVC = SFSafariViewController(url: url)
            present(sfSafariVC, animated: true)
        }
    }
    
}
