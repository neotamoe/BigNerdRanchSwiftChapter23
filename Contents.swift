//: Playground - noun: a place where people can play

import UIKit

// adding CustomStringConvertible (protocol) makes it so Exercise requires the description property
protocol Exercise: CustomStringConvertible {
    var name: String {get}
    var caloriesBurned: Double {get}
    var minutes: Double {get}
}

// this extension makes Exercise automatically have a description so the two structs below don't need to be changed
extension Exercise {
    var description: String {
        return "Exercise \(name), burned \(caloriesBurned) calories in \(minutes) minutes."
    }
}

struct EllipticalWorkout: Exercise {
    let name = "Elliptical Workout"
    let title = "Workout using the Go Fast Elliptical Trainer 3000"
    let caloriesBurned: Double
    let minutes: Double
}

let ellipticalWorkout = EllipticalWorkout (caloriesBurned: 335, minutes: 30)

struct TreadmillWorkout: Exercise {
    let name = "Treadmill Workout"
    let caloriesBurned: Double
    let minutes: Double
    let laps: Double
}

extension TreadmillWorkout {
    var description: String {
        return "TreadmillWorkout (\(caloriesBurned) calories and \(laps) laps in \(minutes) minutes.)"
    }
}

let runningWorkout = TreadmillWorkout (caloriesBurned: 350, minutes: 25, laps: 10.5)

// this is one way to extend Exercise, but better to write an extension on the Exercise protocol to add a new property
//func caloriesBurnedPerMinute<E: Exercise>(for exercise: E) -> Double {
//    return exercise.caloriesBurned / exercise.minutes
//}
//
//print(caloriesBurnedPerMinute(for: ellipticalWorkout))
//print(caloriesBurnedPerMinute(for: runningWorkout))

extension Exercise {
    var caloriesBurnedPerMinute: Double {
        return caloriesBurned / minutes
    }
}
// protocol extensions can add new computed properties and methods that have implementations, but not add new requirements to the protocol
print(ellipticalWorkout.caloriesBurnedPerMinute)
print(runningWorkout.caloriesBurnedPerMinute)

print(ellipticalWorkout)
print(runningWorkout)

// when writing a protocol extension on Sequence (built-in protocol), you can use a where clause to restrict the protocol extension to only Sequence instances whose Element is a particular type
extension Sequence where Iterator.Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

let mondayWorkout: [Exercise] = [ellipticalWorkout, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())

//careful with naming!
// ellipticalWorkout.title is printing two different things (~ lines 87 & 90)
// be careful when considering writing a protocol extension that adds properties or methods that are not default implementations for requirements of the protocol.  the runtime behavior may not be what you expect if confirming types also implement those same properties and methods.
extension Exercise {
    var title: String {
        return "\(name) - \(minutes) minutes"
    }
}

for exercise in mondayWorkout {
    print(exercise.title)
}

print(ellipticalWorkout.title)