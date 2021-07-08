//
//  TestUIView.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Anchorage
import Combine

class TestUIView: UIView {
    
    var data : DataModel! {
        didSet {
            self.labelId.text = "\(data.id!)"
            self.labelWeight.text = "Weight: \(data.weight_pounds ?? 0)"
            self.labelPosition.text = "Position: \(data.position!)"
            self.labelHeightInches.text = "Height inches: \(data.height_inches ?? 0)"
            self.labelHeightFeet.text = "Height feet: \(data.height_feet ?? 0)"
            self.labelFirstName.text = data.first_name
            self.labelLastName.text = data.last_name
            self.labelTeam.text = data.team
        }
    }
    
    // MARK: - Architecture properties
    private var cancellables: Set<AnyCancellable> = []
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    // MARK: - UI Properties
    let pageTitle : UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 25)
        title.text = "App test UI"
        title.textAlignment = .center
        return title
    }()
    
    let imageViewPlayer: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "basketball (1)")
        return imageView
    }()
    
    let imageViewTeam: UIImageView = {
        let imageViewTeam = UIImageView()
        imageViewTeam.contentMode = .scaleAspectFit
        imageViewTeam.image = #imageLiteral(resourceName: "logo (1)")
        return imageViewTeam
    }()
    
    let labelFirstName : UILabel = {
        let labelFirstName = UILabel()
        labelFirstName.font = .boldSystemFont(ofSize: 17)
        labelFirstName.textAlignment = .left
        return labelFirstName
    }()
    
    let labelLastName : UILabel = {
        let labelLastName = UILabel()
        labelLastName.font = .boldSystemFont(ofSize: 17)
        labelLastName.textAlignment = .left
        return labelLastName
    }()
    
    let labelHeightFeet : UILabel = {
        let labelHeightFeet = UILabel()
        labelHeightFeet.font = .boldSystemFont(ofSize: 17)
        labelHeightFeet.textAlignment = .left
        return labelHeightFeet
    }()
    
    let labelHeightInches : UILabel = {
        let labelHeightInches = UILabel()
        labelHeightInches.font = .boldSystemFont(ofSize: 17)
        labelHeightInches.textAlignment = .left
        return labelHeightInches
    }()
    
    let labelId : UILabel = {
        let labelId = UILabel()
        labelId.font = .boldSystemFont(ofSize: 40)
        return labelId
    }()
    
    let labelPosition : UILabel = {
        let labelPosition = UILabel()
        labelPosition.font = .boldSystemFont(ofSize: 17)
        labelPosition.textAlignment = .left
        return labelPosition
    }()
    
    let labelWeight : UILabel = {
        let labelWeight = UILabel()
        labelWeight.font = .boldSystemFont(ofSize: 17)
        labelWeight.textAlignment = .left
        return labelWeight
    }()
    
    let labelTeam : UILabel = {
        let labelTeam = UILabel()
        labelTeam.font = .boldSystemFont(ofSize: 17)
        labelTeam.textAlignment = .left
        return labelTeam
    }()

    // >>>>> BUTTON
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Premi qui", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // >>>>> ACTIVITY INDICATOR
    let activityIndicatorLabel : UILabel = {
        let label = UILabel()
        label.text = "Activity indicator"
        return label
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let actIndicator = UIActivityIndicatorView()
        return actIndicator
    }()
    
    let activityIndicatorCountLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    // >>>>> DATE PICKER
    let selectedDate : UILabel = {
        let label = UILabel()
        label.text = "Selected date:"
        return label
    }()
    
    let datePicker : UIDatePicker = {
        // Create a DatePicker
        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 10, y: 50, width: 100, height: 200)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(TestUIViewController.datePickerSelected(_:)), for: .valueChanged)
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()

    // >>>>> PICKER
    let selectedPicker : UILabel = {
        let label = UILabel()
        label.text = "Selected picker:"
        return label
    }()
    
    let picker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    // >>>>> IMAGE PICKER
    let buttonImagePicker : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Galleria", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonImagePickerPressed), for: .touchUpInside)
        return button
    }()
    
    let buttonImagePicker2 : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Galleria + Camera", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonImagePicker2Pressed), for: .touchUpInside)
        return button
    }()
    
    let imageViewPicker: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "default-placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // >>>>> ALERT
    let buttonAlert1 : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Alert 1", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonAlert1), for: .touchUpInside)
        return button
    }()
    
    let buttonAlert2 : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Alert 2", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonAlert2), for: .touchUpInside)
        return button
    }()
    
    // >>>>> COLOR PICKER
    let buttonColorPicker : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Color picker", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonColorPickerPressed), for: .touchUpInside)
        return button
    }()
    
    // >>>>> COLOR WELL
    let colorWell : UIColorWell = {
        let colorWell = UIColorWell(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        colorWell.title = "Color well picker"
        colorWell.addTarget(self, action: #selector(TestUIViewController.colorWellChanged(_:)), for: .valueChanged)
        return colorWell
    }()
    
    // >>>>> FONT PICKER
    let buttonFontPicker : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Font Picker", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.buttonFontPickerPressed), for: .touchUpInside)
        return button
    }()
    
    let fontPickerLabel : UILabel = {
        let label = UILabel()
        label.text = "font picker text"
        return label
    }()
    
    // >>>>> SCROLL VIEW HORIZONTAL + PAGE CONTROL
    let scrollViewHorizontal: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.frame = CGRect(x:0, y:0, width:320,height: 300)
        v.isPagingEnabled = true
        return v
    }()
    
    let stackViewHorizontal : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    let pageControl : UIPageControl = {
        let p = UIPageControl()
        p.frame = CGRect(x:50,y: 300, width:200, height:50)
        p.currentPage = 0
        p.tintColor = UIColor.red
        p.pageIndicatorTintColor = UIColor.black
        p.currentPageIndicatorTintColor = UIColor.green
        return p
    }()

    // >>>>> PROGRESS VIEW
    let progressView : UIProgressView = {
        let progress = UIProgressView()
        return progress
    }()
    
    let progressViewButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Next", for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(TestUIViewController.nextProgressView), for: .touchUpInside)
        return button
    }()

    // >>>>> SEGMENTED CONTROL
    let segmentedControl : UISegmentedControl = {
        let seg = UISegmentedControl(items: ["juve", "milan", "inter"])
        seg.selectedSegmentIndex = 0
        seg.layer.cornerRadius = 5.0
        seg.backgroundColor = UIColor.white
        seg.tintColor = UIColor.systemBlue
        seg.addTarget(self, action: #selector(TestUIViewController.changeSegment), for: .valueChanged)
        return seg
    }()
    
    let segmentedControlImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "234043823-390c6553-ad33-4f97-8606-6d050b73c2a1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // >>>>> SLIDER
    let slider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = UIColor.systemBlue
        slider.addTarget(self, action: #selector(TestUIViewController.sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    let sliderLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    // >>>>> STEPPER
    let stepper : UIStepper = {
        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(TestUIViewController.stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    let stepperLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    // >>>>> SWITCH
    let sw : UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.setOn(true, animated: false)
        sw.addTarget(self, action: #selector(TestUIViewController.switchValueChanged), for: .valueChanged)
        return sw
    }()
    
    let swLabel : UILabel = {
        let label = UILabel()
        label.text = "On"
        return label
    }()
        
    
    // MARK: - Object lifecycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported. Use init(frame:) instead")
    }

    // MARK: - Configure methods

    private func configureUI() {
        backgroundColor = UIColor.white
        // scroll view
        addSubview(scrollView)
        //------------
        scrollView.addSubview(imageViewPlayer)
        scrollView.addSubview(pageTitle)
        scrollView.addSubview(labelId)
        scrollView.addSubview(labelWeight)
        scrollView.addSubview(labelPosition)
        scrollView.addSubview(labelLastName)
        scrollView.addSubview(labelFirstName)
        scrollView.addSubview(imageViewTeam)
        scrollView.addSubview(labelTeam)
        scrollView.addSubview(labelHeightFeet)
        //------------ button
        scrollView.addSubview(button)
        //------------ activity indicator
        scrollView.addSubview(activityIndicatorLabel)
        scrollView.addSubview(activityIndicatorCountLabel)
        scrollView.addSubview(activityIndicator)
        //------------ date picker
        scrollView.addSubview(selectedDate)
        scrollView.addSubview(datePicker)
        //------------ picker
        scrollView.addSubview(selectedPicker)
        scrollView.addSubview(picker)
        //------------ image picker
        scrollView.addSubview(buttonImagePicker)
        scrollView.addSubview(buttonImagePicker2)
        scrollView.addSubview(imageViewPicker)
        //------------ alert
        scrollView.addSubview(buttonAlert1)
        scrollView.addSubview(buttonAlert2)
        //------------ color picker
        scrollView.addSubview(buttonColorPicker)
        //------------ color well
        scrollView.addSubview(colorWell)
        //------------ font picker
        scrollView.addSubview(buttonFontPicker)
        scrollView.addSubview(fontPickerLabel)
        //------------ scroll view horizontal + page control
        scrollViewHorizontal.addSubview(stackViewHorizontal)
        scrollView.addSubview(scrollViewHorizontal)
        scrollView.addSubview(pageControl)
        //------------ progress view
        scrollView.addSubview(progressView)
        scrollView.addSubview(progressViewButton)
        //------------ segmented control
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(segmentedControlImage)
        //------------ slider
        scrollView.addSubview(slider)
        scrollView.addSubview(sliderLabel)
        //------------ stepper
        scrollView.addSubview(stepper)
        scrollView.addSubview(stepperLabel)
        //------------ swicth
        scrollView.addSubview(sw)
        scrollView.addSubview(swLabel)
    }
    
    private func configureConstraints() {
        // scroll view
        scrollView.horizontalAnchors == safeAreaLayoutGuide.horizontalAnchors
        scrollView.verticalAnchors == safeAreaLayoutGuide.verticalAnchors
        // page title
        pageTitle.topAnchor == scrollView.topAnchor
        pageTitle.centerXAnchor == scrollView.centerXAnchor
        pageTitle.heightAnchor == 51
        // image player
        imageViewPlayer.sizeAnchors == CGSize(width: 100, height: 100)
        imageViewPlayer.leadingAnchor == scrollView.leadingAnchor + 10
        imageViewPlayer.topAnchor == pageTitle.bottomAnchor + 10
        // last name
        labelLastName.leadingAnchor == imageViewPlayer.trailingAnchor + 10
        labelLastName.topAnchor == pageTitle.bottomAnchor + 10
        // first name
        labelFirstName.leadingAnchor == labelLastName.leadingAnchor
        labelFirstName.topAnchor == labelLastName.bottomAnchor + 10
        // image team
        imageViewTeam.sizeAnchors == CGSize(width: 20, height: 20)
        imageViewTeam.leadingAnchor == labelLastName.leadingAnchor
        imageViewTeam.topAnchor == labelFirstName.bottomAnchor + 10
        // team
        labelTeam.leadingAnchor == imageViewTeam.trailingAnchor + 10
        labelTeam.topAnchor == labelFirstName.bottomAnchor + 10
        labelTeam.trailingAnchor <= labelId.leadingAnchor
        // id
        labelId.leadingAnchor == labelLastName.trailingAnchor + 10
        labelId.trailingAnchor == scrollView.trailingAnchor - 10
        labelId.topAnchor == pageTitle.bottomAnchor + 10
        // position
        labelPosition.topAnchor == imageViewPlayer.bottomAnchor + 10
        labelPosition.leadingAnchor == imageViewPlayer.leadingAnchor
        // height
        labelHeightFeet.topAnchor == labelPosition.bottomAnchor + 10
        labelHeightFeet.leadingAnchor == imageViewPlayer.leadingAnchor
        // weight
        labelWeight.topAnchor == labelHeightFeet.bottomAnchor + 10
        labelWeight.leadingAnchor == imageViewPlayer.leadingAnchor
        // button
        let sep1 = Separator("BUTTON")
        scrollView.addSubview(sep1.separator)
        sep1.separator.topAnchor == labelWeight.bottomAnchor + 10
        button.widthAnchor == 100
        button.topAnchor == sep1.separator.bottomAnchor + 10
        button.leadingAnchor == imageViewPlayer.leadingAnchor
        // activity indicator
        let sep2 = Separator("ACTIVITY INDICATOR")
        scrollView.addSubview(sep2.separator)
        sep2.separator.topAnchor == button.bottomAnchor + 10
        activityIndicatorLabel.topAnchor == sep2.separator.bottomAnchor + 10
        activityIndicatorLabel.leadingAnchor == imageViewPlayer.leadingAnchor
        activityIndicatorCountLabel.topAnchor == sep2.separator.bottomAnchor + 10
        activityIndicatorCountLabel.leadingAnchor == activityIndicatorLabel.trailingAnchor + 20
        activityIndicator.topAnchor == sep2.separator.bottomAnchor + 10
        activityIndicator.leadingAnchor == activityIndicatorCountLabel.trailingAnchor + 20
        // date picker
        let sep3 = Separator("DATE PICKER")
        scrollView.addSubview(sep3.separator)
        sep3.separator.topAnchor == activityIndicator.bottomAnchor + 10
        selectedDate.topAnchor == sep3.separator.bottomAnchor + 10
        selectedDate.leadingAnchor == imageViewPlayer.leadingAnchor
        datePicker.topAnchor == selectedDate.bottomAnchor + 10
        datePicker.leadingAnchor == imageViewPlayer.leadingAnchor
        // picker
        let sep4 = Separator("PICKER")
        scrollView.addSubview(sep4.separator)
        sep4.separator.topAnchor == datePicker.bottomAnchor + 10
        selectedPicker.topAnchor == sep4.separator.bottomAnchor + 10
        selectedPicker.leadingAnchor == imageViewPlayer.leadingAnchor
        picker.topAnchor == selectedPicker.bottomAnchor + 10
        picker.leadingAnchor == imageViewPlayer.leadingAnchor
        // image picker
        let sep5 = Separator("IMAGE PICKER")
        scrollView.addSubview(sep5.separator)
        sep5.separator.topAnchor == picker.bottomAnchor + 10
        buttonImagePicker.widthAnchor == 300
        buttonImagePicker.topAnchor == sep5.separator.bottomAnchor + 10
        buttonImagePicker.leadingAnchor == imageViewPlayer.leadingAnchor
        buttonImagePicker2.widthAnchor == 300
        buttonImagePicker2.topAnchor == buttonImagePicker.bottomAnchor + 10
        buttonImagePicker2.leadingAnchor == imageViewPlayer.leadingAnchor
        imageViewPicker.sizeAnchors == CGSize(width: 200, height: 200)
        imageViewPicker.topAnchor == buttonImagePicker2.bottomAnchor + 10
        imageViewPicker.leadingAnchor == imageViewPicker.leadingAnchor
        // alert
        let sep6 = Separator("ALERT")
        scrollView.addSubview(sep6.separator)
        sep6.separator.topAnchor == imageViewPicker.bottomAnchor + 10
        buttonAlert1.widthAnchor == 100
        buttonAlert1.topAnchor == sep6.separator.bottomAnchor
        buttonAlert1.leadingAnchor == imageViewPlayer.leadingAnchor
        buttonAlert2.widthAnchor == 100
        buttonAlert2.topAnchor == buttonAlert1.bottomAnchor + 10
        buttonAlert2.leadingAnchor == imageViewPlayer.leadingAnchor
        // color picker
        let sep7 = Separator("COLOR PICKER")
        scrollView.addSubview(sep7.separator)
        sep7.separator.topAnchor == buttonAlert2.bottomAnchor + 10
        buttonColorPicker.widthAnchor == 300
        buttonColorPicker.topAnchor == sep7.separator.bottomAnchor + 10
        buttonColorPicker.leadingAnchor == imageViewPlayer.leadingAnchor
        // color well
        let sep8 = Separator("COLOR WELL PICKER")
        scrollView.addSubview(sep8.separator)
        sep8.separator.topAnchor == buttonColorPicker.bottomAnchor + 10
        colorWell.widthAnchor == 300
        colorWell.topAnchor == sep8.separator.bottomAnchor + 10
        colorWell.leadingAnchor == imageViewPlayer.leadingAnchor
        // font picker
        let sep9 = Separator("FONT PICKER")
        scrollView.addSubview(sep9.separator)
        sep9.separator.topAnchor == colorWell.bottomAnchor + 10
        buttonFontPicker.widthAnchor == 300
        buttonFontPicker.topAnchor == sep9.separator.bottomAnchor + 10
        fontPickerLabel.topAnchor == buttonFontPicker.bottomAnchor + 10
        fontPickerLabel.leadingAnchor == imageViewPlayer.leadingAnchor
        fontPickerLabel.trailingAnchor <= scrollView.trailingAnchor
        // scroll view horizontal + page control (+ stackview in scroll view horizontal)
        let sep10 = Separator("SCROLL VIEW HORIZONTAL")
        scrollView.addSubview(sep10.separator)
        sep10.separator.topAnchor == fontPickerLabel.bottomAnchor + 10
        scrollViewHorizontal.topAnchor == sep10.separator.bottomAnchor + 10
        scrollViewHorizontal.leadingAnchor == imageViewPlayer.leadingAnchor
        scrollViewHorizontal.sizeAnchors == CGSize(width: 300, height: 300)
        // (stackview in scroll view horizontal)
        stackViewHorizontal.edgeAnchors == scrollViewHorizontal.contentLayoutGuide.edgeAnchors
        stackViewHorizontal.heightAnchor == scrollViewHorizontal.frameLayoutGuide.heightAnchor
        // (page control in scroll view horizontal)
        pageControl.topAnchor == stackViewHorizontal.bottomAnchor + 10
        pageControl.leadingAnchor == imageViewPlayer.leadingAnchor
        pageControl.centerXAnchor == scrollView.centerXAnchor
        // progress view
        let sep11 = Separator("PROGRESS VIEW")
        scrollView.addSubview(sep11.separator)
        sep11.separator.topAnchor == pageControl.bottomAnchor + 10
        progressView.topAnchor == sep11.separator.bottomAnchor + 10
        progressView.leadingAnchor == imageViewPlayer.leadingAnchor
        progressView.widthAnchor == 100
        progressViewButton.topAnchor == progressView.bottomAnchor + 10
        progressViewButton.leadingAnchor == imageViewPlayer.leadingAnchor
        progressViewButton.widthAnchor == 100
        // segmented control
        let sep12 = Separator("SEGMENTED CONTROL")
        scrollView.addSubview(sep12.separator)
        sep12.separator.topAnchor == progressViewButton.bottomAnchor + 10
        segmentedControl.topAnchor == sep12.separator.bottomAnchor + 10
        segmentedControl.leadingAnchor == imageViewPlayer.leadingAnchor
        segmentedControlImage.topAnchor == segmentedControl.bottomAnchor + 10
        segmentedControlImage.sizeAnchors == CGSize(width: 200, height: 200)
        segmentedControlImage.leadingAnchor == imageViewPlayer.leadingAnchor
        // slider
        let sep13 = Separator("SLIDER")
        scrollView.addSubview(sep13.separator)
        sep13.separator.topAnchor == segmentedControlImage.bottomAnchor + 10
        slider.topAnchor == sep13.separator.bottomAnchor + 10
        slider.widthAnchor == 200
        slider.leadingAnchor == imageViewPlayer.leadingAnchor
        sliderLabel.leadingAnchor == slider.trailingAnchor + 20
        sliderLabel.topAnchor == sep13.separator.bottomAnchor + 10
        // stepper
        let sep14 = Separator("STEPPER")
        scrollView.addSubview(sep14.separator)
        sep14.separator.topAnchor == slider.bottomAnchor + 10
        stepper.topAnchor == sep14.separator.bottomAnchor + 10
        stepper.leadingAnchor == imageViewPlayer.leadingAnchor
        stepperLabel.leadingAnchor == stepper.trailingAnchor + 10
        stepperLabel.topAnchor == sep14.separator.bottomAnchor + 10
        // switch
        let sep15 = Separator("SWITCH")
        scrollView.addSubview(sep15.separator)
        sep15.separator.topAnchor == stepper.bottomAnchor + 10
        sw.topAnchor == sep15.separator.bottomAnchor + 10
        sw.leadingAnchor == imageViewPlayer.leadingAnchor
        swLabel.leadingAnchor == sw.trailingAnchor + 10
        swLabel.topAnchor == sep15.separator.bottomAnchor + 10
        sw.bottomAnchor == scrollView.bottomAnchor - 30
    }
    
    func appendTeamInScrollHorizontal() -> TeamView {
        let teamView = TeamView(frame: .zero)
        stackViewHorizontal.addArrangedSubview(teamView)
        teamView.widthAnchor /==/ scrollViewHorizontal.frameLayoutGuide.widthAnchor
        return teamView
    }
    
    // MARK: - Update methods
    
    func update(with viewModel: TestUIViewModel) {
        cancellables.forEach { $0.cancel() }
    }

}

class Separator {
    let separator : UILabel = {
        let label = UILabel()
        return label
    }()
    init(_ nameComponent : String) {
        separator.text = "********* \(nameComponent)"
    }
}
