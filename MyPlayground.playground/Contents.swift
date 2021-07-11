import SwiftUI
import PlaygroundSupport

extension UIColor {
    var hsba: (hue: CGFloat, sat: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alp: CGFloat = 0
        getHue(&hue, saturation: &sat, brightness: &bri, alpha: &alp)
        return (hue, sat, bri, alp)
    }
}

func interpolate(_ color1: UIColor, color2: UIColor) -> UIColor {
    let hsba1 = color1.hsba
    let hsba2 = color2.hsba

    let firstDegree = hsba1.hue * 360
    let secondDegree = hsba2.hue * 360

    let diff = abs(firstDegree - secondDegree) //   30     240
    let shortestDist = min(diff, 360 - diff) //     30     120
    let largest = max(firstDegree, secondDegree) // 60     240
    let smallest = min(firstDegree, secondDegree)

    let difference = largest - smallest
    let middle = difference < shortestDist ? largest + (shortestDist / 2) : smallest + (shortestDist / 2)
    
    let middleHue: CGFloat = middle / 360
    let middleSat = CGFloat(hsba1.sat + hsba2.sat) / 2
    let middleBri = CGFloat(hsba1.brightness + hsba2.brightness) / 2
    let alpha = CGFloat(hsba1.alpha + hsba2.alpha) / 2

    return UIColor(hue: middleHue, saturation: middleSat, brightness: middleBri, alpha: alpha)
}

func averaged(_ color1: UIColor, color2: UIColor) -> [Color] {
    let middle = interpolate(color1, color2: color2)
    return [Color(color1), Color(middle), Color(color2)]
}

struct GradientView: View {
    var body: some View {
        VStack(spacing: 10) {
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: averaged(.white, color2: .cyan)), startPoint: .leading, endPoint: .trailing)
                    LinearGradient(gradient: Gradient(colors: [Color(.red), Color(.cyan)]), startPoint: .leading, endPoint: .trailing)
                }
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: averaged(.green, color2: .magenta)), startPoint: .leading, endPoint: .trailing)
                    LinearGradient(gradient: Gradient(colors: [Color(.green), Color(.magenta)]), startPoint: .leading, endPoint: .trailing)
                }
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: averaged(.blue, color2: .yellow)), startPoint: .leading, endPoint: .trailing)
                    LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.yellow)]), startPoint: .leading, endPoint: .trailing)
                }
        }
        .padding()
        .background(Color.black)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(GradientView().frame(width: 500 , height: 400))
