var x = 10

withUnsafePointer(to: &x) { ptr in
    print("Adres x:", ptr)
    print("Wartość pod wskaźnikiem:", ptr.pointee)
}
