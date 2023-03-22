import Foundation
//  Created by Alexander Matheson
//  Created on 2023-Mar-21
//  Version 1.0
//  Copyright (c) 2023 Alexander Matheson. All rights reserved.
//
//  This program calculates the mean, median, and mode of an array.

func calcMean(numbers: [Int]) -> Double {
  // Variables for function.
  var sum = 0.0
  var mean = 0.0

  // Add all elements in array.
  for element in numbers {
    sum = sum + Double(element)
  }

  // Divide by length of array.
  mean = sum / Double(numbers.count)
  return mean
}

func calcMedian(numbers: [Int]) -> Double {
  // Variables for function
  var median = 0.0
  var num1 = 0.0
  var num2 = 0.0

  // Determine if array size is even or odd.
  if numbers.count % 2 == 0 {
    num1 = Double(numbers[numbers.count / 2])
    num2 = Double(numbers[numbers.count / 2 - 1])
    median = (num1 + num2) / 2.0;
  } else {
    median = Double(numbers[numbers.count / 2])
  }
  return median
}

func calcMode(numbers: [Int]) -> [Int] {
  // Variables and lists for function.
  var modesList: [Int] = []
  var count = 0
  var maxCount = 0
  var positionCount = 0

  // Compare numbers to all in array and check for repeats.
  for position in numbers {
    count = 0
    for compare in numbers {
      if compare == position {
        count = count + 1
      }
    }

    // Compare number of repeats with previous number of repeats.
    if count > maxCount {
      maxCount = count
      modesList.removeAll()
      modesList.append(position)
    } else if count == maxCount {
      modesList.append(position)
    }
  }

  // Remove repetition.
  if modesList.count > 1 {
    var positionInModes = 1
    while positionInModes < modesList.count {
      if modesList[positionInModes] == modesList[positionInModes - 1] {
        modesList.remove(at: positionInModes)
      } else {
        positionInModes = positionInModes + 1
      }
    }
  }

  // Convert list to array of perpetually consistent length.
  var modes = [Int](repeating: 0, count: modesList.count)
  for position in modesList {
    modes[positionCount] = Int(position)
    positionCount = positionCount + 1
  }
  return modes
}

// Declare variables.
var counter = 0

// Define the input and output file paths.
// Write name of file to read.
let inputFile = "Unit1-07-set3.txt"
let outputFile = "output.txt"

// Open the input file for reading.
guard let input = FileHandle(forReadingAtPath: inputFile) else {
  print("Error: Cannot open input file.")
  exit(1)
}

// Open the output file for writing.
guard let output = FileHandle(forWritingAtPath: outputFile) else {
  print("Error: Cannot open output file.")
  exit(1)
}

// Read the contents of the input file.
let inputData = input.readDataToEndOfFile()

// Convert the data to a string.
guard let inputString = String(data: inputData, encoding: .utf8) else {
  print("Error: Cannot convert input data to string.")
  exit(1)
}

// Split the file into lines.
let numList = inputString.components(separatedBy: .newlines)

// Convert to int.
var numArr = [Int](repeating: 0, count: numList.count)
for position in numList {
  numArr[counter] = Int(position)!
  counter = counter + 1
}

// Sort the array.
numArr.sort()

// Call functions for math.
let mean = calcMean(numbers: numArr)
let median = calcMedian(numbers: numArr)
let mode = calcMode(numbers: numArr)

// Print results.
print("Mean:", mean)
print("Median:", median)
print("Mode:", mode)

// Write results to output 
let meanString = "Mean: \(mean)\n"
let medianString = "Median: \(median)\n"
let modeString = "Mode: \(mode)\n"
output.write(meanString.data(using: .utf8)!)
output.write(medianString.data(using: .utf8)!)
output.write(modeString.data(using: .utf8)!)


// Close the files.
input.closeFile()
output.closeFile()
