--SELECT * tabloyu komple gösterir.
  --Bir tabloyu olduğu gibi görürsün. “İçinde ne var?” diye bakmak için.

  --Örnek:
SELECT 
*
 FROM `pacific-legend-474020-b4.wisdom_pets.customers`;


--SELECT Komutu. Belirli sütunları seçme
  --Sütun adlarını virgülle ayır; gereksiz sütunları getirme, maliyeti düşürür.
  --Yazım hatası: Sütun adı yanlışsa sorgu çalışmaz.
  --İhtiyacın olan sütunları tek tek yaz.

  --Örnek:
SELECT 
  customer_id,
  contact_name
 FROM `pacific-legend-474020-b4.wisdom_pets.customers`;


--ORDER BY Komutu. Sonuçları belli bir sıraya dizer.
  --ORDER BY, sonuçları istediğin ölçüte göre artan (ASC) ya da azalan (DESC) sıralar.
  --Varsayılan sıralama: Artan (ASC)—küçükten büyüğe / A→Z.
  --ORDER BY içinde sütun takma adını (AS) kullanabilirsin.
  --Çok seviyeli sıralama: Birden çok sütun virgül ile eklenir (örn. ORDER BY category_name, retail_price DESC).

  --Örnek: product id, name ve prices kolonlarını incele, price kolonuna göre artan fiyata göre sırala.
SELECT
  product_id,
  product_name,
  retail_price
FROM `pacific-legend-474020-b4.wisdom_pets.products`
ORDER BY retail_price;

--Örnek: Her kategoride indirim yüzdesi en yüksek ürünler için önce kategoriye, sonra indirim yüzdesine DESC göre sırala.
SELECT
  product_id,
  product_name,
  category_name,
  retail_price,
  wholesale_discount_percentage
FROM `pacific-legend-474020-b4.wisdom_pets.products`
ORDER BY
  category_name,
  wholesale_discount_percentage DESC;

--WHERE Komutu. Sonuçlara koşul koyar; sadece istediğin satırlar gelsin diye kullanırsın.
  --Satırları koşullara göre filtreler (tutma/eleme)
  --Eşitlik: = kullanılır (== değil); == sözdizimi hatasıdır.
  --Birebir eşleşme gerekir (case-sensitive, imla önemli)
  --Eşit değildir: != veya <>
  --Diğer karşılaştırmalar: <, > (ve kombinasyonları) kullanılabilir.

  --Örnek: Fiyatı tam olarak 100 olan satırları getir.
    --Tam eşitlik yerine aralık istersen: WHERE retail_price BETWEEN 99.5 AND 100.5
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price BETWEEN 5 AND 10
ORDER BY retail_price DESC;

-- Ürün adı tam olarak yazdığın metinse o satırları getirir
  --Metinler tek tırnak içinde yazılır; büyük/küçük harf duyarlıdır.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name = 'Medicated Dog Shampoo';

-- BigQuery çift tırnağı da metin olarak anlayabilir, ama önerilen tek tırnaktır.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name = "Medicated Dog Shampoo";

-- “Eşit değil” filtresi ( != )
  --NULL’ları da dışlamak istersen: WHERE category_name != 'Supplement' AND category_name IS NOT NULL
SELECT
  product_id,
  product_name,
  category_name
FROM `wisdom_pets.products`
WHERE category_name != 'Supplement' AND category_name IS NOT NULL;   --Kategorisi Supplement olmayan ürünleri getirir.

--“Eşit değil” için alternatif ( <> ) Aynı işi başka operatörle yapar; sonuç != ile aynıdır.
SELECT
  product_id,
  product_name,
  category_name
FROM `wisdom_pets.products`
WHERE category_name <> 'Supplement';

-- Örnek: “Care” kategorisinde en pahalı ürünleri göster.
  --Tek ürünü görmek istersen sonuna LIMIT 1 koy
  --ORDER BY her zaman LIMIT’ten önce gelir.
  --Kategori adını birebir yaz; harf/boşluk farkı sonuç vermez.
SELECT
  product_id,
  product_name,
  retail_price,
  category_name
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE category_name = 'Care'
ORDER BY retail_price DESC
LIMIT 1;


--IN and BETWEEN Operators: WHERE koşullarını yalnızca eşitlik için değil, daha geniş koşul aralıklarını yakalamak için de kullanmak isteriz. Bu noktada karşılaştırma operatörleri ile BETWEEN ve IN operatörlerinden yararlanabiliriz.

  -- Örnek: Fiyatı 6’dan küçük olanları getir.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price < 6
ORDER BY retail_price DESC;

-- Fiyatı 6’dan küçük olanları ya da 6 ve altı olanları getir.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price <= 6
ORDER BY retail_price DESC;

-- Fiyatı 55’ten büyük ürünleri getir.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price > 55
ORDER BY retail_price DESC;

--Fiyatı 55’ten büyük veya 55 ve üstü ürünleri getirir.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price >= 55   
ORDER BY retail_price DESC;

-- Fiyatı 15 ile 65 arasında (iki uç dahil) olanları getir. Uç değerler dahil istenmiyorsa > 15 AND < 65 yaz.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price BETWEEN 15 AND 65
ORDER BY retail_price;

-- Sınırlar ters yazılırsa aralık boş olur; sonuç gelmez. BETWEEN alt AND üst bekler; önce küçük, sonra büyük yaz.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price BETWEEN 65 AND 15
ORDER BY retail_price;

-- Fiyatı 0–75 aralığının dışındaki ürünleri getirir.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE retail_price NOT BETWEEN 0 and 75
ORDER BY retail_price;

-- IN ile belirli ürün ID’leri getirme. Listede yazdığın ID’lere tam eşleşen ürünleri getirir. IN çoklu OR yazmanın kısa yoludur. Sayıları tırnaksız, metinleri '...' içinde yaz.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_id IN (100013, 100041, 100051)
ORDER BY product_id;

-- IN ile belirli ürün adları. Metinler 'tek tırnak' içinde; harf/boşluk birebir olmalı. 
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name IN (
  'Strong Joints Cat Supplement',
  'Strong Joints Dog Supplement'
);

-- NOT IN ile kategori hariç
  --Kategori Care ve Supplement DEĞİL olanları getir.
  --NOT IN ve NULL: category_name NULL ise satır genelde düşer (karşılaştırma bilinmez olur). NULL’ları da görmek istersen ekle: OR category_name IS NULL.
SELECT
  product_id,
  product_name,
  category_name,
  retail_price
FROM `wisdom_pets.products`
WHERE category_name NOT IN (
  'Care',
  'Supplement'
)
ORDER BY category_name;

-- Örnek: kategori Care olsun, ve toptan indirim yüzdesi 20–30 arası olsun.
SELECT
  product_id,
  product_name,
  retail_price,
  category_name,
  wholesale_discount_percentage
FROM `pacific-legend-474020-b4.wisdom_pets.products`
  WHERE category_name = 'Care'
  AND wholesale_discount_percentage BETWEEN 20 AND 30;



-- Ürün adında “Dog” kelimesi geçen satırları getir(önü/sonu fark etmez). %Dog% “Dog” kelimesini içeren tüm adları getirir. % = “sıfır ya da daha çok karakter”; _ = “tek karakter”.
SELECT 
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE '%Dog%';

-- Adı “Dog” ile başlayan ürünler nedir? Dog% sonuna sadece % koyman yeterli.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE 'Dog%';

-- “Dog” ile bitenler - %Dog
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE '%Dog';

-- Sadece adı tam “Dog” olanları ister.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE 'Dog';

-- %dog% → küçük harf arama (0 kayıt; çünkü LIKE duyarlı) LIKE büyük/küçük harfe duyarlı; '%dog%' “Dog”’u bulmaz.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE '%dog%';

-- UPPER(...) ile duyarsız arama
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE UPPER(product_name) LIKE '%DOG%';

--LOWER(...) ile duyarsız arama
  --Regex ile: REGEXP_CONTAINS(product_name, r'(?i)dog') da olur. 
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE LOWER(product_name) LIKE '%dog%';

--LIKE ANY (...) → birden çok kalıp. Listeden en az bir kalıpla eşleşenleri getirir (IN’e benzer mantık). Çoklu kelime için REGEXP_CONTAINS(..., r'(?i)(dog|cat)') pratik.
SELECT
  product_id,
  product_name,
  retail_price
FROM `wisdom_pets.products`
WHERE product_name LIKE ANY ('%Dog%', '%Cat%');


-- Örnek: Ürün adında Teeth, Tooth ya da Coat geçenleri getir.
  --Aynısını regexle de yazabilirsin:  WHERE REGEXP_CONTAINS(product_name, r'(?i)(teeth|tooth|coat)') (bu sürüm harf duyarsızdır).
  --Büyük/küçük harf duyarsız istersen ya LOWER(...) kullan ya da regex’e (?i) ekle. 

SELECT
product_id,
product_name,
retail_price
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE product_name LIKE ANY ('%Teeth%', '%Tooth%', '%Coat%');



--COUNT Fonksiyonu
-- Tabloda kaç satır olduğunu sayar.
--COUNT(*) = tablonun toplam satır adedi.
--COUNT(*) her satırı sayar (NULL olup olmamasına bakmaz).

SELECT COUNT(*)
FROM `wisdom_pets.products`;

--Sayım sonucuna anlamlı bir sütun adı verelim

SELECT
  COUNT(*) AS row_count         --AS row_count çıktıyı isimlendirir.
FROM `wisdom_pets.products`;

-- Belirli sütunda dolu değer sayısı

SELECT
  COUNT(rating) AS rating_count
FROM `wisdom_pets.products`;

-- NULL olan kayıtları görmek
--COUNT(sütun) NULL’ları saymaz. NULL kontrolü IS NULL / IS NOT NULL ile yapılır. Eksik değerleri WHERE ... IS NULL ile yakalarsın.

SELECT
  product_id,
  product_name,
  rating
FROM `wisdom_pets.products`
WHERE rating IS NULL;

-- COUNT(DISTINCT) = farklı, benzersiz değer sayısı.
  --rating sütununda kaç farklı değer var, onu sayar. COUNT(DISTINCT ...) de NULL’ları yok sayar.

SELECT
  COUNT(DISTINCT rating) AS unique_ratings
FROM `wisdom_pets.products`;

-- rating değerlerini sıralayıp NULL’ları/dağılımı gözle incelersin.

SELECT
  product_id,
  product_name,
  rating
FROM `wisdom_pets.products`
ORDER BY rating;

-- Birden çok COUNT’u birlikte almak
  --Tek sorguda toplam, dolu rating, benzersiz kategori, benzersiz rating sayılarını alalım

SELECT
    COUNT(*) AS record_count,
    COUNT(rating) AS rating_count,
    COUNT(DISTINCT category_name) AS unique_category_count,
    COUNT(DISTINCT rating) AS unique_rating_count
FROM `wisdom_pets.products`;

-- Filtre + COUNT (önce WHERE, sonra sayım) Önce fiyatı ≤ 6 olanları seçer, sonra bu alt kümede sayımları yapar.

SELECT
    COUNT(*) AS record_count,
    COUNT(rating) AS rating_count,
    COUNT(DISTINCT category_name) AS unique_category_count,
    COUNT(DISTINCT rating) AS unique_rating_count
FROM `wisdom_pets.products`
WHERE retail_price <= 6;

-- ≤ 6 filtresine uymuş satırların kendisini görme

SELECT *
FROM `wisdom_pets.products`
WHERE retail_price <= 6;


-- Örnek: Kategorisi Care olan ve fiyatı 9’dan küçük olan ürünlerin adedi nedir? Birden çok koşul AND ile bağlanır; önce WHERE, sonra COUNT çalışır.


SELECT
  COUNT(product_name) AS product_counts
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE
category_name= 'Care'
AND retail_price < 9;


--Calculation Functions

--Toplayıcı fonksiyonlar (MIN/MAX)
  -- ürünlerin fiyat aralığı nedir? Tablodaki en küçük ve en büyük retail_price değerini bul; “fiyat aralığı nedir?” sorusuna cevap ver.
SELECT
    MIN(retail_price) AS minimum_price,
    MAX(retail_price) AS maximum_price
FROM `wisdom_pets.products`;

-- Ortalama indirim yüzdesi % nedir?
  --AVG NULL’ları dikkate almaz; sadece dolu satırlardan ortalama alır.
SELECT
    AVG(wholesale_discount_percentage) AS avg_discount
FROM `wisdom_pets.products`;

-- Ortalamayı 2 ondalığa yuvarlamak
  --ROUND(sayi, basamak) ile ondalık basamak sayısını seçersin.
SELECT
  ROUND(AVG(wholesale_discount_percentage),2) AS rounded_avg_discount
FROM `wisdom_pets.products`;

-- En yüksek “toptan fiyat”a göre ilk 5 ürün
SELECT
  product_id,
  product_name,
  retail_price,
  wholesale_discount_percentage,
  ROUND(retail_price * (1 - wholesale_discount_percentage / 100),2) AS wholesale_price
FROM `wisdom_pets.products`
ORDER BY wholesale_price DESC
LIMIT 5;

-- “Supplement” kategorisi için özet istatistik.
  --Sadece Supplement ürünlerinde ortalama fiyat, fiyatın standart sapması, benzersiz ürün sayısı ve ortalama puanı çıkar.
  --STDDEV (standart sapma) ve AVG NULL’ları saymaz
SELECT
    AVG(retail_price) AS average_retail_price,
    STDDEV(retail_price) AS stddev_retail_price,
    COUNT(DISTINCT product_id) AS unique_product_count,
    AVG(rating) AS average_rating
FROM `wisdom_pets.products`
WHERE category_name = 'Supplement';


-- Tüm Wisdom Pets ürünlerinin perakende fiyatının ortalaması ve standart sapması nedir?

SELECT
  ROUND( AVG(retail_price),2) AS average_retail_price,
  ROUND (STDDEV(retail_price),2) AS std_retail_price
FROM `pacific-legend-474020-b4.wisdom_pets.products`;


/*
Görev: 
Wisdom Pets dijital ekibi mevcut web sitesini iyileştirmek için bizi görevlendirdi. Özellikle, satın alınabilecek ürün yelpazesini öne çıkarmakla ilgileniyorlar. Ekipten gelen üç ana talep şöyle.

1. Web sitemizde beş yıldızlı ürünleri vurgulamak istiyoruz. En yüksek puanlı ürünleri; product_id, product_name, retail_price ve category ile, retail_price artan olacak şekilde sıralı sağlayabilir misiniz?

2. Supplement kategorisinde, özellikle köpekler için üretilmiş kaç ürünümüz var? Bu ürünlerin ortalama retail_price ve ortalama rating değerlerini iki ondalık basamağa yuvarlanmış olarak verin.

3. Web sitesinde toptan müşteri için özelleştirilmiş bir açılış sayfası oluşturmalıyız. Products tablosunu, ek alanlar olan wholesale_price ve discount_amount ile doldurmamız gerekiyor. Tüm fiyat alanları iki ondalık basamağa yuvarlanmalı ve tüm kayıtlar discount_amount azalan sırada listelenmelidir.
*/

--Soru 1) Beş yıldızlı, en yüksek puanlı ürünler → döndür: product_id, product_name, retail_price, category; fiyat artan sırada.
  -- Ürünlerin kimlik, ad, fiyat ve kategori bilgilerini getir; en ucuzdan pahalıya doğru sırala.

SELECT
  product_id,
  product_name,
  retail_price,
  category_name
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE rating = 5
ORDER BY retail_price ASC;


--Soru 2) Kategori Supplement olan ve adında “Dog” geçen ürünleri filtrele; bu alt kümede kaç ürün var, ortalama fiyat ve ortalama puan nedir, 2 ondalıkla ver.


SELECT
COUNT(*) AS product_count,
ROUND(AVG(retail_price),2) AS avg_retail_price,
ROUND(AVG(rating),2) AS avg_rating
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE category_name = 'Supplement' AND product_name LIKE '%Dog%';


--Soru 3) Toptan fiyat ve indirim tutarı; en çok indirimden aza
  --Her ürün için
  --wholesale_price = retail_price × (1 − %indirim/100)
  --discount_amount = retail_price × (%indirim/100)
  --hesaplanır; sonra en büyük indirim tutarına göre sıralanır.


SELECT
product_id,
product_name,
retail_price,
wholesale_discount_percentage,
retail_price * (1 - wholesale_discount_percentage/100) AS wholeasle_price,
retail_price * (wholesale_discount_percentage/100) AS discount_amount
FROM `pacific-legend-474020-b4.wisdom_pets.products`
ORDER BY discount_amount DESC;




--GROUP BY Komutu

-- Kategoriye göre satır sayısını bulalım.
  --SELECT ile kategori adını ve o gruptaki satır sayısını al.
  --GROUP BY category_name her kategori için gruplar oluşturur.
  --COUNT(*) her gruptaki satır adedini verir.
  --ORDER BY category_name alfabetik sıraya dizer.
    --Önemli notlar:
      --GROUP BY kullanınca, seçtiğin her sütun ya toplama (COUNT, AVG…) ya da GROUP BY içinde olmalı.
      --COUNT(*) NULL olup olmamasına bakmadan tüm satırları sayar.
SELECT
    category_name,
    COUNT(*) AS record_count
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY category_name;

-- Kategoriye göre birden çok hesap
  --Kategori bazında adet, ortalama fiyat ve en yüksek puanı hesapla.
  --Hepsi aynı GROUP BY category_name grupları üzerinde çalışır.
    -- Önemli notlar
      --AVG ve MAX NULL değerleri dikkate almaz (NULL’lar hesaba katılmaz).
      --Çıktıyı okunur yapmak için AS ile takma ad ver.
SELECT
    category_name,
    COUNT(*) AS record_count,
    AVG(retail_price) AS average_retail_price,
    MAX(rating) AS max_rating
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY category_name;

--HAVING ile grup sonuçlarını filtreleme
  --Önce kategoriye göre grupla ve metrikleri hesapla.
  --grup oluşturduktan SONRA HAVING ile çıktıyı filtrele (ortalama fiyatı < 10 olan kategoriler).
    --Önemli notlar
      --WHERE gruplamadan önce, HAVING gruplamadan sonra çalışır.
      --Bazı durumlarda HAVING’de alias (örn. average_retail_price) yerine ifadenin kendisini yazmak daha güvenlidir: HAVING AVG(retail_price) < 10.
SELECT
    category_name,
    COUNT(*) AS record_count,
    AVG(retail_price) AS average_retail_price,
    MAX(rating) AS max_rating
FROM `wisdom_pets.products`
GROUP BY category_name
HAVING average_retail_price < 10
ORDER BY category_name;

--10$ altı ürünleri kategoriye göre sayma
  --WHERE retail_price < 10 ile önce satırları filtrele.
  --Kalan satırları kategoriye göre grupla ve say.
    --Önemli notlar
      --WHERE gruplamadan önce çalıştığı için performans ve doğru sonuç için uygundur.
      --Tür uyumsuzluğu (metin/sayı) varsa önce SAFE_CAST(retail_price AS FLOAT64) < 10.
SELECT
    category_name,
    COUNT(*) AS record_count
FROM `wisdom_pets.products`
WHERE retail_price < 10
GROUP BY category_name
ORDER BY category_name;

--Kategori + indirim yüzdesine göre sayım (çok sütunla GROUP BY)
  --Gruplamayı iki sütun ile yap: kategori + indirim yüzdesi.
  --Her kombinasyon için kaç ürün olduğunu say.
  --Sonucu iki sütuna göre sırala (önce kategori, sonra indirim).
    --Önemli notlar
      --GROUP BY’da birden fazla sütun yazdığında, kombinasyonlar oluşur (her kategori+indirim çifti ayrı grup).
      --Yüzde sütunu metinse önce sayıya dönüştürmek gerekebilir.
SELECT
    category_name,
    wholesale_discount_percentage,
    COUNT(*) AS record_count
FROM `wisdom_pets.products`
GROUP BY
  category_name,
  wholesale_discount_percentage
ORDER BY
  category_name,
  wholesale_discount_percentage;


-- Her kategoride kaç ürünün puanı 4,5 veya üzerinde?
  --WHERE rating >= 4.5 ile yüksek puanlı ürünleri önce süz.
  --Kategoriye göre grupla ve adedini al.
    --Önemli notlar
      --rating metinse SAFE_CAST(rating AS FLOAT64) >= 4.5 kullan.
      --COUNT(*) filtre sonrası kalan satırları sayar.
SELECT
  category_name,
  COUNT(*) AS product_count
FROM `wisdom_pets.products`
WHERE rating >= 4.5
GROUP BY category_name;


--Case When Statements

-- Kedi/köpek ürünleri için bir segment adı atamak:
    /*Ne yapar? Ürün adında “Cat” geçiyorsa Cat, “Dog” geçiyorsa Dog, ikisi de değilse Other etiketi verir.
      Nasıl işler? CASE ilk sağlanan koşulda durur; sırayla kontrol eder.
      Çıktı: Her ürüne bir segment_name ekler, sonra bu sütuna göre sıralar.
        Önemli notlar
            LIKE büyük/küçük harfe duyarlı olabilir; gerekirse LOWER(product_name) LIKE '%cat%'.
            Koşul sırası önemlidir; önce yazılan koşul kazanır.*/
SELECT
    product_id,
    product_name,
    CASE
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
        ELSE 'Other'
    END AS segment_name
FROM `wisdom_pets.products`
ORDER BY segment_name;

-- ELSE zorunlu değil (aynı örnek)
    /*Ne yapar? Aynı mantık; burada vurgulanan: ELSE yazmak zorunlu değil, ama yazmak temizi.
    Neden iyi? ELSE yazarsan, hiçbir koşula uymayan kayıtlar boş (NULL) kalmaz.
      Önemli notlar
        ELSE yazmazsan eşleşmeyenler NULL olur.
        Raporlarda “boş sınıf” görmek istemiyorsan ELSE kullan.*/
SELECT
    product_id,
    product_name,
    CASE
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
    END AS segment_name
FROM `wisdom_pets.products`
ORDER BY segment_name;

-- ELSE yoksa sonuç NULL olabilir.
    --ORDER BY ... NULLS LAST/FIRST ile NULL’ların yerini kontrol edebilirsin.
SELECT
    product_id,
    product_name,
    CASE
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
   END AS segment_name
FROM `wisdom_pets.products`
ORDER BY segment_name NULLS LAST;

-- Her segment için kaç ürün var?
  /*Segmentlere göre sayım (CASE + GROUP BY)
  Ne yapar? Her ürün için segmenti hesaplar, sonra segment bazında adet döndürür.
  Nasıl işler? GROUP BY segment_name ile aynı etikettekileri gruplar, COUNT(*) ile sayar.
    Önemli notlar
      GROUP BY çıktıda seçtiğin her alan ya toplayıcı (COUNT/AVG…) ya da GROUP BY’da olmalı.
      Aynı CASE ifadesini hem SELECT hem GROUP BY yerine alias (segment_name) ile kullandık.*/
SELECT
    CASE
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
        ELSE 'Other'
    END AS segment_name,
    COUNT(*) AS product_count
FROM `wisdom_pets.products`
GROUP BY segment_name
ORDER BY segment_name;

/*--------------------------------------------------
Aşağıdaki fiyat aralıklarında kaç ürün bulunmaktadır:
  1 ila 5 dolar
  5 ila 10 dolar
  10 ila 25 dolar
  25 dolar ve üzeri
-------------------------------------------------- */
--Ürünleri fiyatına göre bantlara ayır ve her bantta kaç ürün olduğunu say.
SELECT
  CASE
    WHEN retail_price BETWEEN 1 AND 5
      THEN '$1 to $5'
    WHEN retail_price > 5 AND retail_price <= 10
      THEN '$5 to $10'
    WHEN retail_price > 10 AND retail_price <= 25
      THEN '$10 to $25'
    WHEN retail_price > 25
      THEN '$25 +'
    ELSE NULL
  END AS price_band,
  COUNT(*) AS product_count
FROM `wisdom_pets.products`
GROUP BY price_band;



--Countif Function


-- CASE ile ürün adında “Dog” geçiyorsa 1, geçmiyorsa 0 ver.
    --ORDER BY ... DESC ile 1’ler (Dog) üstte görünür.
    --Önemli notlar
      --LIKE büyük/küçük harfe duyarlı olabilir; emin olmak için LOWER(product_name) LIKE '%dog%'.
      --Bu aşama sadece işaretleme (etiketleme) yapar, sayım yapmaz.
SELECT
    product_name,
    CASE
        WHEN product_name LIKE '%Dog%'
            THEN 1
        ELSE 0
    END AS dog_product_flag
FROM `wisdom_pets.products`
ORDER BY dog_product_flag DESC;

-- 1/0 toplayarak Dog ürün sayısı. 1/0 mantığı COUNTIF’in manuel hali gibidir.
SELECT
    SUM(
        CASE
            WHEN product_name LIKE '%Dog%'
                THEN 1
            ELSE 0
        END
    ) AS dog_product_count
FROM `wisdom_pets.products`;

-- Her kategori için köpek ürünlerini sayın
    --GROUP BY category_name ile kategori bazında gruplar.
    --Her grupta 1/0’ları toplayıp Dog sayısını bul.
    --Önemli notlar
      --GROUP BY kullanınca SELECT’teki alanlar ya toplamalı ya da GROUP BY’da olmalı.
      --Büyük/küçük harf için yine LOWER(...) tercih edebilirsin.
SELECT
    category_name,
    SUM(
        CASE
            WHEN product_name LIKE '%Dog%'
                THEN 1
            ELSE 0
        END
    ) AS dog_product_count
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY dog_product_count DESC;

--COUNTIF ile her kategori için köpek ürünleri nedir?
    /*COUNTIF(koşul) = koşul TRUE olan satırları sayar.
    Kategori bazında Dog geçen ürün adedi.
      Önemli notlar
      Bu, SUM(CASE ... THEN 1 ELSE 0 END) ile aynı işi daha kısa yapar.
      COUNTIF yalnızca koşul doğruysa sayım yapar.*/
SELECT
    category_name,
    COUNTIF(product_name LIKE '%Dog%') AS dog_product_count
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY dog_product_count DESC;

--Her kategori için hem Köpek hem de Kedi ürünlerini sayın.
    /*Aynı gruplamada iki ayrı COUNTIF: Dog ve Cat.
    Sonucu kategori adına göre sırala (okuması kolay).
        Önemli notlar
        Koşulları genişletebilirsin (ör. AND rating IS NOT NULL).
        Harf duyarlılığı yine önemli.*/
SELECT
    category_name,
    COUNTIF(product_name LIKE '%Dog%') AS dog_product_count,
    COUNTIF(product_name LIKE '%Cat%') AS cat_product_count
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY category_name;

-- Köpek ve Kedi ürünlerinin ortalama kategori puanını (rating) bulun.
    /*CASE ile yalnızca ilgili satırlarda rating döndür, diğerlerinde NULL üret.
    AVG NULL’ları yok saydığı için, Dog/Cat alt kümelerinin ortalaması hesaplanır.
      Önemli notlar
      “1/0 flag” ile AVG alınmaz; sayısal değerin kendisini dönmek gerekir.
      rating metinse önce SAFE_CAST(rating AS FLOAT64).*/
SELECT
    category_name,
    AVG(
        CASE
            WHEN product_name LIKE '%Dog%'
                THEN rating
            ELSE NULL
        END
    ) AS avg_dog_rating,
    AVG(
        CASE
            WHEN product_name LIKE '%Cat%'
                THEN rating
            ELSE NULL
        END
    ) AS avg_cat_rating
FROM `wisdom_pets.products`
GROUP BY category_name
ORDER BY category_name;


-- Köpek/Kedi ürünlerinin kategori ortalama puanını ve sayısını göster
-- NULL puanı olan ürünleri sayıdan çıkar
    /*WHERE rating IS NOT NULL ile en başta boş rating’leri at.
    Kalanlarda Dog/Cat ortalamalarını ve adetlerini hesapla.
      Önemli notlar
      WHERE gruplamadan önce çalışır; hem AVG hem COUNTIF temiz veri üzerinden yapılır.
      Eğer COUNTIF’te de rating şartı isteseydin: COUNTIF(product_name LIKE '%Dog%' AND rating IS NOT NULL).*/
SELECT
    category_name,
    AVG(
        CASE
            WHEN product_name LIKE '%Dog%'
                THEN rating
            ELSE NULL
        END
    ) AS avg_dog_rating,
    AVG(
        CASE
            WHEN product_name LIKE '%Cat%'
                THEN rating
            ELSE NULL
        END
    ) AS avg_cat_rating,
    COUNTIF(product_name LIKE '%Dog%') AS dog_product_count,
    COUNTIF(product_name LIKE '%Cat%') AS cat_product_count
FROM `wisdom_pets.products`
WHERE rating IS NOT NULL
GROUP BY category_name
ORDER BY category_name;

/* ---------------------
Kaç tane 5 yıldızlı köpek ürünü var?
Kaç tane 4 yıldızlı kedi ürünü var?
--------------------------------------- 
  Tek bir COUNTIF içinde birden çok koşulu AND ile bağla.
  Kategori bazında 5 yıldızlı Dog ve 4 yıldızlı Cat ürün sayılarını ver.
    Önemli notlar
    COUNTIF(koşul1 AND koşul2) → ikisi de TRUE ise sayar.
    rating sayısal mı? Metinse SAFE_CAST(rating AS INT64) = 5.*/

SELECT
  category_name,
  COUNTIF(rating = 5 AND product_name LIKE '%Dog%') AS dog_product_5_star,
  COUNTIF(rating = 4 AND product_name LIKE '%Cat%') AS cat_product_4_star
FROM `wisdom_pets.products`
GROUP BY category_name;


--Pivot Function

-- GROUP BY ile ortalama puan ve adetleri göstermek
SELECT
    category_name,
    CASE
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        ELSE 'Other'
    END AS segment_name,
    AVG(rating) AS avg_rating,
    COUNT(*) AS product_count
FROM `wisdom_pets.products`
WHERE rating IS NOT NULL
GROUP BY
    category_name,
    segment_name
ORDER BY
    category_name,
    segment_name;

-- CTE (WITH) ile aynı seti hazırlamak
WITH cte_pivot_data AS (
SELECT
    category_name,
    CASE
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        ELSE 'Other'
    END AS segment_name,
    AVG(rating) AS avg_rating,
    COUNT(*) AS product_count
FROM `wisdom_pets.products`
GROUP BY
  category_name,
  segment_name
ORDER BY
  category_name,
  segment_name
)
SELECT * FROM cte_pivot_data;

-- PIVOT operatörüyle satırları sütuna çevirmek
WITH cte_pivot_data AS (
SELECT
    category_name,
    CASE
        WHEN product_name LIKE '%Dog%' THEN 'Dog'
        WHEN product_name LIKE '%Cat%' THEN 'Cat'
        ELSE 'Other'
    END AS segment_name,
    AVG(rating) AS avg_rating,
    COUNT(*) AS product_count
FROM `wisdom_pets.products`
GROUP BY
  category_name,
  segment_name
ORDER BY
  category_name,
  segment_name
)
SELECT * FROM cte_pivot_data
PIVOT(
    MAX(avg_rating) AS avg_rating,
    MAX(product_count) AS product_count
    FOR LOWER(segment_name) IN (
        'dog', 'cat', 'other'
    )
);

-- PIVOT kullanmadan, koşullu sütunlar açıp kolonlaştırma
WITH cte_pivot_data AS (
SELECT
  category_name,
  CASE
      WHEN product_name LIKE '%Dog%' THEN 'Dog'
      WHEN product_name LIKE '%Cat%' THEN 'Cat'
      ELSE 'Other'
  END AS segment_name,
  AVG(rating) AS avg_rating,
  COUNT(*) AS product_count
FROM `wisdom_pets.products`
GROUP BY
  category_name,
  segment_name
ORDER BY
  category_name,
  segment_name
)
SELECT
  category_name,
  MAX(CASE WHEN segment_name = 'Dog' THEN avg_rating END) AS avg_rating_dog,
  MAX(CASE WHEN segment_name = 'Dog' THEN product_count END) AS product_count_dog,
  MAX(CASE WHEN segment_name = 'Cat' THEN avg_rating END) AS avg_rating_cat,
  MAX(CASE WHEN segment_name = 'Cat' THEN product_count END) AS product_count_cat,
  MAX(CASE WHEN segment_name = 'Other' THEN avg_rating END) AS avg_rating_other,
  MAX(CASE WHEN segment_name = 'Other' THEN product_count END) AS product_count_other
FROM cte_pivot_data
GROUP BY category_name;


--MINI PROJE - 2
-- total_amount alanına göre en çok satan ilk 3 ürün kimliği (product_id) hangileridir?


SELECT
  product_id,
  SUM(total_amount) AS total_sales
FROM `pacific-legend-474020-b4.wisdom_pets.sales`
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 3;


-- Toplam satış ve işlem türüne (transaction_type) göre yüzde dağılımı nedir?

WITH cte_base_data AS (
SELECT
  transaction_type,
  SUM(total_amount) AS total_sales,    
  SUM(SUM(total_amount)) OVER () AS overall_sales    
FROM `wisdom_pets.sales`
GROUP BY transaction_type
)
SELECT
  transaction_type,
  total_sales,
  ROUND(
    total_sales / overall_sales,  
    2
  ) AS percentage_breakdown
FROM cte_base_data;



SELECT
transaction_type,
SUM(total_amount) AS total_sales,
ROUND (SUM(total_amount) / (select sum (total_amount) from `pacific-legend-474020-b4.wisdom_pets.sales`  ),2) AS perventage_breakdown
FROM `pacific-legend-474020-b4.wisdom_pets.sales`
GROUP BY transaction_type;




/*
--JOIN

1) Temel Kavramlar

JOIN amacı: Birden fazla tablodaki alanları ortak anahtar(lar) üzerinden birleştirip tek bir zenginleştirilmiş çıktı elde etmek.
Sol / Sağ tablo: Sorguda FROM sonrası yazılan sol (base); JOIN ile eklenen sağ (target) tablodur.
Eşleşme koşulu (ON): Satırlar hangi alan(lar) üzerinden eşleşecek? (örn. ON a.product_id = b.product_id)
Dikkat: Duplicates! Join öncesi tekrarları kontrol/temizleyin; aksi halde sayım ve toplamlar şişer.
NULL davranışı: Dış (outer) join’lerde eşleşmeyen taraftaki alanlar NULL döner.

2) JOIN Türleri (mantık + ne zaman kullanılır?)

CROSS JOIN
Mantık: Her sol satır × her sağ satır → Kartezyen çarpım (koşul yok).
Kullanım: Nadir ve dikkatle; küçük boyutlu referans kümeleriyle küçük çarpan üretmek.
Uyarı: Çok maliyetli; çoğu durumda kaçının.

INNER JOIN
Mantık: İki tarafta da eşleşen satırları döndürür.
Kullanım: En yaygın senaryo; “yalnızca ortak olanları getir” ihtiyacı.

LEFT OUTER JOIN (kısaca LEFT JOIN)
Mantık: Sol tablonun tamamı + sağdan eşleşenler; eşleşmeyen sağ alanlar NULL.
Kullanım: Sol tabloyu kayıpsız tutmak istediğinizde (ör. ürün kataloğu + satışlar).

RIGHT OUTER JOIN (RIGHT JOIN)
Mantık: Sağ tablonun tamamı + soldan eşleşenler.
Kullanım: Pratikte nadiren; genelde sorguyu ters çevirip LEFT JOIN ile yazmak daha okunur.

FULL OUTER JOIN
Mantık: Her iki tablonun tüm satırları; eşleşmeyen taraf alanları NULL.
Kullanım: “Tüm kayıtları görün, nerede eşleşme yoksa NULL olsun” ihtiyacı.
*/



--Inner Join

-- En çok satış yapan ürünler hangileridir?
-- Return the product name, category, sales and quantity

SELECT
  products.product_name,
  products.category_name,
  SUM(sales.total_amount) AS total_sales,
  SUM(sales.quantity) AS total_quantity
FROM `wisdom_pets.sales` AS sales
INNER JOIN `wisdom_pets.products` AS products
  ON sales.product_id = products.product_id
GROUP BY
  products.product_name,
  products.category_name
ORDER BY total_sales DESC;

/*
Önemli notlar:
INNER JOIN eşleşmeyen satırları getirmez (ürün tablosunda olmayan product_id’ler düşer).
Toplam alırken (SUM) sayısal tip gerekir; metinse SAFE_CAST(... AS FLOAT64).
GROUP BY’da toplanmayan tüm seçili sütunlar bulunmalı (burada product_name, category_name).
Ortak sütun adı aynıysa USING (product_id) yazıp kısaltabilirsin.*/

-- Left Join

--Perakende (Retail) vs Toptan (Wholesale) toplam satış kaç? Kayıtsız işlem var mı?

SELECT
  CASE
    WHEN customers.business_name IS NULL
      THEN 'Retail'
    WHEN customers.business_name IS NOT NULL
      THEN 'Wholesale'
    ELSE NULL
  END AS customer_type,
  CASE
    WHEN customers.customer_id IS NULL
      THEN 'Unregistered'
    WHEN customers.customer_id IS NOT NULL
      THEN 'Registered'
    ELSE NULL
  END AS registration_status,
  SUM(sales.total_amount) AS total_sales
FROM `wisdom_pets.sales` AS sales
LEFT JOIN `wisdom_pets.customers` AS customers
  ON sales.customer_id = customers.customer_id
GROUP BY
  customer_type,
  registration_status;

/*
FROM sales → satış kayıtlarını temel alır.

LEFT JOIN customers ON sales.customer_id = customers.customer_id
→ Satışların tamamı kalır; müşteri tablosunda eşleşme yoksa müşteri tarafı NULL olur.

CASE ... AS customer_type
→ business_name yoksa “Retail”, varsa “Wholesale” etiketi verir.

CASE ... AS registration_status
→ customers.customer_id yoksa “Unregistered”, varsa “Registered” etiketi verir.

SUM(sales.total_sales)
→ Her (customer_type, registration_status) grubu için toplam satış tutarını hesaplar.

GROUP BY customer_type, registration_status
→ İki etikete göre gruplar ve toplamı üretir.

Önemli notlar:
LEFT JOIN mantığı: Eşleşmeyen satışlar da sonuçta kalır (müşteri bilgileri NULL). Bu sayede “Unregistered” kayıtlar görülebilir.
CASE ve NULL: IS NULL / IS NOT NULL kullan; = NULL yanlıştır.
Perakende vs Toptan ayrımı: Burada varsayım, business_name varsa müşteri toptandır; yoksa perakende. Kurala göre değiştirilebilir.
Tip uyumu: sales.customer_id ile customers.customer_id aynı tipte olmalı (gerekirse SAFE_CAST).
Toplama sütunu: sales.total_sales sayısal (FLOAT/NUMERIC) olmalı; metinse SAFE_CAST(total_sales AS FLOAT64).*/




-- ALIŞTIRMA

-- Soru 1 — “Wholesale/Retail × VIP durumuna göre ortalama işlem büyüklüğü nedir”

with cte_transaction_size as(
  select
  sales.transaction_type,
  sales.transaction_id,
  customers.vip_customer_flag,
  sum(sales.total_amount) as transaction_size -- işlem büyüklüğü
  from wisdom_pets.sales as sales
  inner join wisdom_pets.customers as customers
  on sales.customer_id = customers.customer_id
  group by
  sales.transaction_type,
  sales.transaction_id,
  customers.vip_customer_flag
)
select
transaction_type,
vip_customer_flag,
round(avg(transaction_size),2) as avg_transaction_size
from cte_transaction_size
group by
transaction_type,
vip_customer_flag;



/*INNER JOIN: Satışları müşteri tablosuyla eşleştirir (VIP bilgisini almak için).
CTE içinde:
Her işlem (transaction_id) için toplam tutarı hesaplar → transaction_size.
İşlem türünü (Wholesale/Retail) ve VIP bayrağını yanına koyar.
Dış sorgu:
işlem türü × VIP kırılımında AVG(transaction_size) hesaplar.*/



-- Soru 2 — “Wholesale işlemlerinde toplam indirim tutarı nedir”


with cte_production_discount as(
select
sales.product_id,
sales.quantity,
products.retail_price*(products.wholesale_discount_percentage/100) as discount_amount_per_unit
FROM  `pacific-legend-474020-b4.wisdom_pets.sales` as sales
inner join `pacific-legend-474020-b4.wisdom_pets.products` as products
on sales.product_id = products.product_id
where transaction_type = 'Wholesale'
)
select
sum(quantity*discount_amount_per_unit) as total_wholesale_discount
from cte_production_discount;



/*INNER JOIN: Satış satırına ürünün liste fiyatı ve toptan indirim yüzdesini ekler.
CTE içinde:
Birim başına indirim: retail_price × (indirim% / 100).
Satır miktarı ile birlikte saklar (quantity).
Dış sorgu:
Satır bazında toplam indirim: quantity × discount_amount_per_unit.
Tüm satırlar için SUM alır → toplam indirim tutarı.
Önemli notlar
WHERE s.transaction_type = 'Wholesale' filtresi CTE içinde olduğundan, sadece toptan işlemler hesaplanır.
Yüzde ve fiyatların sayısal olduğundan emin ol:
SAFE_CAST(p.wholesale_discount_percentage AS FLOAT64), SAFE_CAST(p.retail_price AS FLOAT64).
Ondalık hassasiyet için sonuçta ROUND(..., 2) isteyebilirsin.*/



-- Ranking Functions

-- Satış performansına göre en iyi 5 müşteri (toplam satış) ve sıraları?

SELECT
  customer_id,
  SUM(total_amount) AS total_sales,
  RANK() OVER (ORDER BY SUM(total_amount) DESC) AS sales_rank
FROM `wisdom_pets.sales`
GROUP BY customer_id
QUALIFY sales_rank <= 5
ORDER BY sales_rank;



/*FROM wisdom_pets.sales
→ Satış kayıtları üzerinde çalış.
GROUP BY customer_id
→ Her müşteri için satırları bir araya topla.
SUM(total_amount) AS total_sales
→ Müşterinin toplam satış tutarını hesapla.
RANK() OVER (ORDER BY SUM(total_amount) DESC)
→ En yüksek satışa 1 numara vererek sıralama yap; eşitlikte aynı sırayı verir (atlama olabilir: 1,1,3 gibi).
QUALIFY sales_rank <= 5
→ Pencere fonksiyonu üretildikten sonra yalnızca ilk 5 sırayı tut.
ORDER BY sales_rank
→ Çıktıyı sıraya göre küçükten büyüğe diz.

Önemli notlar
QUALIFY, BigQuery’nin pencere fonksiyonlarını filtrelemek için sunduğu özel bir aşamadır; WHERE gibi çalışmaz (çünkü WHERE pencereden önce yürür).
RANK eşitlikte sıra paylaşır (1,1,3); kesintisiz sıra istersen DENSE_RANK(), her satıra benzersiz sıra istersen ROW_NUMBER() kullan.
Pencere fonksiyonundaki ORDER BY SUM(total_amount) ifadesi, aynı SELECT’te hesaplanan toplamla uyumludur (alternatif: ORDER BY total_sales da yazılabilir).
total_amount sayısal olmalı; metinse SAFE_CAST(total_amount AS FLOAT64) kullan.
Çok büyük veri için performans/kostu azaltmak adına tarih aralığı ya da ön filtre eklemek iyi fikir olabilir.*/




--Cumulative Metrics

--2022 yılı için aylık satış ve kümülatif satışlar nedir?

WITH cte_monthly_sales AS (
SELECT
customer_id,
  DATE_TRUNC(transaction_date, MONTH) AS month_start,
  round(SUM(total_amount),2) AS monthly_sales
FROM `wisdom_pets.sales`
WHERE transaction_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY month_start, customer_id
)
SELECT
customer_id,
  month_start,
  monthly_sales,
  SUM(monthly_sales) OVER ( PARTITION BY customer_id ORDER BY month_start) AS monthly_cumulative_sales
FROM cte_monthly_sales
ORDER BY month_start, customer_id;

/*
DATE_TRUNC(transaction_date, MONTH) → Her işlemin tarihini ayın ilk gününe yuvarlar (ör. 2022-03-15 → 2022-03-01).
WHERE ... BETWEEN '2022-01-01' AND '2022-12-31' → Sadece 2022 yılı işlemlerini alır.
GROUP BY month_start + SUM(total_amount) → Her ay için toplam satışı hesaplar → monthly_sales.
Dış sorgu:
4) SUM(monthly_sales) OVER (ORDER BY month_start) → Ay sırasına göre kümülatif toplamı hesaplar (Ocak, Ocak+Şubat, Ocak+Şubat+Mart, …).
5) ORDER BY month_start → Çıktıyı ay ay kronolojik sırada listeler.

Önemli notlar
Tarih aralığı: BETWEEN iki ucu dahil eder. Tam yıl için uygundur. Saat damgalı bir alan olsaydı (TIMESTAMP), gün sonu sorunlarına dikkat edilmeliydi (örn. >= '2022-01-01' AND < '2023-01-01' daha güvenli).
DATE_TRUNC: Ay kırpması, aynı aya düşen tüm işlemleri tek “month_start” değeri altında toplar (her zaman o ayın 1’i).
Pencere fonksiyonu: OVER (ORDER BY month_start) kümülatif toplam için partition istemez; tek seri halinde birikir.
Eksik aylar: O ayda hiç satış yoksa o ay listede görünmez. Takvimde her ayı göstermek istiyorsan bir takvim tablosu (veya GENERATE_DATE_ARRAY) ile LEFT JOIN yapman gerekir.
Tip/temizlik: total_amount metinse SAFE_CAST(total_amount AS FLOAT64) yap. Null satışlar SUM’da zaten yok sayılır.
*/



--Moving Averages

-- Wholesale ve Retail için günlük satışların son 7 ve 28 günlük hareketli ortalaması (en güncel tarih itibarıyla)

WITH cte_daily_sales AS (
SELECT
  transaction_type,
  transaction_date,
  SUM(total_amount) AS daily_sales
FROM `wisdom_pets.sales`
GROUP BY
  transaction_type,
  transaction_date
)
SELECT
  transaction_type,
  AVG(daily_sales) OVER (PARTITION BY transaction_type,ORDER BY UNIX_DATE(transaction_date) RANGE BETWEEN 6 PRECEDING AND CURRENT ROW ) AS sales_7_day_moving_average,
  AVG(daily_sales) OVER (
    PARTITION BY transaction_type,
    ORDER BY UNIX_DATE(transaction_date)
    RANGE BETWEEN 27 PRECEDING AND CURRENT ROW
  ) AS sales_28_day_moving_average
FROM cte_daily_sales
QUALIFY RANK() OVER (ORDER BY transaction_date DESC) = 1;

/*
CTE (cte_daily_sales):
Her (transaction_type, transaction_date) çifti için SUM(total_amount) ile günlük satışı (daily_sales) çıkarır.

Dış sorgu:
2) PARTITION BY transaction_type
→ Wholesale ve Retail’i ayrı ayrı ele al.
3) ORDER BY UNIX_DATE(transaction_date)
→ Tarihi güne çevirip (tam sayı) kronolojik sıraya koy.
4) RANGE BETWEEN 6 PRECEDING AND CURRENT ROW
→ İçinde bulunulan gün dâhil son 7 takvim günü aralığını al ve AVG(daily_sales) hesapla.
(Benzer şekilde 28 gün için 27 PRECEDING.)
5) QUALIFY DENSE_RANK() ... = 1
→ Her transaction_type için en güncel tarihli satırı bırak (yani “bugünkü”/“son günün” 7G ve 28G ortalaması).
6) ORDER BY transaction_type
→ Çıktıyı tür bazında düzenli göster.

Önemli notlar
Düzeltilen yazım: PARTITION BY transaction_type, satırındaki fazla virgül kaldırıldı; aksi hâlde sözdizimi hatası olur.
Neden UNIX_DATE? RANGE çerçevesi sayısal sıraya ihtiyaç duyar; DATE → UNIX_DATE(DATE) ile gün cinsinden tam sayıya çevrilir.
Takvim günü vs satır sayısı: RANGE “gün bazlı” aralık alır. O günlerde veri yoksa, ortalama daha az günden hesaplanır (gerçek 7 kayıt olmayabilir). “Tam 7 satır” istersen ROWS BETWEEN 6 PRECEDING AND CURRENT ROW kullan; bu sefer kayıt sayısına göre hareket eder.
Boş günler (gap) etkisi: Satış olmayan günler tabloda yoksa, 7G/28G ortalama beklediğinden farklı olabilir. Tüm günleri içeren bir takvim ile LEFT JOIN yaparak boş günleri 0’la doldurmak daha tutarlı sonuç verir.
QUALIFY mantığı: Pencere fonksiyonu oluşturduktan sonra filtreler; WHERE yerine kullanılır (çünkü WHERE pencereden önce çalışır).
Büyük veri ipucu: Önce tarih filtresi (örn. son 2 yıl) ekleyerek maliyeti düşürebilirsin.
Tip uyumu: total_amount metinse SAFE_CAST(total_amount AS FLOAT64) ile sayıya çevir.*/







