# Swift 3

## Optionale

**Co to są optionale?**  
Typy nilowalne, które mogą przechowywać wartość lub nil.

**Jak zdefiniować zmienną optionalną?**  
Dodając znak `?` do typu, np. `var name: String?`.

**Jakie są sposoby na odpakowanie optionala?**  
- `guard let`  
- `if let`

**Jak działa optional chaining i dlaczego jest przydatny?**  
Pozwala wywołać właściwość, metodę lub subskrypt na optionalu bez wywoływania błędu, jeśli jest nil — zamiast tego zwraca nil.

**Jaka jest różnica między optional binding a forced unwrapping?**  
- Optional binding (np. `if let`, `guard let`) pozwala bezpiecznie odpakować wartość i kontrolować przypadek nil.  
- Forced unwrapping (`!`) wymusza odpakowanie, może spowodować błąd wykonania jeśli wartość jest nil.

**Czy można wykonać wiele optional bindings w jednej linii? Jak?**  
Tak, oddzielając je przecinkiem:  

```swift
if let a = obj.a, let b = obj.b {
    // kod
} else {
    // kod
}
````

**Co to jest implicitly unwrapped optional?**
Optional zdefiniowany z `!`, którego używamy gdy jesteśmy pewni, że wartość będzie ustawiona przed użyciem, można go używać bez odpakowywania.

**Na co uważać przy forced unwrapping?**
Jeśli wartość jest nil, spowoduje to błąd wykonania i awarię aplikacji.

---

## Rozszerzenia (Extensions)

**Co to jest extension i jakie daje korzyści?**
Pozwalają rozszerzyć implementację klasy lub struktury, np. dodać domyślną implementację protokołu.

**Jak zdefiniować extension?**
Słowem kluczowym `extension` i podając typ, który rozszerzamy.

**Co można dodać do typu przez extension? Czy można dodać przechowywane właściwości?**
Można dodać:

* właściwości obliczane (computed properties),
* metody,
* inicjalizatory,
* subskrypty,
* typy zagnieżdżone.
  Nie można dodać przechowywanych właściwości (stored properties).

**Czym różnią się extension protokołów od zwykłych?**
Extensions w protokołach służą głównie do dostarczania domyślnych implementacji.

**Czy rozszerzenie może deklarować entity o wyższym poziomie dostępu niż typ?**
Nie, nie można ustawić wyższego poziomu dostępu niż typ, który rozszerzamy.

**Czy można nadpisać metody klasy w extension?**
Nie, w extension można tylko dodawać nowe metody lub właściwości, nie można nadpisać istniejących.

**Czy można dodawać coś do typów, których nie posiadamy?**
Tak, można dodać computed properties, metody, inicjalizatory, subskrypty i typy zagnieżdżone, ale nie stored properties.

---

## Protokoły (Protocols)

**Co to jest protokół? Jak go zdefiniować? Jakie są korzyści?**
Protokół to kontrakt (jak interface w innych językach). Klasa implementująca protokół musi implementować wszystkie jego metody.
Definicja:

```swift
protocol IProtocol {
    func getByID(id: Int) -> Person
    // ...
}
```

Korzyści:

* ułatwia testowanie (mocki),
* umożliwia zmianę implementacji,
* pozwala stosować wzorzec tagowania (pusty protokół jako znacznik).

**Co można deklarować w protokole?**
Metody, właściwości, typy powiązane (associated types).

**Czy protokół może dziedziczyć po innym protokole?**
Tak.

**Czy struktury, klasy i enumy mogą implementować protokoły?**
Tak.

**Ile protokołów może implementować dany typ?**
Dowolną liczbę.

**Czy protokoły mogą mieć domyślną implementację?**
Tak, przez extension.

**Co to są associated types?**
Placeholdery na typy, które zostaną określone dopiero podczas implementacji.

Przykład:

```swift
protocol Test {
    associatedtype Person
    var name: Person { get set }
    func test() -> Void
}

struct TestStruct: Test {
    typealias Person = String
    var name: String

    func test() {
        print("Testing with name: \(name)")
    }
}
```

---

## Obsługa błędów (Error handling)

**Jak obsługujemy błędy w iOS?**
Przez `do-catch`.

**Dlaczego obsługa błędów jest ważna?**
Ułatwia debugowanie i unika błędów w czasie wykonania.

**Co to jest `do-catch`?**
Blok służący do łapania i obsługi błędów.

**Co robi słowo kluczowe `throws`?**
Informuje, że funkcja może rzucić błąd.

**Co to jest typ `Result` i jak się go używa?**
Reprezentuje wartość, która może być sukcesem lub porażką (dwa przypadki: `success` i `failure`), pozwala elegancko obsłużyć błędy.

---

## Rzutowanie typów (Type casting)

**Różnica między `as`, `as?` i `as!`:**

* `as` — upcasting (bezpieczne podnoszenie typu)
* `as?` — bezpieczne downcasting z optionalem
* `as!` — wymuszony downcasting (może spowodować błąd)

**Do czego służy słowo kluczowe `is`?**
Sprawdza, czy obiekt jest określonego typu (jak `instanceof` w Javie).

**Na co uważać przy wymuszonym rzutowaniu (`as!`)?**
Jeśli obiekt nie jest danego typu, aplikacja się zawiesi.

**Dlaczego rzutowanie typów jest ważne?**
Pozwala konwertować typy, co jest istotne przy pracy z protokołami, generykami i dziedziczeniem.

---

## Typy zagnieżdżone (Nested types)

**Co to są typy zagnieżdżone i jakie dają korzyści?**
Kod jest bardziej modularny i czytelny, można grupować powiązane typy.

**Jak zadeklarować typ zagnieżdżony w klasie lub strukturze?**
Definiując klasę, strukturę lub enum wewnątrz innej klasy/struktury.

**Jak uzyskać dostęp do typu zagnieżdżonego z zewnątrz?**
Przez notację kropkową: `SomeClass.SomeNestedType`

**Czy typy zagnieżdżone można rozszerzać? Jak?**
Tak, jak zwykłe typy, przez `extension` i podając nazwę typu zagnieżdżonego.

---

## Subskrypty (Subscripts)

**Co to są subskrypty i jakie są ich zalety?**
Skrót do dostępu do elementów kolekcji lub klasy.

**Jak zdefiniować subskrypt?**
Słowem kluczowym `subscript` z parametrami i typem zwracanym.

**Jakie parametry mogą przyjmować subskrypty? Czy mogą mieć wiele parametrów?**
Mogą przyjmować wiele parametrów, ale wszystkie w pojedynczej liście parametrów.

**Czy subskrypty mogą zwracać wiele wartości?**
Nie, zwracają tylko jedną wartość, ale może to być dowolny typ.

---

## Funkcje wyższego rzędu (Higher order functions)

**Zalety używania funkcji wyższego rzędu:**
Unikają pętli i powtarzalnego kodu, są bardziej czytelne i stabilne.

**Co robi funkcja `map`?**
Transformuje każdy element kolekcji na nową wartość.

**Różnica między `flatMap` a `compactMap`:**

* `flatMap` usuwa kolekcje zagnieżdżone i spłaszcza listę.
* `compactMap` działa jak `map`, ale usuwa `nil` z wyników.

**Jak użyć `reduce` do agregacji elementów tablicy?**
Podajesz wartość startową oraz operację łączącą akumulator i bieżący element w jeden wynik.

---

## Przydatne funkcje kolekcji

* `filter(_:)` — zwraca nową tablicę elementów spełniających warunek.
* `contains(where:)` — sprawdza, czy dowolny element spełnia warunek.
* `forEach(_:)` — wykonuje zamknięcie dla każdego elementu.
* `sort(by:)` — sortuje elementy według podanego kryterium.
* `first(where:)` — zwraca pierwszy element spełniający warunek lub nil.
* `last(where:)` — zwraca ostatni element spełniający warunek lub nil.