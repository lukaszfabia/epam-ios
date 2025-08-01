# Foundation

## App bundle

1. Kiedy używać `FileManager` a kiedy `FileHandle`

`FileHandle` jest niskopoziomowym podejściem w obsłudze plików, mamy więcej bardziej specyficznych metod. Taka główna różnica to zamykanie pliku samodzielnie.
Warto wykorzystywać wtedy `defer`.

`FileManager` jest klasa wysokopoziomową gdzie mamy podstawowe operacje takie jak write, remove, copy, move itp.

2. Jak można przenieść, usunąć, skopiować plik w swift.

Można wykorzystać zarówno `FileHandle` jak i `FileManager`. Np. używając FileManager'a bezpośrednio wykonujemy na nim operacje podając path i odpowiednią metodę.

3. Obsługa błędów podczas pracy w plikami.

Jeśli chodzi o pracę z plikami tutaj mamy dużo błędów takie jak chociażby:

- plik nie istnieje, kiedy chcemy nadpisać go

- folder nie istnieje

W każdej tej sytuacji warto obsłużyć błąd dodadkowo dodać logi debugujące. Ponieważ lepiej jesteśmy w stanie zrozumieć co spowodowało błąd i lepiej na niego zareagować.

4. Cel folderu `Documents` w iOS, dostęp

Celem tego folderu jest trzymanie danych usera:

- bazy danych
- pliki usera
- cache, który ma być trwały czyli np. piosenki ze spotify jak się pobierze
- dane z apki
- konfig usera w danej apce.

Dostęp do tego folderu może się odbyć przez `FileManager`

```swift
import Foundation

let fm = FileManager.default

let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first!

```


5. Cel sandboxa w iOS?

Sandbox można porównać do obrazów dockerowych. Gdzie apka jest izolowana od innych ma swój system plików:

| Folder            | Przeznaczenie                                         |
| ----------------- | ----------------------------------------------------- |
| `Documents/`      | Dane użytkownika, które mają być trwałe i backupowane |
| `Library/`        | Dane aplikacji (np. konfiguracje, cache)              |
| `Library/Caches/` | Cache, który może być usunięty przez system           |
| `tmp/`            | Pliki tymczasowe, czyszczone automatycznie            |


Generalnie sandobox nie jest dostępny dla userów apki, w sensie nie da się wejść do danego folderu w sandboxie. Chociaż są wyjątki kiedy aplikacja sama udostępnia jakiś folder.


6. Główne katalogi w sandboxie

- Documents: przechowywanie trwałych danych

- Library: przechowuje pliki niezbędne do funkcjonowania aplikacji, tam mamy cache, preferencje, support do aplikacji

- tmp: pliki tymczasowe, mogą być usuwane po restarcie apki

- Shared/AppGroup: katalog, który sharuje dane między aplikacje


7. Klasa bunlde w Swift?

To jest paczka z już skompliowana aplikacja i innymi dodatkami jaki .plisty, assetsy, i inne rzeczy.

8. Dostęp do zasobów danego frameworka.

Tak można to zrobić używając inny konstruktor bundle'a.

```swift
let framework = Bundle(identifier: "com.company.some_framework")
```

Tak to się używa singletona `Bundle.main` do odczytywania info z plików w aplikacji.


## Notification Center

Jest to klasa a właściwie **singleton**, który jest wykorzystywany do tego, aby przekazywać dane (informacje) między różnymi częściami aplikacji a implementuje **observer pattern**.

Może posłużyć do:

- obsługi klawiatury

- do wysyłania danych między ekranami

Trzeba na niego uważać, ponieważ może być nadużywany. Warto stosować wzorzec **delegata** zamiast notyfikacji. Samo **NofiticationCenter** działa na zasadzie eventów/notyfikacji, gdzie mamy publishera i subscribera w zasadzie to w klasie często się ustawia na jaki event klasa nasłuchuje oraz definiuje się logikę biznesową do tego eventu. Warto używać `deinit`, aby usunąc obserwatorów, kiedy instancja jest usuwana z pamięci.

Poprzez metodę `addObserver` nasłuchujemy na event. Metodą `post` tworzymy event.


## UserDefaults

Prosty nieszyfrowany schowek typu _klucz-wartość_. Przechouje wszystkie typy proste i struktury danych jak tablica i słownik. Można w nim trzymać typy abstrakcyjne, ale wymaga to encodingu do typu `Data`. Generalnie przetrwa on restarty aplikacji. Można w nim trzymać proste informacje, niezajmujące dużo miejsca, np. preferencje dot. motywu lub języka lub jakieś ustawienia. Lepiej nie trzymać danych dot. logowania lub kluczy/tokenów.

## Keychain

Szyfrowany schowek, _klucz-wartość_, ale trzyma tylko typ Data, jest on zaszfrowany, więc dostęp do danych z niego będzie trochę dłuższy niż z **UserDefaults**. Apple udostępnia API do niego w postać libki **Security**. Tutaj można trzymać tokeny, hasła etc.

## Multithreading, GCD

1. Czym jest wątek.

Jest to nasz pracownik, który może wykonywać obliczenia niezależnie od innych.

2. Wielowątkować zatem jest to używanie wielu pracowników do przyspieszania obliczeń.

3. Wątek główny to taki, który wykonuje najważniejsze operacje np. zamiana czegoś na UI.

4. Współbieżność to zdolność programu do rozpoczynania, wykonywania i kończenia wielu zadań jednocześnie lub na przemian, tak by nie blokować głównego wątku i poprawić efektywność.

5. Zrównoleglanie to wykonywanie wielu operacji w tym samym czasie fizycznie — np. na wielu rdzeniach procesora jednocześnie.
Współbieżność nie musi oznaczać zrównoleglenia, ale często idą razem.

6. Można używać OperationQueue, Thread, DispatchQueue.

7. Kod jest thread-safe kiedy korzysta z libki raczej wysokopoziomowej i nie powoduje hazardu. Osiąga się to przez lockowanie, semafory lub poprostu nie zmienianie stanu.

8. Proces jest to program uruchamiany przez system operacyjny, posiada przydzieloną pamięć i min. jeden wątek.

9. Operacje procesu, można powiedzieć, że proces składa się z tasków.

10. Thread to pracownik, który wykonuje instrukcje a kolejka dispachuje zadania dla wątku/ów zgodnie z jakimś porządkiem.

11. Deadlock zakleszczenie, sytuacja kiedy dwa wątki czekaja na zasoby, ale żaden z nich ich nie zwalnia.

12. Do unikania race conditions można używać NSLock do blokowania dostępu, kolejki, semafory, grupy.

13. Różnica między live locks a prioirty inversion

| Cecha                     | Priority Inversion                         | Livelock                        |
| ------------------------- | ------------------------------------------ | ------------------------------- |
| Czy wątki są zablokowane? | Tak, wątek wysokoprio jest zablokowany     | Nie, ale nic nie robią postępów |
| Dotyczy priorytetów?      | Tak                                        | Nie                             |
| Problem z schedulerem?    | Tak (brak czasu CPU dla potrzebnego wątku) | Nie bezpośrednio                |
| Czy jest postęp?          | Nie                                        | Nie                             |

14. Różnice mutex/semafor

| Cecha               | Mutex                              | Semaphore                                |
| ------------------- | ---------------------------------- | ---------------------------------------- |
| Dostęp równoległy   | Nie (tylko 1 wątek)                | Tak (licznik określa ilu naraz)          |
| Czy ma właściciela? | Tak (tylko właściciel może unlock) | Nie (dowolny wątek może signal)          |
| Możliwość deadlocka | Tak                                | Tak (ale trudniej przypadkowo)           |
| Użycie              | Ochrona jednego zasobu             | Ochrona wielu instancji / synchronizacja |


15. Główny thread zajmuje się ważnymi operacjami jak aktualizacja czegoś na interfejsie i nie może być blokowany, a operacje nie mogą być wykonywane współbieżnie, thready, które działają w tle wykonują operacje o który user nie musi wiedzieć od zapisu czegoś do cache po mierzenie zużycia pamięci lub CPU.



## OperationQueue - nowe podejście

1. BlockBased - jak tworzyć i uruchamiać?

```swift

// concurent queue
let queue = OperationQueue()

let op = BlockOperation {
    print("Hello World")
}

queue.addOperation(op)
```
2. Ustawianie zależności między operacjami i co to oznacza

Ustawianie zależności między operacjami pomaga w uruchamianiu danej operacji przed inna w ten sposób można tworzyć hierarchie etc. To właśnie wyróżnia OperationQueue od DispatchQueue.

```swift
blockA.addDependency(blockB)
```

3. Ile można uruchomić równolegle operacji w kolejce i jak się to zmienia.

Generalnie wartość domyślna jest przydzialana przez swift na podstawie dostępnych zasobów, ale można to zmienić poprzez property .maxConcurrentOperationCount.


4. Na jakich threadach lecą operacje

- main
- na takich które zostaną przydzielone przez system

5. Cancel operacji jest poprzez wywołanie metody cancel() na operacji lub na całej kolejce.

6. Różnice między OperationQueue a GCD

OperationQueue jest bardziej złożony, czyli dostajemy więcej możliwości kontroli niż w kolejce. Oba mechanizmy są podobne, ale OperationQueue jest używany w bardziej żłożonych przypadkach, gdy chcemy cancelować operacje, tworzyć hierarchie operacji, lub operacje mają się wykonać współbieżnie lub sekwencyjnie. GCD nadaje się bardziej do prostych operacji i ogólnie jest **lżejszy**. Pytanie czy jest łatwiejsze do używania? Oba są proste moim zdaniem.


## Asynchroniczność

1. Jak działa async/await w Swift i jak to ulepsza czytelnosc asynchronicznej kodu

Ogólnie **async/await** to `kolorwanie kodu` przy każdej asnychronicznej operacji dodajemy await, w ten sposób unikamy _closure hell_.

Przykład:

```swift
func fetch() async throws -> Data {
    try await URLSession.shared.data(from: URL(string: "https://example.com")!)
}

func fetch(completion: @escaping () -> Void) {
    URLSession.shared.dataTask(with: URL(string: "https://example.com")!) { data, response, error in
        completion()
    }.resume()
}
```

2. Co się dzieje, gdy wywołamy funkcję asynchroniczną w kontekście nieasynchronicznym? Jak izolować takie wywołania poprzez Task?

Wystąpi nam błąd, ponieważ kompilator będzie chciał asnychornicznego kontekstu, a my nie jesteśmy w stanie go utworzyć. Wtedy używamy Task {}. Jeśli operacja dot. aktualizacji UI to musimy użyć dekoratora `@MainActor`.

```swift
Task { @MainActor
    await fetch()
}
```

3. TaskGroup pomaga nam wykonywać zadania, które mogą być wystartowane w tym samym czasie, przez do aplikacja jest szybsza. Na koniec zbieramy wszystkie wyniki czekając na zakończenie wszystkich zadań.

4. Jak działa cancelowanie zadań w współbierznym swiftcie i jak można sprawdzać czy zadanie jest cancelled lub jak reagować na cancellation.

Jesteśmy odpowiedzialni za sprawdzenie czy Task jest cancelled i reagować na cancellation.

```swift
Task.isCancelled // sprawdzenie czy Task jest cancelled

let task = Task {}

task.cancel() // anulowanie zadania
```
Anulowanie nie przerywa automatycznie wykonywania zadania, a jedynie ustawia flagę, którą kod musi sprawdzić.

Propagacja anulowania:

Gdy zadanie nadrzędne zostanie anulowane, wszystkie jego podzadania (child tasks) automatycznie dziedziczą stan anulowania.

W strukturach takich jak withThrowingTaskGroup anulowanie grupy zadań automatycznie propaguje się do wszystkich zadań w grupie.

5. Rola MainActora.

MainActor to dekorator, który gwarantuje, że zadanie wykona się na main threadzie co jest istotne kiedy mamy operacje powiązaną z aktualizacją UI.

6. Propagacja błędów i ich obsługa w modelowaniu współbieżności w Swift

Błędy w Structured Concurrency są propagowane automatycznie przez async/await i TaskGroup, zapewniając przewidywalne zarządzanie błędami.
Obsługa błędów wymaga użycia try w wywołaniach async throws oraz bloków do-catch do przechwytywania błędów.
Anulowanie zadania może być traktowane jako błąd (CancellationError), co integruje się z mechanizmem obsługi błędów.


## Testing

Testowanie jednostkowe jest najniższym poziomem testowania, aplikacji polegającym na tym, że testujemy konkretną jednostkę, czyli metodę/funkcję. Jest to ważne, bo pokazuje czy nasz kod jest stabilny i działa poprawnie. W iOS używa się `XCTest` do pisania testów, aby określić, temat testów używa się `@testable`. W ten sposób wszystkie klasy, funkcje zostaną zaimportowane i będzie można je używać w testach.

```swift
import XCTest
@testable import MyApp
```

Aby stworzyć moduł testowy używa się klasy `XCTestCase` ona zawiera metody `setUp()` i `tearDown()` które są wywoływane przed i po każdym testowaniu. Są one używane do inicjalizacji i czyszczenia danych testowych. Dodatkowo XCode integruje się z klasa XCTestCase i można uruchamiać konkretne testy za pomocą "diamencika".

### Poszczgólne metody z XCTest

**Nil assertion** używane kiedy funkcje zwraca typ opcjonalny.

- XCTAssertNil: sprawdzamy czy wynik jest `nil`

- XCTAssertNotNil: sprawdzamy czy wynik jest różny od `nil`

**Zakańczanie testów**: w niektórych sytuacjach używa się `XCTFail()`, które natychmiast negatywnie zakańcza test. Może być to użyte kiedy testu nie ma, przykład:

```swift
func test_SomeMethod() {
    //TODO: implement appropriate test
    XCTFail("not implemented")
}
```
Ogólnie można powiedzieć, że służy to jako komunikat, nie powinno się używać tego przy pisaniu testów a jedynie oznaczaniu gdzie czegoś brakuje etc.

### Mockowanie i stuby

Mockowanie generalnie ma symulować działanie czegoś co jest używane w warstwie wyżej, dlatego też wykorzystuje się tak bardzo interfejsy, aby podmieniać implementację w ten sposób mamy niskie powiązania w kodzie i można łatwiej przetestować logikę biznesową.

Stub: jest to dostarczanie danych, które są potem jakoś walidowane, np. mamy źródło danych symulujemy poprzez ustawienie danych i sprawdzamy jak te dane przejdą przez klasę która jest testowana. Jest to takie źródło danych.

1. Jak weryfikować, że metoda została wywołana na mock obiekcie?

- upewnić się ze wystrzkujemy implementacje mocka w to co testujemy

- dodać logi

- dodać test, który sprawdzi czy używamy mocka np. jest funkcja, która zwraca nam coś z mocka no to sprawdzić tą wartość czy jest zgodna z oczekiwaną

### Testowanie asynchroniczności w kodzie

Można używać `expectation` lub jeśli mamy doczynienia z nowoczesnym swiftem to wystarczy **kolorować** funkcje.

Przykład z `expectation`:

```swift

func test_apiService_fetchUsers_whenError_completesWithFailure() {
    mockURLSession.mockError = URLError(.unknown)

    let sut = makeSut()
    let exp = expectation(description: "Fetch data with error.")

    sut.fetchUsers(urlString: "validurl") { result in
        switch result {
            case .failure(let err):
                XCTAssertEqual(APIError.unexpected, err)
            case .success(_):
                XCTFail("Expected to be error.")
        }

        exp.fulfill()
    }

    waitForExpectations(timeout: 2)
}
```

### DI w testach

Bez DI będzie bardzo trudno testować, a same testy mogą być niestabilne. Samo DI jest istotne nie tylko w testowaniu, ale w pisaniu kodu o niskich powiązaniach.

Przykład (uproszczony):

```swift
protocol Service {
    //crud functions
}

class ServiceImpl: Service {}

class MockService: Service {}

class ViewModel {
    private var service: any Service

    init(service: any Service = ServiceImpl()) {
        self.service = service
    }
}

let vm = ViewModel() // used in real app

let sut = ViewModel(service = MockService()) // used to testing

```

### Czego unikać przy testowaniu

Powinno się unikać pisania flaky testów, które zależą od innych czynników jak kolejność realizacji zadań w przypadku testowania funkcji współbieżnych, ale także unikać wykonywania requestów.

Dlaczego?

- Jeżeli mamy środowisko CI/CD to ono często ma ograniczone zasoby i brak dostępu do internetu

- Jeżeli chodzi o wykonywanie requestów to polegamy wtedy na serwerze i liczymy, że zwróci nam spodziewane dane, ale w przypadku kiedy:
  - nasze api dopiero powstaje lub go nie ma i nie jest jeszcze przetestowane

  - co w przypadku kiedy api jest niedostępne (inne test się wywalą)

### XCTUnwrap

Jest to funckja, która służy do sprawdzania wartości po wypakowaniu, dodatkowo wywala się jeśli dostała `nil`. Przydatne jeśli zwracany jest chain i chcemy sprawdzić daną wartość z chaina.

### SUT - system under testing

Dobrą praktyką jest używanie dobrego nazewnictwa, kiedy tworzymy instancję do testu można ją nazwać `sut` dodatkowo jeśli chcemy zapewnić atomowość podmiotu, warto resetować jego stan lub tworzyć nowe instancje.
