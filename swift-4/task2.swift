protocol Shape { 
    func area() -> Double
    func perimeter() -> Double
}


class Circle: Shape {
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        return Double.pi * radius * radius  // pi r2
    }

    func perimeter() -> Double {
        return Double.pi * 2 * radius // 2pir 
    }
}

class Rectangle: Shape {
    let width: Double 
    let height : Double 

    init(height: Double, width: Double) {
        self.height = height
        self.width = width
    }

    func area() -> Double {
        return width * height
    }

    func perimeter() -> Double {
        return 2*width + 2*height
    }
}


func generateShape() -> some Shape{
    return Circle(radius: 5)
}


func calculateShapeDetails(shape: Shape) -> (Double, Double)  {
    return (shape.area(), shape.perimeter())
}


let shape = generateShape() 

print(calculateShapeDetails(shape: shape))

let rec = Rectangle(height: 5, width: 5)

assert(calculateShapeDetails(shape: rec) == (25, 20))