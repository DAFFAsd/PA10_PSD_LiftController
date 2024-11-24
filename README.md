# Lift Controller System using FPGA 

## Anggota Kelompok PA - 10 (PSD)
- Nugroho Ulil Absar
- Daffa Sayra Firdaus
- Teufik Ali Hadzalic
- Ekananda Zhafif Dean

## 1. Introduction  

### 1.1 Background  
Lift merupakan fasilitas umum yang sangat penting di gedung-gedung modern dan bahkan kampus kita sekarang. Penggunaan lift yang efisien, cepat, dan handal menjadi kebutuhan utama dalam mendukung aktivitas sehari-hari. Sistem pengendali lift yang kita temui saat ini sering menggunakan mikrokontroler unit biasa. Namun, sistem ini memiliki keterbatasan dalam hal kecepatan, fleksibilitas, dan konsumsi daya.  

FPGA (Field-Programmable Gate Array) adalah solusi yang semakin populer dalam pengembangan sistem kendali karena kemampuan paralelismenya, latensi yang rendah, dan fleksibilitas tinggi dalam pemrograman hardware. Ia tidak ada "beban" fungsi tambahan seperti dalam sistem operasi umum, sehingga seluruh sumber daya difokuskan pada tugas yang ditentukan (dalam konteks ini berarti bertugas dalam mengontrol Lift). Dengan menggunakan FPGA, sistem lift dapat dirancang lebih efisien untuk menangani berbagai skenario dan kondisi operasional.  

### 1.2 Project Description  
Proyek ini bertujuan untuk merancang sistem pengendali lift menggunakan VHDL (VHSIC Hardware Description Language) yang diterapkan pada FPGA. Sistem ini akan mencakup beberapa fungsi inti, seperti:  
- Deteksi lantai saat ini  
- Pemrosesan permintaan lantai tujuan  
- Kontrol pergerakan lift (naik, turun, berhenti)  
- Indikator visual seperti tampilan lantai dan status lift  

Rancangan ini akan diimplementasikan dengan menggunakan Modelsim dan Quartus Prime sebagai simulasi bentuk Output dan Rangkaiannya seperti apa.

### 1.3 Objectives  
- Merancang sistem pengendali lift yang efisien dan dapat diandalkan menggunakan FPGA.  
- Mengoptimalkan penggunaan FPGA untuk menangani beberapa tugas secara paralel, seperti mendeteksi lantai dan memproses permintaan secara simultan.  
- Menghasilkan sistem lift yang responsif dan hemat energi.  
- Memberikan solusi yang lebih fleksibel dibandingkan dengan mikrokontroler atau PLC tradisional karena bisa di re-configure.
