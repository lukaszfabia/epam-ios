# Generyki w Swift

### Czym są generyki i dlaczego są przydatne?
Generyki pozwalają definiować zachowanie dla wielu typów danych, abstrahując od konkretnego typu. Dzięki nim można tworzyć uniwersalne struktury danych i funkcje, np. `Array`, `Dictionary` są generyczne.

### Jak zdefiniować funkcję generyczną?
Dodając parametr typu w nawiasach ostrych `<T>`, np.:
```swift
func example<T>(value: T) { ... }
````

Można też narzucać ograniczenia (constraints) na typ `T`.

### Czy można utworzyć klasę lub strukturę generyczną?

Tak, np.:

```swift
struct BBB<T> {
    var t: T
}
```

`T` to alias typu, można nazwać inaczej, np. `<MyType>`.

### Co to są ograniczenia typu (constraints) i jak ich używać?

Pozwalają ograniczyć typ `T`, np. wymuszając dziedziczenie lub implementację protokołu:

```swift
struct BBB<T: MyProtocol> {
    var t: T
}
```

### Generyki z kolekcjami

`Array`, `Dictionary` i inne struktury są już generyczne i można je stosować z dowolnym typem spełniającym wymagania.

### Różnica między `Any` a `AnyObject`

* `Any` — dowolny typ (wartościowy lub referencyjny)
* `AnyObject` — dowolna instancja klasy (referencyjny typ)

---

# Typy skojarzone i protokoły

### Typ skojarzony (associatedtype) a generyki

Pozwala definiować w protokole typ, który będzie doprecyzowany przez implementację protokołu, co umożliwia tworzenie generycznych protokołów.

### Przykład protokołu z typem skojarzonym:

```swift
protocol Repo {
    associatedtype T: Animal
    func findByID(id: String) -> T
}
```

(Nie można zadeklarować protokołu generycznego jak funkcji).

---

# Opaque and Boxed Protocol Types

### Co to są nieprzezroczyste typy (opaque types)?

Typy, które ukrywają konkretny zwracany typ, ale gwarantują implementację określonego protokołu. Deklarujemy je słowem `some`.

### Różnica między generykami a nieprzezroczystymi typami:

* Generyki pozwalają na różne typy w czasie kompilacji.
* Opaque typy zawsze zwracają ten sam ukryty typ, ale użytkownik tego nie widzi.

### Co oznacza `some`?

Mówi kompilatorowi, że zwracany typ jest znany, ale użytkownik go nie zna.

---

# Automatyczne zliczanie referencji (ARC)

### Czym jest ARC?

System zarządzania pamięcią w Swift, który automatycznie zwalnia pamięć, gdy liczba referencji do obiektu spada do 0.

### Typy referencji:

* `strong` — inkrementuje licznik referencji (domyślna)
* `weak` — nie inkrementuje licznika, jest opcjonalne (`nil` gdy obiekt zniknie)
* `unowned` — nie inkrementuje, nie może być `nil`, wymaga pewności co do cyklu życia obiektu

### Silny cykl referencji i jego unikanie

Gdy dwa obiekty mają silne referencje do siebie — pamięć nie jest zwalniana. Rozwiązuje się to stosując `weak` lub `unowned`.

### Przykład unikania cyklu:

```swift
class Person {
    var cat: Cat?
}

class Cat {
    weak var owner: Person?
}
```

### ARC a zamknięcia (closures)

Zamknięcia mogą tworzyć silne cykle, jeśli referencje do `self` są silne. Należy używać `[weak self]` lub `[unowned self]` w capture list.

---

# Bezpieczeństwo pamięci

### Zasady i mechanizmy

* ARC
* Typy wartościowe zamiast wskaźników
* Brak wskaźników surowych (poza UnsafePointer)
* Kontrola dostępu (private, fileprivate)
* Wyłączny dostęp do pamięci (np. `inout`)

### Wyłączny dostęp do pamięci

`inout` gwarantuje, że zmienna nie jest jednocześnie czytana lub zapisywana w innym miejscu, co zapobiega błędom i race conditions.

---

# Kontrola dostępu w Swift

### Poziomy dostępu:

* `private` — dostęp tylko wewnątrz tej klasy/struktury
* `fileprivate` — dostęp w obrębie pliku
* `internal` — dostęp w module (domyślny)
* `public` — dostęp poza modułem, ale **bez możliwości dziedziczenia/nadpisywania**
* `open` — dostęp i możliwość dziedziczenia/nadpisywania poza modułem

### Odpowiedzi na pytania:

1. **Czy można zastąpić metody klasy publicznej w innym module?**
   Nie. Metody `public` można wywoływać, ale nadpisywać (override) tylko te oznaczone jako `open`.

2. **Jak zasady kontroli dostępu odnoszą się do rozszerzeń?**
   Rozszerzenia mogą mieć dostęp do poziomu dostępu oryginalnego typu, ale nie mogą mieć wyższego poziomu niż ten typ.

3. **Czy rozszerzenie może zadeklarować wyższy poziom dostępu niż sam typ?**
   Nie, nie może.

4. **Dlaczego należy używać prywatnego poziomu dostępu?**
   Aby ukryć szczegóły implementacji, chronić wewnętrzne dane i uprościć utrzymanie kodu.

5. **Kiedy użyć `fileprivate` zamiast `private`?**
   Gdy potrzebujemy udostępnić element wszystkim w danym pliku, ale nie poza nim.

6. **W jaki sposób kontrola dostępu pomaga w budowaniu modułowych i bezpiecznych aplikacji?**
   Oddziela interfejs od implementacji, zapobiega nieautoryzowanemu dostępowi, zwiększa bezpieczeństwo i ułatwia zarządzanie kodem.
