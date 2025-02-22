install.packages("PogromcyDanych")
library(PogromcyDanych)
auta2012
head(auta2012)

##1. Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?
auta2012%>%
  filter(Rodzaj.paliwa=="olej napedowy (diesel)") %>% 
  filter(Rok.produkcji==2007) %>% 
  dim()
##Odp: 11621

##2. Jakiego koloru auta maj� najmniejszy medianowy przebieg?
auta2012 %>% 
  group_by(Kolor) %>% 
  summarize(mediana=median(Przebieg.w.km,na.rm=TRUE)) %>% 
  arrange(mediana)
##Odp: bia�y metallic

##3. Gdy ograniczy� si� tylko do aut wyprodukowanych w 2007, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Rok.produkcji==2007) %>% 
  group_by(Marka) %>% 
  summarize(n=n()) %>% 
  arrange(-n)
##Odp: Volkswagen

##4. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najta�sza?
auta2012 %>% 
  filter(Rodzaj.paliwa=="olej napedowy (diesel)") %>% 
  filter(Rok.produkcji==2007) %>% 
  group_by(Marka) %>% 
  summarize(�rednia=mean(Cena.w.PLN)) %>% 
  arrange(�rednia)
##Odp. Aixam

##5. Spo�r�d aut marki Toyota, kt�ry model najbardziej straci� na cenie pomi�dzy rokiem produkcji 2007 a 2008.
toyota_2007<-auta2012 %>% 
  filter(Marka=="Toyota") %>% 
  filter(Rok.produkcji==2007) %>% 
  group_by(Model) %>% 
  summarize(�rednia_cena_2007=mean(Cena.w.PLN))
toyota_2008<-auta2012 %>% 
  filter(Marka=="Toyota") %>% 
  filter(Rok.produkcji==2008) %>% 
  group_by(Model) %>% 
  summarize(�rednia_cena_2008=mean(Cena.w.PLN))
toyota_2007 %>% 
  inner_join(toyota_2008,by="Model") %>% 
  mutate(spadek_ceny=�rednia_cena_2008-�rednia_cena_2007) %>% 
  arrange(spadek_ceny)
  
##Odp: Najwi�kszy spadek pomi�dzy rokiem produkcji 2007 i 2008 zaliczy� model Hiace

##6. W jakiej marce klimatyzacja jest najcz�ciej obecna?

  
##7. Gdy ograniczy� si� tylko do aut z silnikiem ponad 100 KM, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta2012 %>% 
  filter(KM>100) %>% 
  count(Marka) %>% 
  arrange(-n)
##Odp: Volkswagen

##8. Gdy ograniczy� si� tylko do aut o przebiegu poni�ej 50 000 km o silniku diesla, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Przebieg.w.km<50000) %>% 
  count(Marka) %>% 
  arrange(-n)
##Odp: Volkswagen

##9. Spo�r�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest �rednio najdro�szy?
auta2012 %>% 
  filter(Marka=="Toyota") %>% 
  filter(Rok.produkcji==2007) %>% 
  group_by(Model) %>% 
  summarize(�rednia_cena=mean(Cena.w.PLN)) %>% 
  arrange(-�rednia_cena)
##Odp: Land Cruiser

##10. Spo�r�d aut marki Toyota, kt�ry model ma najwi�ksz� r�nic� cen gdy por�wna� silniki benzynowe a diesel?
toyota_benz<-auta2012 %>% 
  filter(Marka=="Toyota") %>% 
  filter(Rodzaj.paliwa=="benzyna") %>% 
  group_by(Model) %>% 
  summarize(�rednia_cena_benz=mean(Cena.w.PLN))

toyota_diesel<-auta2012 %>% 
  filter(Marka=="Toyota") %>% 
  filter(Rodzaj.paliwa=="olej napedowy (diesel)") %>% 
  group_by(Model) %>% 
  summarize(�rednia_cena_diesel=mean(Cena.w.PLN))

toyota_diesel %>% 
  inner_join(toyota_benz,by="Model") %>% 
  mutate(r�nica_cen =abs(�rednia_cena_diesel-�rednia_cena_benz)) %>% 
  arrange(-r�nica_cen)

##Odp:Camry

########################
