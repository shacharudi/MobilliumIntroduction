//
//  IntroductionConfig.swift
//  MobilliumIntroduction
//
//  Created by Ahmet İmirze on 12.04.2022.
//

import UIKit

// MARK: - IntroductionConfig
public struct IntroductionConfig {
    
    let contents: [Content]
    let skipButton: SkipButton
    let pageControl: PageControl
    let nextButton: NextButton
    
    public init(contents: [Content] =
                [
                    Content(style: .topImageCenterAlignedText),
                    Content(style: .topImageLeftAlignedText),
                    Content(style: .bottomImageCenterAlignedText),
                    Content(style: .bottomImageLeftAlignedText)
                ],
                skipButton: SkipButton = SkipButton(),
                pageControl: PageControl = PageControl(),
                nextButton: NextButton = NextButton()) {
        self.contents = contents
        self.skipButton = skipButton
        self.pageControl = pageControl
        self.nextButton = nextButton
    }
}

// MARK: - IntroductionContentStyle
extension IntroductionConfig {
    
    public enum ContentStyle: CaseIterable {
        case topImageCenterAlignedText
        case topImageLeftAlignedText
        case bottomImageCenterAlignedText
        case bottomImageLeftAlignedText
    }
}

// MARK: - IntroductionContent
extension IntroductionConfig {
    
    public struct Content {
        let title: Title
        let description: Description
        let image: Image
        let style: ContentStyle
        
        public init(title: Title = Title(),
                    description: Description = Description(),
                    image: Image = Image(),
                    style: ContentStyle = .topImageCenterAlignedText) {
            self.title = title
            self.description = description
            self.image = image
            self.style = style
        }
    }
}

// MARK: - IntroductionImage
extension IntroductionConfig {
    
    public struct Image {
        
        /// Image, default `Rocket`
        let image: UIImage?
        
        /// Image contentMode, default `.scaleAspectFit`
        let contentMode: UIView.ContentMode
        
        /// Background color, `optional`
        let backgroundColor: UIColor?
        
        /// Tint color, `optional`
        let tintColor: UIColor?
        
        public init(image: UIImage? = nil,
                    contentMode: UIView.ContentMode = .scaleAspectFit,
                    backgroundColor: UIColor? = nil,
                    tintColor: UIColor? = nil) {
            self.image = image
            self.contentMode = contentMode
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
        }
    }
}

// MARK: - IntroductionTitle
extension IntroductionConfig {
    
    public struct Title {
        
        /// Title Text, default `Title`
        let text: String
        
        /// Title Text font, default `.systemFont(ofSize: 24.0, weight: .semibold)`
        let font: UIFont
        
        /// Title Text color, default `UIColor(red: 41.0 / 255.0, green: 50.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)`
        let textColor: UIColor
        
        /// The technique to use for wrapping and truncating the label’s text, default value is `.byClipping`
        let lineBreakMode: NSLineBreakMode
        
        /// Title attributedText, if set, the label ignores the properties above. default `nil`
        let attributedText: NSAttributedString?
        
        /// The maximum number of lines to use for rendering text, default valie is `0`
        let numberOfLines: Int
        
        public init(text: String = "Title",
                    font: UIFont = .systemFont(ofSize: 24.0, weight: .semibold),
                    textColor: UIColor = UIColor(red: 41.0 / 255.0, green: 50.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0),
                    lineBreakMode: NSLineBreakMode = .byClipping,
                    numberOfLines: Int = 0,
                    attributedText: NSAttributedString? = nil) {
            self.text = text
            self.font = font
            self.textColor = textColor
            self.lineBreakMode = lineBreakMode
            self.numberOfLines = numberOfLines
            self.attributedText = attributedText
        }
    }
}

// MARK: - IntroductionDescription
extension IntroductionConfig {
    
    public struct Description {
        
        /// Description Text
        let text: String
        
        /// Description Text font, default `.systemFont(ofSize: 14.0, weight: .medium)`
        let font: UIFont
        
        /// Description Text color, default `UIColor(red: 108.0 / 255.0, green: 107.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0)`
        let textColor: UIColor
        
        /// The technique to use for wrapping and truncating the label’s text, default value is `.byClipping`
        let lineBreakMode: NSLineBreakMode
        
        /// Description attributedText, if set, the label ignores the properties above. default `nil`
        let attributedText: NSAttributedString?
        
        /// The maximum number of lines to use for rendering text, default valie is `0`
        let numberOfLines: Int
        
        public init(text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    font: UIFont = .systemFont(ofSize: 14.0, weight: .medium),
                    textColor: UIColor = UIColor(red: 108.0 / 255.0, green: 107.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0),
                    lineBreakMode: NSLineBreakMode = .byClipping,
                    numberOfLines: Int = 0,
                    attributedText: NSAttributedString? = nil) {
            self.text = text
            self.font = font
            self.textColor = textColor
            self.lineBreakMode = lineBreakMode
            self.numberOfLines = numberOfLines
            self.attributedText = attributedText
        }
    }
}

extension IntroductionConfig {
    public struct AdditionalStyle {
        let backgroundColor: UIColor
        let borderRadius: CGFloat
        let borderColor: UIColor
        let borderWidth: CGFloat
        
        public init(backgroundColor: UIColor, borderRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
            self.backgroundColor = backgroundColor
            self.borderRadius = borderRadius
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }
    }
}

// MARK: - IntroductionSkipButton
extension IntroductionConfig {
        
    public struct SkipButton {
        
        /// Button title, default `Skip`
        let title: String
        
        /// Button attributedTitle, default `nil`
        let attributedTitle: NSAttributedString?
        
        /// Button isHidden, default `false`
        let isHidden: Bool
        
        /// Button isHidden when last content shown, default `true`
        let isSkipButtonHiddenWhenLastContentShown: Bool
        
        /// Button title font, default `.systemFont(ofSize: 13.0, weight: .medium)`
        let font: UIFont
        
        /// Button title color, default `UIColor(red: 108.0 / 255.0, green: 107.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0)`
        let titleColor: UIColor
        
        let additionalStyle: AdditionalStyle?
        
        public init(title: String = "Skip",
                    attributedTitle: NSAttributedString? = nil,
                    isHidden: Bool = false,
                    isSkipButtonHiddenWhenLastContentShown: Bool = true,
                    font: UIFont = .systemFont(ofSize: 13.0, weight: .medium),
                    titleColor: UIColor = UIColor(red: 108.0 / 255.0, green: 107.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0),
                    additionlStyle: AdditionalStyle? = nil) {
            self.title = title
            self.attributedTitle = attributedTitle
            self.isHidden = isHidden
            self.isSkipButtonHiddenWhenLastContentShown = isSkipButtonHiddenWhenLastContentShown
            self.font = font
            self.titleColor = titleColor
            self.additionalStyle = additionlStyle
        }
    }
}

// MARK: - IntroductionNextButton
extension IntroductionConfig {
    
    public struct NextButton {
        
        /// Button title, default `Next`
        let title: String
        
        /// Button attributedTitle, default `nil`
        let attributedTitle: NSAttributedString?
        
        /// Button last content title, default `OK`
        let lastTitle: String
        
        /// Button lastAttributedTitle, default `nil`
        let lastAttributedTitle: NSAttributedString?
        
        /// Button isHidden, default `false`
        let isHidden: Bool
        
        /// Button title font, default `.systemFont(ofSize: 14.0, weight: .bold)`
        let font: UIFont
        
        /// Button title color, default `.white`
        let titleColor: UIColor
        
        /// Button background color, default `UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)`
        let backgroundColor: UIColor
        
        /// Button layer.cornerRadius, default `16.0`
        let cornerRadius: CGFloat
        
        public init(title: String = "Next",
                    attributedTitle: NSAttributedString? = nil,
                    lastTitle: String = "OK",
                    lastAttributedTitle: NSAttributedString? = nil,
                    isHidden: Bool = false,
                    font: UIFont = .systemFont(ofSize: 14.0, weight: .bold),
                    titleColor: UIColor = .white,
                    backgroundColor: UIColor = UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0),
                    cornerRadius: CGFloat = 16.0) {
            self.title = title
            self.attributedTitle = attributedTitle
            self.lastTitle = lastTitle
            self.lastAttributedTitle = lastAttributedTitle
            self.isHidden = isHidden
            self.font = font
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
        }
    }
}

// MARK: - IntroductionPageControl
extension IntroductionConfig {

    public struct PageControl {
        
        /// PageControl currentPageIndicatorTintColor, default `UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)`
        let currentPageIndicatorTintColor: UIColor
        
        /// PageControl pageIndicatorTintColor, default `UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.4)`
        let pageIndicatorTintColor: UIColor
        
        /// PageControl isHidden, default `false`
        let isHidden: Bool
        
        public init(currentPageIndicatorTintColor: UIColor = UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0),
                    pageIndicatorTintColor: UIColor = UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.4),
                    isHidden: Bool = false) {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
            self.pageIndicatorTintColor = pageIndicatorTintColor
            self.isHidden = isHidden
        }
    }
}
