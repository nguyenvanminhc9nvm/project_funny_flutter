//
//  ListTileNativeAdFactory.swift
//  Runner
//
//  Created by Miichi on 23/07/2021.
//

import Foundation
// TODO: Import google_mobile_ads
import google_mobile_ads
import UIKit
// TODO: Implement ListTileNativeAdFactory
class ListTileNativeAdFactory : FLTNativeAdFactory{

    @IBOutlet weak var lableA: UILabel!
    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("ListTileNativeAdView", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView

//        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
//
//        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
//        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
//
//        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
//        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
//
//        nativeAdView.callToActionView?.isUserInteractionEnabled = false
//
//        nativeAdView.nativeAd = nativeAd

        return nativeAdView
    }
}
