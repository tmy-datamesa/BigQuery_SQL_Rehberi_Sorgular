-- SQL METİN (STRING) FONKSİYONLARI PRATİK DOSYASI
-- Şema: wisdom_pets (Tablolar: customers, products, sales)

--------------------------------------------------------------------------------
-- 1. CONCAT() FONKSİYONU: Metin Birleştirme
--------------------------------------------------------------------------------

-- Konu: İki veya daha fazla metin parçasını tek bir metinde birleştirir.
-- Sözdizimi: CONCAT(metin1, metin2, ...)

-- Soru 1.1: customers tablosundaki contact_name ve phone_number bilgilerini aralarına 
--           " | Telefon: " koyarak birleştirin.
SELECT
    customer_id,
    contact_name,
    phone_number,
    CONCAT(contact_name, ' | Telefon: ', phone_number) AS customer_and_phone
FROM `pacific-legend-474020-b4.wisdom_pets.customers`;

--------------------------------------------------------------------------------
-- 2. REPLACE() FONKSİYONU: Metin Değiştirme
--------------------------------------------------------------------------------

-- Konu: Kaynak metin içindeki bir alt metni, belirtilen yeni bir alt metin ile değiştirir.
-- Sözdizimi: REPLACE(kaynak, eski_metin, yeni_metin)

-- Soru 2.1: products tablosundaki tüm product_name'lerde geçen "Package" kelimesini 
--           "Set" kelimesiyle değiştirin ve sadece değişikliğin olduğu ürünleri gösterin.
SELECT
    product_name AS original_name,
    REPLACE(product_name, 'Package', 'Set') AS updated_name
FROM `pacific-legend-474020-b4.wisdom_pets.products`
WHERE product_name LIKE '%Package%';

--------------------------------------------------------------------------------
-- 3. LENGTH() FONKSİYONU: Metin Uzunluğu Ölçme
--------------------------------------------------------------------------------

-- Konu: Verilen metnin karakter sayısını (uzunluğunu) döndürür.
-- Sözdizimi: LENGTH(metin)

-- Soru 3.1: customers tablosundaki postal_address'lerin uzunluklarını listeleyin 
--           ve en uzun 5 adresi bulun.
SELECT
    contact_name,
    postal_address,
    LENGTH(postal_address) AS address_length
FROM `pacific-legend-474020-b4.wisdom_pets.customers`
ORDER BY address_length DESC;

--------------------------------------------------------------------------------
-- 4. SUBSTR() FONKSİYONU: Alt Metin Alma
--------------------------------------------------------------------------------

-- Konu: Kaynak metin içinden belirli bir pozisyondan başlayarak alt metin alır.
-- Sözdizimi: SUBSTR(kaynak, başlangıç_pozisyonu, [uzunluk])

-- Soru 4.1: customers tablosundaki email_address'lerin sadece ilk 5 karakterini alın.
SELECT
    email_address AS full_email,
    SUBSTR(email_address, 1, 5) AS email_prefix
FROM `pacific-legend-474020-b4.wisdom_pets.customers`;

-- Soru 4.2: customers tablosundaki contact_name sütununda yer alan adın sadece ilk harfini alın.

SELECT
  email_address AS full_email,
  SUBSTR(email_address, STRPOS(email_address, '@')) AS domain_with_at,
  SUBSTR(email_address, STRPOS(email_address, '@') + 1) AS email_domain
FROM `pacific-legend-474020-b4.wisdom_pets.customers`;
