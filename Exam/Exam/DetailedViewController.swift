//
//  DetailedViewController.swift
//  Exam
//
//  Created by Dominic on 08/09/2019.
//  Copyright © 2019 Dominic. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var wvFlag: UIWebView!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCapital: UILabel!
    @IBOutlet var lblPop: UILabel!
    
    var countryFlag = ""
    var countryCode = ""
    var countryName = ""
    var countryCapital = ""
    var countryPop = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCode.text = countryCode
        lblName.text = countryName
        lblCapital.text = countryCapital
        lblPop.text = countryPop
        
        let urlString = countryFlag
        let request: NSURLRequest = NSURLRequest(url: URL(string: urlString)!)
        
        wvFlag?.delegate = self
        wvFlag?.scrollView.isScrollEnabled = false
        wvFlag?.scalesPageToFit = true
        wvFlag?.contentMode = .scaleAspectFit
        wvFlag?.loadRequest(request as URLRequest)
        wvFlag?.backgroundColor = UIColor.clear
    }

    func webViewDidFinishLoad(_ wvFlag: UIWebView) {
        let contentSize = wvFlag.scrollView.contentSize
        let webViewSize = wvFlag.bounds.size
        let scaleFactor = webViewSize.width / contentSize.width
        
        // scale the svg appropriately
        wvFlag.scrollView.minimumZoomScale = scaleFactor
        wvFlag.scrollView.maximumZoomScale = scaleFactor
        wvFlag.scrollView.zoomScale = scaleFactor
    }
}
