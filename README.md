# BigQuery_SQL_Rehberi_Sorgular
Data Masası | BigQuery SQL Rehberi: Ders notları (README). SELECT, WHERE, GROUP BY, JOIN, PIVOT, window funcs, KPI örnekleri.

# Veri Bilimi için BigQuery SQL Rehberi — Ders Özeti

---

## 1) SELECT — Tablodan veri getirme
- Tam tablo görüntüleme: `SELECT * FROM \`…\`;`
- Belirli sütunlar: `SELECT customer_id, contact_name FROM \`…customers\`;`

## 2) ORDER BY — Sonuçları sırala
- Artan/azalan: `ORDER BY retail_price [ASC|DESC]`
- Birden çok anahtar: `ORDER BY category_name, wholesale_discount_percentage DESC`

## 3) WHERE — Satır filtresi
- Karşılaştırma: `=, != (<>), <, <=, >, >=`
- Aralık: `WHERE retail_price BETWEEN 15 AND 65`
- Eşitsizlik: `WHERE category_name != 'Supplement' AND category_name IS NOT NULL`
- Tam eşleşme (metin): `WHERE product_name = 'Medicated Dog Shampoo'`

## 4) IN / NOT IN — Liste eşleşmesi
- ID listesi: `WHERE product_id IN (100013, 100041, 100051)`
- Metin listesi: `WHERE product_name IN ('Strong Joints Cat Supplement','Strong Joints Dog Supplement')`
- Hariç bırakma: `WHERE category_name NOT IN ('Care','Supplement')`

## 5) LIKE / REGEXP — Kalıp eşleşmesi
- İçerir: `WHERE product_name LIKE '%Dog%'`
- Başlar / biter: `LIKE 'Dog%'` / `LIKE '%Dog'`
- Harf duyarsız: `WHERE LOWER(product_name) LIKE '%dog%'` veya `REGEXP_CONTAINS(product_name, r'(?i)dog')`
- Çoklu kalıp: `WHERE product_name LIKE ANY ('%Dog%','%Cat%')` (alternatif: `REGEXP_CONTAINS(..., r'(?i)(dog|cat)')`)

## 6) COUNT / DISTINCT / NULL kontrolü
- Toplam satır: `SELECT COUNT(*) FROM \`…products\`;`
- Dolu değer sayısı: `COUNT(rating)`
- Benzersiz: `COUNT(DISTINCT category_name)`
- NULL filtre: `WHERE rating IS NULL` / `IS NOT NULL`

## 7) Toplayıcı fonksiyonlar
- Min/Max: `MIN(retail_price)`, `MAX(retail_price)`
- Ortalama: `AVG(wholesale_discount_percentage)` → yuvarla: `ROUND(AVG(...),2)`
- Türetilmiş fiyat: `retail_price * (1 - wholesale_discount_percentage/100)`

## 8) GROUP BY / HAVING — Kırılımda özetler
- Kategori bazında adet: `SELECT category_name, COUNT(*) FROM \`…products\` GROUP BY category_name`
- Birden çok metrik: `COUNT(*) , AVG(retail_price) , MAX(rating)`
- Grup sonrası filtre: `HAVING AVG(retail_price) < 10`
- Gruplama öncesi filtre: `WHERE retail_price < 10`

## 9) CASE — Koşullu ifade
- Etiketleme: `CASE WHEN product_name LIKE '%Cat%' THEN 'Cat' WHEN ... THEN 'Dog' ELSE 'Other' END AS segment_name`
- Fiyat bandı: `CASE WHEN retail_price BETWEEN 1 AND 5 THEN '$1 to $5' ... END AS price_band`

## 10) COUNTIF — Koşullu sayım
- Dog geçen ürün sayısı: `COUNTIF(product_name LIKE '%Dog%')`
- Birden çok koşul: `COUNTIF(rating = 5 AND product_name LIKE '%Dog%')`

## 11) PIVOT — Satırları sütuna çevirme
- Hazırlık: kategori × segment için `AVG(rating), COUNT(*)`
- Dönüşüm: `... PIVOT( MAX(avg_rating) AS avg_rating, MAX(product_count) AS product_count FOR LOWER(segment_name) IN ('dog','cat','other') )`

## 12) Mini Proje — Örnekler
- En çok satış yapan 3 ürün: `SELECT product_id, SUM(total_amount) AS total_sales ... ORDER BY total_sales DESC LIMIT 3`
- İşlem türüne göre yüzde dağılımı: `ROUND( total_sales / overall_sales, 2 ) AS percentage_breakdown`

## 13) JOIN — Tabloları birleştirme
- INNER JOIN: yalnızca eşleşenler (`ON a.product_id = b.product_id`)
- LEFT JOIN: soldakilerin hepsi + sağdan eşleşenler (eşleşmeyen sağ alanlar `NULL`)
- Örnek: ürün özellikleriyle satışları zenginleştirme; müşteri tipini CASE ile etiketleme

## 14) Ranking (Sıralama fonksiyonları)
- En iyi 5 müşteri: `RANK() OVER (ORDER BY SUM(total_amount) DESC) AS sales_rank` + `QUALIFY sales_rank <= 5`

## 15) Kümülatif metrikler
- Aylık satış ve kümülatif: `DATE_TRUNC(transaction_date, MONTH)` ve `SUM(monthly_sales) OVER (PARTITION BY customer_id ORDER BY month_start)`

## 16) Hareketli ortalamalar
- Günlük 7G/28G HO: `AVG(daily_sales) OVER (PARTITION BY transaction_type ORDER BY UNIX_DATE(transaction_date) RANGE BETWEEN 6 PRECEDING AND CURRENT ROW)`

---

### İpuçları (BigQuery)
- `QUALIFY` pencereden sonra filtre için idealdir.
- `SAFE_CAST` hatalı tip dönüşümlerinde NULL üretir ve sorgunun patlamasını engeller.
- Tarihte güvenli aralık: `WHERE ts >= '2022-01-01' AND ts < '2023-01-01'`
- `ROWS` vs `RANGE`: hareketli hesaplarda satır sayısı vs değer aralığı farkını unutma.
