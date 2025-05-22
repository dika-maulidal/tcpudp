USE supermart ;

-- Tabel BARCODE
CREATE TABLE BARCODE (
    barcodeID INT PRIMARY KEY,
    nama_item_produk VARCHAR(255),
    tanggal_masuk DATE
);

-- Tabel PRODUK
CREATE TABLE PRODUK (
    produkID INT PRIMARY KEY,
    nama_produk VARCHAR(255),
    kategori_produk VARCHAR(255),
    harga_jual DECIMAL(10, 2),
    jumlah_stok INT,
    barcodeID INT,
    FOREIGN KEY (barcodeID) REFERENCES BARCODE(barcodeID)
);

-- Tabel SUPPLIER
CREATE TABLE SUPPLIER (
    supplierID INT PRIMARY KEY,
    nama_supplier VARCHAR(255),
    alamat_supplier VARCHAR(255),
    telepon VARCHAR(20),
    produkID INT,
    FOREIGN KEY (produkID) REFERENCES PRODUK(produkID)
);

-- Tabel RESTOCK
CREATE TABLE RESTOCK (
    restockID INT PRIMARY KEY,
    tanggal_restock DATE,
    supplierID INT,
    FOREIGN KEY (supplierID) REFERENCES SUPPLIER(supplierID)
);

-- Tabel DTL_RESTOCK
CREATE TABLE DTL_RESTOCK (
    detail_restockID INT PRIMARY KEY,
    jumlah_dipesan INT,
    jumlah_diterima INT,
    harga_beli DECIMAL(10, 2),
    produkID INT,
    restockID INT,
    barcodeID INT,
    FOREIGN KEY (produkID) REFERENCES PRODUK(produkID),
    FOREIGN KEY (restockID) REFERENCES RESTOCK(restockID),
    FOREIGN KEY (barcodeID) REFERENCES BARCODE(barcodeID)
);

-- Tabel HARGA_NAIK
CREATE TABLE HARGA_NAIK (
    harganaikID INT PRIMARY KEY,
    restockID INT,
    harga_lama DECIMAL(10, 2),
    harga_baru DECIMAL(10, 2),
    tanggal_restock DATE,
    FOREIGN KEY (restockID) REFERENCES RESTOCK(restockID)
);

-- Tabel PELANGGAN
CREATE TABLE PELANGGAN (
    pelangganID INT PRIMARY KEY
);

-- Tabel NON_MEMBER
CREATE TABLE NON_MEMBER (
    pelangganID INT PRIMARY KEY,
    FOREIGN KEY (pelangganID) REFERENCES PELANGGAN(pelangganID)
);

-- Tabel MEMBER
CREATE TABLE MEMBER (
    pelangganID INT PRIMARY KEY,
    nama VARCHAR(255),
    no_tlp VARCHAR(20),
    email VARCHAR(255),
    total_point INT,
    FOREIGN KEY (pelangganID) REFERENCES PELANGGAN(pelangganID)
);

-- Tabel DISKON
CREATE TABLE DISKON (
    diskonID INT PRIMARY KEY,
    poin_reward INT
);

-- Tabel TRANSAKSI
CREATE TABLE TRANSAKSI (
    transaksiID INT PRIMARY KEY,
    tanggal_waktu DATETIME,
    total_pembayaran DECIMAL(10, 2),
    pelangganID INT,
    diskonID INT,
    FOREIGN KEY (pelangganID) REFERENCES PELANGGAN(pelangganID),
    FOREIGN KEY (diskonID) REFERENCES DISKON(diskonID)
);

-- Tabel DETAIL_TRANSAKSI
CREATE TABLE DETAIL_TRANSAKSI (
    detail_transaksiID INT PRIMARY KEY,
    transaksiID INT,
    produkID INT,
    jumlah INT,
    harga_per_unit DECIMAL(10, 2),
    sub_total DECIMAL(10, 2),
    FOREIGN KEY (transaksiID) REFERENCES TRANSAKSI(transaksiID),
    FOREIGN KEY (produkID) REFERENCES PRODUK(produkID)
);

-- Datasets

-- Tabel BARCODE
INSERT INTO BARCODE (barcodeID, nama_item_produk, tanggal_masuk) VALUES
(1, 'Mie Instan Sedap', '2025-05-01'),
(2, 'Sikat Gigi', '2025-05-02'),
(3, 'Sabun Colek', '2025-05-03'),
(4, 'Beras 5kg', '2025-05-04'),
(5, 'Minuman Botol', '2025-05-05');

INSERT INTO BARCODE (barcodeID, nama_item_produk, tanggal_masuk) VALUES
(6, 'Kopi Sachet', '2025-05-06'),
(7, 'Pasta Gigi', '2025-05-07'),
(8, 'Sabun Mandi', '2025-05-08'),
(9, 'Tisu Gulung', '2025-05-09'),
(10, 'Air Mineral Galon', '2025-05-10');

-- Tabel PRODUK
INSERT INTO PRODUK (produkID, nama_produk, kategori_produk, harga_jual, jumlah_stok, barcodeID) VALUES
(1, 'Mie Instan Sedap', 'Makanan', 2500.00, 50, 1),
(2, 'Sikat Gigi', 'Perawatan Pribadi', 15000.00, 30, 2),
(3, 'Sabun Colek', 'Perawatan Pribadi', 5000.00, 40, 3),
(4, 'Beras 5kg', 'Makanan', 60000.00, 20, 4),
(5, 'Minuman Botol', 'Minuman', 3500.00, 60, 5);

INSERT INTO PRODUK (produkID, nama_produk, kategori_produk, harga_jual, jumlah_stok, barcodeID) VALUES
(6, 'Kopi Sachet', 'Minuman', 2000.00, 100, 6),
(7, 'Pasta Gigi', 'Perawatan Pribadi', 12000.00, 40, 7),
(8, 'Sabun Mandi', 'Perawatan Pribadi', 7000.00, 35, 8),
(9, 'Tisu Gulung', 'Kebutuhan Rumah Tangga', 8000.00, 25, 9),
(10, 'Air Mineral Galon', 'Minuman', 18000.00, 15, 10);

-- Tabel SUPPLIER
INSERT INTO SUPPLIER (supplierID, nama_supplier, alamat_supplier, telepon, produkID) VALUES
(1, 'PT Indofood', 'Jakarta', '021-123456', 1),
(2, 'PT Unilever', 'Tangerang', '021-654321', 2),
(3, 'PT Wings', 'Bekasi', '021-789012', 3),
(4, 'PT Bulog', 'Bandung', '022-345678', 4),
(5, 'PT Aqua', 'Bogor', '0251-901234', 5);

INSERT INTO SUPPLIER (supplierID, nama_supplier, alamat_supplier, telepon, produkID) VALUES
(6, 'PT Kapal Api', 'Surabaya', '031-123456', 6),
(7, 'PT Pepsodent', 'Jakarta', '021-789654', 7),
(8, 'PT Lifebuoy', 'Bekasi', '021-456789', 8),
(9, 'PT Paseo', 'Bogor', '0251-123789', 9),
(10, 'PT Danone', 'Jakarta', '021-998877', 10);

-- Tabel RESTOCK
INSERT INTO RESTOCK (restockID, tanggal_restock, supplierID) VALUES
(1, '2025-05-15', 1),
(2, '2025-05-16', 2),
(3, '2025-05-16', 3),
(4, '2025-05-17', 4),
(5, '2025-05-17', 5);

INSERT INTO RESTOCK (restockID, tanggal_restock, supplierID) VALUES
(6, '2025-05-18', 6),
(7, '2025-05-18', 7),
(8, '2025-05-19', 8),
(9, '2025-05-19', 9),
(10, '2025-05-20', 10);

-- Tabel DTL_RESTOCK
INSERT INTO DTL_RESTOCK (detail_restockID, jumlah_dipesan, jumlah_diterima, harga_beli, produkID, restockID, barcodeID) VALUES
(1, 100, 95, 2000.00, 1, 1, 1),
(2, 50, 48, 12000.00, 2, 2, 2),
(3, 80, 78, 4000.00, 3, 3, 3),
(4, 30, 29, 55000.00, 4, 4, 4),
(5, 100, 98, 3000.00, 5, 5, 5);

INSERT INTO DTL_RESTOCK (detail_restockID, jumlah_dipesan, jumlah_diterima, harga_beli, produkID, restockID, barcodeID) VALUES
(6, 120, 118, 2500.00, 6, 6, 6),
(7, 60, 59, 13000.00, 7, 7, 7),
(8, 90, 87, 4500.00, 8, 8, 8),
(9, 40, 39, 52000.00, 9, 9, 9),
(10, 110, 109, 2800.00, 10, 10, 10);

-- Tabel HARGA_NAIK
INSERT INTO HARGA_NAIK (harganaikID, restockID, harga_lama, harga_baru, tanggal_restock) VALUES
(1, 1, 2000.00, 2200.00, '2025-05-15'),
(2, 2, 12000.00, 13000.00, '2025-05-16'),
(3, 3, 4000.00, 4500.00, '2025-05-16'),
(4, 4, 55000.00, 58000.00, '2025-05-17'),
(5, 5, 3000.00, 3200.00, '2025-05-17');

INSERT INTO HARGA_NAIK (harganaikID, restockID, harga_lama, harga_baru, tanggal_restock) VALUES
(6, 6, 2500.00, 2700.00, '2025-05-18'),
(7, 7, 13000.00, 13500.00, '2025-05-18'),
(8, 8, 4500.00, 4700.00, '2025-05-19'),
(9, 9, 52000.00, 54000.00, '2025-05-19'),
(10, 10, 2800.00, 3000.00, '2025-05-20');

-- Tabel PELANGGAN
INSERT INTO PELANGGAN (pelangganID) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO PELANGGAN (pelangganID) VALUES
(6),
(7),
(8),
(9),
(10);

-- Tabel NON_MEMBER
INSERT INTO NON_MEMBER (pelangganID) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO NON_MEMBER (pelangganID) VALUES
(6),
(7),
(8),
(9),
(10);

-- Tabel MEMBER
INSERT INTO MEMBER (pelangganID, nama, no_tlp, email, total_point) VALUES
(1, 'Ahmad', '08123456789', 'ahmad@egmail.com', 50),
(2, 'Budi', '08123456790', 'budi@yahoo.com', 100),
(3, 'Citra', '08123456791', 'citra@gmail.com', 75),
(4, 'Dedi', '08123456792', 'dedi@gmail.com', 120),
(5, 'Eka', '08123456793', 'eka@estudent.telkomuniversity.ac.id', 90);

INSERT INTO MEMBER (pelangganID, nama, no_tlp, email, total_point) VALUES
(6, 'Fajar', '08123456794', 'fajar@gmail.com', 80),
(7, 'Gina', '08123456795', 'gina@yahoo.com', 60),
(8, 'Hendra', '08123456796', 'hendra@gmail.com', 110),
(9, 'Intan', '08123456797', 'intan@outlook.com', 95),
(10, 'Joko', '08123456798', 'joko@telkomuniversity.ac.id', 70);

-- Tabel DISKON
INSERT INTO DISKON (diskonID, poin_reward) VALUES
(1, 50),
(2, 100),
(3, 75),
(4, 150),
(5, 200);

INSERT INTO DISKON (diskonID, poin_reward) VALUES
(6, 250),
(7, 300),
(8, 125),
(9, 175),
(10, 225);

-- Tabel TRANSAKSI
INSERT INTO TRANSAKSI (transaksiID, tanggal_waktu, total_pembayaran, pelangganID, diskonID) VALUES
(1, '2025-05-17 14:00:00', 5000.00, 1, 1),
(2, '2025-05-17 14:05:00', 30000.00, 2, 2),
(3, '2025-05-17 14:10:00', 10000.00, 3, 3),
(4, '2025-05-17 14:15:00', 70000.00, 4, 4),
(5, '2025-05-17 14:20:00', 7000.00, 5, 5);

INSERT INTO TRANSAKSI (transaksiID, tanggal_waktu, total_pembayaran, pelangganID, diskonID) VALUES
(6, '2025-05-17 14:25:00', 6500.00, 1, 6),
(7, '2025-05-17 14:30:00', 4500.00, 2, 7),
(8, '2025-05-17 14:35:00', 12500.00, 3, 8),
(9, '2025-05-17 14:40:00', 10500.00, 4, 9),
(10, '2025-05-17 14:45:00', 15000.00, 5, 10);

-- Tabel DETAIL_TRANSAKSI
INSERT INTO DETAIL_TRANSAKSI (detail_transaksiID, transaksiID, produkID, jumlah, harga_per_unit, sub_total) VALUES
(1, 1, 1, 2, 2500.00, 5000.00),
(2, 2, 2, 2, 15000.00, 30000.00),
(3, 3, 3, 2, 5000.00, 10000.00),
(4, 4, 4, 1, 60000.00, 60000.00),
(5, 5, 5, 2, 3500.00, 7000.00);

INSERT INTO DETAIL_TRANSAKSI (detail_transaksiID, transaksiID, produkID, jumlah, harga_per_unit, sub_total) VALUES
(6, 6, 6, 1, 6500.00, 6500.00),
(7, 7, 7, 1, 4500.00, 4500.00),
(8, 8, 8, 2, 6250.00, 12500.00),
(9, 9, 9, 3, 3500.00, 10500.00),
(10, 10, 10, 2, 7500.00, 15000.00);

-- CEK ISI
SELECT * FROM pelanggan
SELECT * FROM member
SELECT * FROM non_member
SELECT * FROM produk
SELECT * FROM supplier
SELECT * FROM restock
SELECT * FROM transaksi
SELECT * FROM detail_transaksi

USE supermart;

-- Single Query
-- Ambil semua data dari tabel MEMBER yang memiliki total_point lebih dari 50
SELECT nama , no_tlp, email, total_point
FROM MEMBER 
WHERE total_point > 50;

-- JOIN QUERY
-- Tampilkan nama pelanggan (member), tanggal transaksi, dan total pembayaran mereka:
SELECT m.nama , t.tanggal_waktu, t.total_pembayaran
FROM member AS m
JOIN transaksi AS t ON m.pelangganID = t.pelangganID;

-- TEXT Operator
-- Cari pelanggan dengan nama yang mengandung "di"
SELECT nama 
FROM member
WHERE nama LIKE '%di%';

SELECT nama, email 
FROM member
WHERE email LIKE '%@gmail.com%';

-- QUERY dengan Agregasi
-- Hitung rata-rata total pembayaran transaksi

-- Jumlah produk per kategori
SELECT kategori_produk , COUNT(*) AS jumlah_produk
FROM produk 
GROUP BY kategori_produk 

SELECT nama_produk, jumlah_stok
FROM PRODUK
WHERE jumlah_stok > (SELECT AVG(jumlah_stok) FROM produk);

SELECT m.nama, m.email
FROM MEMBER m
LEFT JOIN TRANSAKSI t ON m.pelangganID = t.pelangganID
WHERE t.transaksiID IS NULL;

SELECT m.nama, t.transaksiID, t.tanggal_waktu, t.total_pembayaran
FROM MEMBER m
LEFT JOIN TRANSAKSI t ON m.pelangganID = t.pelangganID;

SELECT t.transaksiID, t.tanggal_waktu, t.total_pembayaran, m.nama
FROM TRANSAKSI t
RIGHT JOIN MEMBER m ON t.pelangganID = m.pelangganID;

SELECT m.nama, t.tanggal_waktu, t.total_pembayaran 
FROM MEMBER m
JOIN TRANSAKSI t ON m.pelangganID = t.pelangganID;