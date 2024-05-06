-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Bulan Mei 2024 pada 18.50
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laundry_1`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kurir`
--

CREATE TABLE `kurir` (
  `id_kurir` char(5) NOT NULL,
  `nama_kurir` varchar(35) DEFAULT NULL,
  `alamat_kurir` text DEFAULT NULL,
  `nomor_telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kurir`
--

INSERT INTO `kurir` (`id_kurir`, `nama_kurir`, `alamat_kurir`, `nomor_telepon`) VALUES
('k-001', 'Aaron Sucipto', 'jalan Haji mali no. 110', '081298785465'),
('k-002', 'Budi Cahyono', 'jalan Perintis kemerdekaan no. 911 rt. 01 rw. 06 ', '085267854563'),
('k-003', 'Frederic Purwanto', 'jalan panglima', '081298785465');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` char(5) NOT NULL,
  `nama_pelanggan` varchar(35) DEFAULT NULL,
  `alamat_pelanggan` text DEFAULT NULL,
  `nomor_telepon` varchar(15) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `alamat_pelanggan`, `nomor_telepon`, `email`) VALUES
('a-001', 'Anto', 'Jalan Raya Koto Baru, Solok', '085289345673', 'anto@gmail.com'),
('a-002', 'Ahmad', 'Jalan Nyak Arief No.219', '085289476537', 'ahmad@gmail.com'),
('a-003', 'Wati', 'Jalan Jendral Sudirman', '081289465378', 'wati@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengiriman`
--

CREATE TABLE `pengiriman` (
  `id_pengiriman` char(5) NOT NULL,
  `id_transaksi` char(5) DEFAULT NULL,
  `tanggal_pengiriman` date DEFAULT NULL,
  `id_kurir` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengiriman`
--

INSERT INTO `pengiriman` (`id_pengiriman`, `id_transaksi`, `tanggal_pengiriman`, `id_kurir`) VALUES
('c-001', 't-001', '2024-01-01', 'k-001'),
('c-002', 't-002', '2024-01-02', 'k-002'),
('c-003', 't-003', '2024-01-03', 'k-003');

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk`
--

CREATE TABLE `produk` (
  `id_produk` char(5) NOT NULL,
  `jenis_produk` varchar(25) DEFAULT NULL,
  `jumlah_produk` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `produk`
--

INSERT INTO `produk` (`id_produk`, `jenis_produk`, `jumlah_produk`) VALUES
('b-001', 'wol', 9),
('b-002', 'linen', 8),
('b-003', 'katun', 16);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` char(5) NOT NULL,
  `id_pelanggan` char(5) DEFAULT NULL,
  `id_produk` char(5) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `status_transaksi` varchar(10) DEFAULT NULL,
  `biaya_transaksi` int(10) DEFAULT NULL,
  `id_kurir` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_pelanggan`, `id_produk`, `tanggal_transaksi`, `status_transaksi`, `biaya_transaksi`, `id_kurir`) VALUES
('t-001', 'a-001', 'b-001', '2024-01-01', 'tunai', 150000, 'k-001'),
('t-002', 'a-002', 'b-002', '2024-01-02', 'tunai', 100000, 'k-002'),
('t-003', 'a-003', 'b-003', '2024-01-03', 'tunai', 200000, 'k-003');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kurir`
--
ALTER TABLE `kurir`
  ADD PRIMARY KEY (`id_kurir`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indeks untuk tabel `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD PRIMARY KEY (`id_pengiriman`),
  ADD KEY `fk_id_transaksi` (`id_transaksi`),
  ADD KEY `fk_peng_kurir` (`id_kurir`);

--
-- Indeks untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `fk_id_pelanggan` (`id_pelanggan`),
  ADD KEY `fk_id_produk` (`id_produk`),
  ADD KEY `fk_id_kurir` (`id_kurir`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD CONSTRAINT `fk_id_transaksi` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  ADD CONSTRAINT `fk_peng_kurir` FOREIGN KEY (`id_kurir`) REFERENCES `kurir` (`id_kurir`);

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_id_kurir` FOREIGN KEY (`id_kurir`) REFERENCES `kurir` (`id_kurir`),
  ADD CONSTRAINT `fk_id_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `fk_id_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
