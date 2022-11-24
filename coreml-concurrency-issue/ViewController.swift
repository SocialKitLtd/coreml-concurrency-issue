//
//  ViewController.swift
//  coreml-concurrency-issue
//
//  Created by Roi Mulia on 24/11/2022.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let parallelTaskCount = 3
        
        for i in 0...parallelTaskCount - 1 {
            DispatchQueue.global(qos: .userInteractive).async {
                let image = UIImage(named: "image.jpg")!
                self.runPrediction(index: i, image: image, shouldAddContuter: true)
            }
        }
    }

    
    func runPrediction(index: Int, image: UIImage, shouldAddContuter: Bool = false) {
        let conf = MLModelConfiguration()
        conf.computeUnits = .cpuAndGPU
        conf.allowLowPrecisionAccumulationOnGPU = true
        
        let myModel = try! MyModel(configuration: conf)
        let myModelInput = try! MyModelInput(LR_inputWith: image.cgImage!)
        // Prediction
        let predicition = try! myModel.prediction(input: myModelInput)
        print("finished proccessing \(index)")
    }
    
}

