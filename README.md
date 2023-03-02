Pavelescu Florin, grupa 324CC

Am rezolvat cele 4 cerinte scriind mai intai algoritmii
in C, pe care i-am "tradus" ulterior, linie cu linie, in Assembly.
Pentru problemele 2, 3 si 4 am folosit stiva pentru a salva 
anumite variabile din cauza numarului redus de registre disponibile.

**Observatie:** In comentariile din cod, prin "salvez `eax` pe stiva" inteleg ca 
salvez continutul registrului `eax` pe stiva si prin "scot `eax` de pe 
stiva" inteleg ca pun in `eax` continutul din varful stivei.

# Problema 1
Am construit textul `ciphertext` cu ajutorul buclei
`build_ciphertext` care itereaza prin `plaintext` si salveaza
in `ciphertext` textul modificat cu ajutorul cheii, respectand
formula din cerinta: `ciphertext[i] = plaintext[i] ^ key[len-i-1]`.

# Problema 2
Am construit vectorul `all_ages` parcurgand vectorul
`dates` si folosind formula `all_ages[i] = present->year - dates[i].year`, 
exceptie facand cazurile in care ziua de nastere nu a fost inca;
in acest caz, `all_ages[i] = present->year - dates[i].year - 1`. 
De asemenea, pentru `all_ages[i] < 0`, am pus `all_ages[i] = 0`, conform 
cerintei.

# Problema 3
Pentru a implementa modelul prezentat in cerinta, am
gandit matricea descrisa ca pe un vector. Am parcurs vectorul `key`, 
si la fiecare iteratie, pentru a lua toate elementele de pe coloana 
`key[i]`, am parcurs `haystack` si am luat elementele `haystack[j]` cu 
proprietatea `j % len_cheie == key[i]`. La final, am pus terminatorul 
`'\0'` la finalul vectorului obtinut, `ciphertext`.

# Problema 4
Am urmat algoritmul de load descris in cerinta:
am calculat tagul aferent adresei primite (am siftat la dreapta 
cu 3 pozitii adresa) si l-am cautat in vectorul `tags`. 
Daca l-am gasit, am retinut linia, am calculat offsetul
corespunzator (si logic intre adresa si `7(10)=0...0111(2)`, pentru
a obtine ultimii 3 biti ai adresei) si am pus in `reg` elementul
`cache[line][offset]`. Daca nu am gasit tagul, am incarcat in `cache`
8 octeti consecutivi din memorie, practic intervalul 
`[[tag]000, [tag]111]`, dupa care am pus elementul cautat (tocmai 
incarcat in `cache`) in registru, ca la cazul anterior.

Detalii mai amanuntite despre implementare se gasesc in comentariile
din cod. Am adaugat comentarii pe fiecare linie de cod, acestea fiindu-mi 
foarte utile pe parcursul scrierii codului si al rezolvarii erorilor
aparute (debugging). 
