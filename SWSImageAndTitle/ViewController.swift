//
//  ViewController.swift
//  SWSImageAndTitle
//
//  Created by 天机否 on 2018/3/29.
//  Copyright © 2018年 tianjifou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.red.cgColor
        btn.frame = CGRect.init(x: 120, y: 100, width: 20, height: 10)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.titleLabel?.layer.borderColor = UIColor.red.cgColor
        btn.titleLabel?.layer.borderWidth = 1
        self.view.addSubview(btn)
        
        let type: ImageDirection = .verticalBottom
        let distance:CGFloat = 8
        btn.createBtn(type: type, title: "我是谁df发的说法是发的发啊", font: 18, image: UIImage.init(named: "huang_jin_task_myIntegration")!, distance: distance,btnSize: btn.frame.size)
        
        let btnFrame = btn.frame
        let imageSize = btn.imageView!.frame.size
        let imageOrigin = btn.imageView!.frame.origin
        let titleSize = btn.titleLabel!.frame.size
        let titleOrigin = btn.titleLabel!.frame.origin
        print((btnFrame.size.width/2,btnFrame.size.height/2))
        
        switch type {
        case .horizontalLeft:
            print(((imageSize.width + titleSize.width + distance)/2 + imageOrigin.x,btn.imageView?.center.y))
        case .horizontalRight:
            print(((imageSize.width + titleSize.width + distance)/2 + titleOrigin.x,btn.imageView?.center.y))
        case .verticalTop:
            print((btn.imageView?.center.x,(imageSize.height + titleSize.height + distance)/2 + imageOrigin.y))
        case .verticalBottom:
            print((btn.titleLabel?.center.x,(imageSize.height + titleSize.height + distance)/2 + titleOrigin.y))
        }
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//定制UIButton内的tittle和image的排版
//以image的位置判断，分别为左右上下
enum ImageDirection {
    case horizontalLeft,horizontalRight,verticalTop,verticalBottom
}
extension UIButton {
    /// 居中调整btn内title和image的位置
    ///
    /// - Parameters:
    ///   - type: image相对于title的方向
    ///   - title: 内容文字
    ///   - font: 内容文字字号
    ///   - image: 图片
    ///   - distance: 文字与图片间隔
    ///   - btnSize: btn尺寸(当在水平方向文字内容长度加上图片宽度超过btn宽度时，需要增加btn区域宽度)
    func createBtn(type:ImageDirection,title:String,font:CGFloat,image:UIImage,distance:CGFloat,btnSize:CGSize){
        self.setImage(image, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
        let titleWidth = title.width(font: UIFont.systemFont(ofSize: font))
        let titleHeight = title.height(font: UIFont.systemFont(ofSize: font))
        let imageWidth = image.size.width
        let imageHeight = image.size.height
    
        //UIEdgeInsetsMake 默认为(0, 0, 0, 0)/(top，left，bottom，right)，显示的是image在左边，title在右边
        //水平移动规律，x = (-left-right)/2+left ,向左移动x距离
        //位置相对变化方向与UIEdgeInsetsMake相对应的方向位置的值负相关，相反方向位置的值正相关
        //contentEdgeInsets 作用是为了扩大btn的有效区域防止title和image超过btn规定区域后被压缩
        switch type {
        case .horizontalLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -distance/2, 0, distance/2)
            self.titleEdgeInsets = UIEdgeInsetsMake(0, distance/2, 0, -distance/2)
            self.contentEdgeInsets = UIEdgeInsetsMake(-max(btnSize.height,max(titleHeight,imageHeight)), -max(btnSize.width,titleWidth+imageWidth+distance), -max(btnSize.height,max(titleHeight,imageHeight)), -max(btnSize.width,titleWidth+imageWidth+distance))
        case .horizontalRight:
            self.contentEdgeInsets = UIEdgeInsetsMake(-max(btnSize.height,max(titleHeight,imageHeight)), -max(btnSize.width,titleWidth+imageWidth+distance), -max(btnSize.height,max(titleHeight,imageHeight)), -max(btnSize.width,titleWidth+imageWidth+distance))
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+distance/2, 0, -(titleWidth+distance/2))
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth+distance/2), 0, imageWidth+distance/2)
            
        case .verticalTop:
            self.contentEdgeInsets = UIEdgeInsetsMake(-max(btnSize.height,titleHeight+imageHeight+distance), -max(btnSize.width,max(titleWidth,imageWidth)), -max(btnSize.height,titleHeight+imageHeight+distance), -max(btnSize.width,max(titleWidth,imageWidth)))
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleHeight+distance)/2, titleWidth/2, (titleHeight+distance)/2, -titleWidth/2)
            self.titleEdgeInsets = UIEdgeInsetsMake((imageHeight+distance)/2, -imageWidth/2, -(imageHeight+distance)/2, imageWidth/2)
        case .verticalBottom:
             self.contentEdgeInsets = UIEdgeInsetsMake(-max(btnSize.height,titleHeight+imageHeight+distance), -max(btnSize.width,max(titleWidth,imageWidth)), -max(btnSize.height,titleHeight+imageHeight+distance), -max(btnSize.width,max(titleWidth,imageWidth)))
            self.imageEdgeInsets = UIEdgeInsetsMake((titleHeight+distance)/2, titleWidth/2, -(titleHeight+distance)/2, -titleWidth/2)
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageHeight+distance)/2, -imageWidth/2, (imageHeight+distance)/2, imageWidth/2)
            
        }
        
        
}
}
public extension String {
    
    public func height(width: CGFloat = CGFloat.greatestFiniteMagnitude, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedStringKey.font: font]
        return height(width: width, attributes: attributes)
    }
    
    public func height(width: CGFloat = CGFloat.greatestFiniteMagnitude, attributes: [NSAttributedStringKey : Any]) -> CGFloat {
        if isEmpty || width == 0 {
            return 0
        }
        var attributeArr = attributes
        if let paragraphStyle = attributeArr[NSAttributedStringKey.paragraphStyle] as? NSMutableParagraphStyle {
            if paragraphStyle.lineBreakMode != .byWordWrapping && paragraphStyle.lineBreakMode != .byCharWrapping {
                paragraphStyle.lineBreakMode = .byWordWrapping
            }
            attributeArr[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        }
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributeArr, context: nil)
        return rect.height
    }
    
    public func width(height: CGFloat = CGFloat.greatestFiniteMagnitude, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedStringKey.font: font]
        return width(height: height, attributes: attributes)
    }
    
    public func width(height: CGFloat = CGFloat.greatestFiniteMagnitude, attributes: [NSAttributedStringKey: Any]?) -> CGFloat {
        if isEmpty || height == 0 {
            return 0
        }
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributes, context: nil)
        return rect.width
    }
    
}
