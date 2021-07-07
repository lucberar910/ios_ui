//
//  TestUIViewController.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

protocol TestUICoordinableProtocol: AnyObject {
    // Declare here the routes the Coordinator must implement
}

class TestUIViewController: UIViewController, Coordinable {
    
    typealias CoordinatorType = TestUICoordinableProtocol
    typealias ViewModelType = TestUIViewModel
    
    // MARK: - Architecture properties
    var count = 3
    let pickerData = ["English", "Maths", "History", "German", "Science"]
    var imgPickerController = UIImagePickerController()
    let colorPickerController = UIColorPickerViewController()
    let colorWell = UIColorWell()
    let fontPickerController = UIFontPickerViewController()
    
    weak var coordinator: TestUICoordinableProtocol?
    var viewModel: TestUIViewModel {
        didSet {
            configureBinds()
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Business properties
    
    // MARK: - UI properties

    var _view: TestUIView {
        guard let view = view as? TestUIView else { preconditionFailure("Unable to cast view to TestUIView")}
        return view
    }

    // MARK: - Object lifecycle
    
    required init(coordinator: TestUICoordinableProtocol, viewModel: TestUIViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init() {
        fatalError("init() has not been implemented. Use init(coordinator:viewModel:)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(coordinator:viewModel:)")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented. Use init(coordinator:viewModel:)")
    }
    
    // MARK: - View lifecycle

    override func loadView() {
        view = TestUIView.init(frame: navigationController?.view.bounds ?? .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBinds()
        viewModel.getData()
        startActivityIndicatorAnimating()
    }
    
    // MARK: - Configure methods
    
    private func configureUI() {
        // picker
        _view.picker.dataSource = self
        _view.picker.delegate = self
        // image picker
        self.imgPickerController.delegate = self;
        self.imgPickerController.allowsEditing = false
        self.imgPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary // .camera
        // color picker
        self.colorPickerController.delegate = self
        // font picker
        self.fontPickerController.delegate = self
    }
    
    private func configureBinds() {
        cancellables.forEach { $0.cancel() }
        _view.update(with: viewModel)
        
        viewModel.data.sink { [weak self] data in
            self?._view.data = data
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Private methods
    @objc func buttonPressed() {
        let a = UIAlertController(title: "Attenzione", message: "Errore", preferredStyle: .alert)
                            a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(a, animated: true, completion: nil)
    }
    
    @objc func datePickerSelected(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" //"MM/dd/yyyy hh:mm a"
        _view.selectedDate.text = "Selected date: \(dateFormatter.string(from: sender.date))"
    }

}


// >>>>> ACTIVITY INDICATOR
extension TestUIViewController {
    func startActivityIndicatorAnimating(){
        _view.activityIndicator.startAnimating()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        _view.activityIndicatorCountLabel.text = "\(count)"
        if(count > 0) {
            count-=1
        } else {
            self._view.activityIndicator.stopAnimating()
        }
    }
}

// >>>>> PICKER
extension TestUIViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = pickerData[row]
        return item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = pickerData[row]
        _view.selectedPicker.text = "Selected picker: \(item)"
    }
}

// >>>>> IMAGE PICKER - GALLERY
extension TestUIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func buttonImagePickerPressed() {
        self.present(self.imgPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                        print("l'elemento selezionato non è un'immagine")
                        return
            }
            _view.imageViewPicker.image = selectedImage
            dismiss(animated: true, completion: nil)
    }
}

// >>>>> IMAGE PICKER - GALLERY + CAMERA
extension TestUIViewController {
    @objc func buttonImagePicker2Pressed() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.imgPickerController.sourceType = UIImagePickerController.SourceType.camera
            self.present(self.imgPickerController, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary(){
        self.present(self.imgPickerController, animated: true, completion: nil)
    }
}

// >>>>> ALERT
extension TestUIViewController {
    @objc func buttonAlert1() {
        let a = UIAlertController(title: "Titolo alert", message: "Messaggio alert", preferredStyle: .alert)
                            a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(a, animated: true, completion: nil)
    }
    
    @objc func buttonAlert2() {
        let ac = UIAlertController(title: "Nuovo corso", message: "Inserisci il nome del corso", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        let ok = UIAlertAction(title: "Crea", style: .default) { (ok) in
//            ac.textFields![0].text! --> testo inserito
        }
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}


// >>>>> COLOR PICKER
extension TestUIViewController : UIColorPickerViewControllerDelegate{
    @objc func buttonColorPickerPressed() {
        self.present(self.colorPickerController, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        _view.scrollView.backgroundColor = viewController.selectedColor
    }
    
//    Called on every color selection done in the picker.
//    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
//        self.view.backgroundColor = viewController.selectedColor
//    }
}

// >>>>> COLOR WELL
extension TestUIViewController {
    @objc func colorWellChanged(_ sender: Any) {
        _view.scrollView.backgroundColor = _view.colorWell.selectedColor
    }
}

// >>>>> FONT PICKER
extension TestUIViewController: UIFontPickerViewControllerDelegate {
    @objc func buttonFontPickerPressed(){
        present(self.fontPickerController, animated: true, completion: nil)
    }
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        guard let descriptor = viewController.selectedFontDescriptor else { return }

        let font = UIFont(descriptor: descriptor, size: 36)
        _view.fontPickerLabel.font = font
    }
}
