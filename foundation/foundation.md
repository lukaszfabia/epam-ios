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
