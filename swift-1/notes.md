## 1. P: Różnica między `let` a `var`?

**O:** Słowo kluczowe `let` oznacza, że zmienna jest niemutowalna (nie można jej zmienić), a `var` pozwala na ponowne przypisanie wartości do zmiennej.

---

## 2. P: Czy trzeba jawnie określać typ zmiennej?

**O:** Nie trzeba podawać typu, jeśli zmienna ma wartość początkową – wtedy kompilator Swift używa wnioskowania typów. W przeciwnym razie wystąpi błąd kompilacji. Warto wiedzieć, że kompilator nie potrafi automatycznie rzutować np. `x = 1`, `y = 0.1`, `z = x + y` (błąd, bo `Int + Double`).

---

## 3. P: Jakie są zastosowania i główne różnice między Array, Set i Dictionary?

**O:**

- **Array (Tablica):** uporządkowana struktura danych, może zawierać duplikaty.
- **Set (Zbiór):** nieuporządkowana struktura danych, przechowuje tylko unikalne wartości.
- **Dictionary (Słownik):** struktura danych przechowująca pary klucz-wartość, często używana w obiektach JSON.

---

## 4. P: Różnica między String a Character, mutowalność Stringa?

**O:** To zależy od modyfikatora mutowalności. Jeśli string został zadeklarowany przez `let`, nie można go zmienić (np. przez konkatenację).  
`String` to ciąg znaków, a `Character` to pojedynczy znak – można powiedzieć, że `String` to tablica `[Character]`.

---

## 5. P: Różnica między `while` a `do-while`?

**O:** W `while` warunek jest sprawdzany przed wykonaniem ciała pętli.  
W `do-while` (np. do pobierania danych od użytkownika) warunek jest sprawdzany po pierwszym wykonaniu ciała pętli – gwarantuje to przynajmniej jedno wykonanie.

---

## 6. P: Przeciążanie funkcji (Overloading)?

**O:** Warunek: funkcje mają taką samą nazwę, ale różne typy parametrów.

```swift
func add(lhs: Double, rhs: Double) -> Double {
    return lhs + rhs
}

func add(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs
}
