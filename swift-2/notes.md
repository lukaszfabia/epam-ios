# Różnice między `struct` a `class` w Swift

## Typ wartościowy vs. typ referencyjny

- `struct` jest **typem wartościowym** — oznacza to, że przy przypisaniu lub przekazaniu struktury tworzy się **jej kopia**.
- `class` jest **typem referencyjnym** — przekazywana jest **referencja** do oryginalnej instancji, więc zmiany w metodach/funkcjach działają na tym samym obiekcie, a nie na kopii.

---

## Alokacja pamięci i zarządzanie

### `struct`
- Alokacja na **stosu** (stack), choć czasem na stercie (heap), jeśli „ucieknie” z kontekstu.
- **Brak ARC** (Automatic Reference Counting).
- Przekazywanie przez **kopię** przy przypisaniu.
- Zazwyczaj **lepsza wydajność** przy prostych danych.

### `class`
- Alokacja na **sterce** (heap).
- Zarządzanie pamięcią przez **ARC** (Automatic Reference Counting).
- Przekazywanie przez **dzielenie referencji**.
- Większa elastyczność — np. **dziedziczenie**, współdzielenie instancji.

---

## Use case — kiedy stosować `struct`, a kiedy `class`

- **`class`** — gdy mamy złożone obiekty, potrzebujemy dziedziczenia lub gdy metody mutują stan instancji.
- **`struct`** — gdy mamy proste, często niemutowalne dane, które chcemy przekazywać jako kopie.

---

## Mutowalność i `mutating` w `struct`

W `struct` metoda, która zmienia właściwości, musi być oznaczona słowem kluczowym `mutating`. Pozwala to na modyfikację stanu instancji w metodach.

---

## Protokoły i `struct`

- `struct` może implementować protokoły bez problemu.
- Musi implementować wszystkie wymagane metody i właściwości protokołu.
- Zaleca się, aby metody protokołu były niemutujące, by zachować korzyści typów wartościowych.

---

## Memberwise initializer w `struct`

- Jest to **domyślny konstruktor** generowany automatycznie dla struktur.
- Pozwala inicjalizować wszystkie właściwości podczas tworzenia instancji bez konieczności pisania własnego `init`.

---

## Dziedziczenie w `class` i `struct`

- **`class`** wspiera **dziedziczenie** (single inheritance).
- **`struct`** **nie obsługuje dziedziczenia** — zamiast tego stosuje się protokoły jako alternatywę.

---

# Stored Properties vs Computed Properties

- **Stored properties** to właściwości w klasie lub strukturze, które **przechowują wartość w pamięci**.  
  Często są inicjalizowane przez konstruktor (np. w memberwise initializer w structach).

- **Computed properties** to właściwości, które **nie przechowują wartości**, lecz **obliczają ją za każdym razem na podstawie innych właściwości**.  
  Ich obliczenia powinny być szybkie i bez efektów ubocznych (side effects).  
  Przykład: metoda `toString()` zwracająca tekstową reprezentację obiektu.

---

# Różnica między `let` a `var` w struct

- `let` oznacza właściwość **stałą**, przypisaną **raz podczas tworzenia instancji** (np. w memberwise initializer).  
- `var` oznacza właściwość **zmienną**, którą można modyfikować po utworzeniu instancji.

---

# Lazy Properties

- Słowo kluczowe `lazy` oznacza, że właściwość jest **inicjalizowana dopiero przy pierwszym dostępie** do niej, a nie podczas tworzenia obiektu.  
- Pozwala to zaoszczędzić zasoby, jeśli obliczenie wartości jest kosztowne i nie zawsze potrzebne.

---

# Property Observers

- Mechanizm pozwalający **obserwować zmiany wartości stored properties**.  
- Dostępne są dwa typy:  
  - `willSet` — wywoływany **przed zmianą** wartości, nowa wartość dostępna jako `newValue`  
  - `didSet` — wywoływany **po zmianie** wartości, poprzednia wartość dostępna jako `oldValue`

---

# Czy computed properties mogą mieć `willSet` i `didSet`?

- **Nie mogą**, ponieważ computed properties **nie przechowują wartości**, tylko ją obliczają.  
- Property observers działają tylko dla stored properties.

---

# Static Properties

- Właściwości oznaczone `static` są **przypisane do samego typu (klasy/struct), a nie do instancji**.  
- Można je wywołać bez tworzenia obiektu.



## Type Methods vs Class Methods

- `type methods` to **statyczne metody** oznaczone jako `static`.  
**Nie mogą być nadpisywane** w podklasach.

- `class methods` to również metody statyczne, ale oznaczone jako `class`.  
**Mogą być nadpisywane** w podklasach (działają polimorficznie).

---

## Funkcja vs Metoda

- **Funkcja** – znajduje się poza klasą, strukturą lub enumem.  
- **Metoda** – funkcja zdefiniowana **wewnątrz typu** (np. klasy, struktury, enuma).

---

## Struct a metody statyczne

- Struktury mogą mieć metody oznaczone jako `static`.
- **Nie mogą** mieć metod `class`, ponieważ **nie wspierają dziedziczenia**.

---

## `self` vs `Self`

- `self` – odnosi się do **bieżącej instancji** w metodzie instancyjnej.
- `Self` – odnosi się do **typu**, czyli `class`, `struct` lub `enum`.  
Używane często w kontekście metod statycznych lub jako typ zwracany.

---

## Overloading w Swift

- Przeciążanie (overloading) to definiowanie **metod o tej samej nazwie**, ale:
  - z różnymi typami argumentów,
  - inną liczbą argumentów,
  - inną kolejnością lub nazwami parametrów.

Swift rozróżnia metody po **sygnaturze** – nie tylko po nazwie.

---

## Domyślne wartości parametrów

Można ustawić **wartości domyślne** dla parametrów funkcji lub inicjalizatorów:

```swift
struct User {
    var id: Int
    init(id: Int = 0) {
        self.id = id
    }
}
```
--- 

# Dziedziczenie w Swift

Dziedziczenie w Swift pozwala na posiadanie metod i właściwości z klasy wyżej bez konieczności implementacji ich w podklasie. Dotyczy to jednak tylko właściwości, które mają domyślny lub publiczny dostęp — właściwości oznaczone jako `private` nie są dziedziczone.

# Overriding w Swift

Nadpisywanie metod to technika, w której w klasie nadrzędnej mamy daną metodę, a jeśli w podklasie chcemy, by metoda działała inaczej, to możemy ją nadpisać. W takim przypadku wywołana zostanie metoda z podklasy. Do tego celu używamy słowa kluczowego `override`.

# `super` keyword

Słowo kluczowe `super` pozwala odwołać się do metod lub właściwości klasy nadrzędnej (rodzica).

# `final`

Słowo kluczowe `final` pozwala zapobiec:

- Rozszerzaniu klasy o podklasy.
- Nadpisywaniu metod oznaczonych jako `final`.
- Nadpisywaniu właściwości oznaczonych jako `final`.

# Wielodziedziczenie i protokoły

W Swift nie ma typowego wielodziedziczenia klas, ale klasa może implementować wiele protokołów.

# Polimorfizm

Polimorfizm pozwala na bardziej elastyczne podejście, np. przy tworzeniu funkcji możemy wymagać protokołu (interfejsu) zamiast konkretnego typu. W ten sposób kod jest zależny od kontraktu (protokołu), a nie od implementacji.

# Konstruktor (initializer)

Konstruktor pozwala utworzyć instancję danego typu.

- Aby wymusić na użytkowniku inicjalizację wszystkich właściwości, należy utworzyć konstruktor, który to wymaga. Jest to tzw. `designated init` — główny konstruktor klasy.
- `convenience init` to konstruktor pomocniczy, np. kopiujący lub taki, który wywołuje `designated init` i przypisuje domyślne wartości. Konstruktor oznaczony jako `convenience` musi wywołać `designated init`.
- `failable init` to konstruktor, który może zwrócić `nil` w przypadku niespełnienia jakiegoś warunku.
- Jeśli właściwość ma wartość domyślną, to w `init` nie trzeba jej podawać.
- `required init` to konstruktor, który musi być zaimplementowany w każdej podklasie — ma taki sam podpis.
- `init!` działa podobnie jak `init?`, ale jest mniej bezpieczny, ponieważ może spowodować crash programu, jeśli zwróci `nil`. Używamy go, gdy jesteśmy pewni, że inicjalizacja się powiedzie.

# Structy

Struktury mogą mieć własne konstruktory, w tym failable initializery, ale nie mogą mieć konstruktorów oznaczonych jako `convenience` lub `required`.

# Destruktory (`deinit`)

Destruktor jest wywoływany, gdy liczba referencji do obiektu spada do zera w mechanizmie ARC i obiekt jest usuwany z pamięci.

- Struktury nie mają destruktorów, ponieważ nie są typami referencyjnymi i ARC ich nie śledzi.
- Celem destruktora jest sprzątanie, np. zamykanie połączeń z plikami, bazami danych — ogólnie sprzątanie po "śmierci" obiektu.
- Nie można wywołać `deinit` ręcznie. Teoretycznie można przypisać instancję do `nil`, co spowoduje wywołanie destruktora (jeśli nie ma innych referencji).
- Łańcuch wywołań destruktorów przebiega od podklasy do klasy nadrzędnej.













