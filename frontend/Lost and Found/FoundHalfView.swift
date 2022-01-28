//
//  File.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/21/21.
//
//This class is never used? It is just an attempt to show half screen things.
import Foundation
import UIKit
class FoundHalfView : UIPresentationController{
    override var frameOfPresentedViewInContainerView: CGRect{
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 2/3 ), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 2.7/3))
    }
}
