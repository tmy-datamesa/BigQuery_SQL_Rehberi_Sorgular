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
