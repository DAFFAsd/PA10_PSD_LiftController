# 🚀 Lift Controller System using FPGA

## 👥 Anggota Kelompok PA - 10 (PSD)

🧑‍💻 Nugroho Ulil Absar (2306229310)
👨‍💻 Daffa Sayra Firdaus (2306267151)
👨‍💻 Teufik Ali Hadzalic (2306267012)
👨‍💻 Ekananda Zhafif Dean (2306264420)

## 📖 Introduction
Lift merupakan akomodasi yang penting dan banyak digunakan oleh berbagai macam sektor kehidupan untuk mempermudah mobilisasi menuju tempat tempat tinggi. Lift memegang peranan penting karena semakin terbatasnya lahan dimuka bumi. Manusia berlomba lomba membangun banyak gedung tinggi yang sangat sulit digapai jika dengan berjalan kaki atau tangga. Pentingnya fungsionalitas lift dalam kemajuan peradaban juga mengakibatkan perkembangan pada sistem yang mengontrol lift tersebut. Segala kontrol dalam proses pergerakan lift diatur oleh Controller. 

Dalam membuat controller terhadap suatu sistem, Konsumsi daya dan keefektifan system menjadi salah satu hal yang paling penting untuk dipertimbangkan. Saat ini, kebanyakan pembuatan controller menggunakan sistem komputasi yang rumit dan menggunakan bahasa pemrograman yang terhitung memerlukan sumber data yang besar. 

Untuk mengatasi permasalahan ini, bahasa pemrograman low-level seperti VHDL (VHSIC Hardware Description Language) dapat digunakan sebagai solusi yang lebih efektif dalam pengembangan sistem controller lift. Bahasa ini memungkinkan controller dirancang dengan struktur yang lebih sederhana dan efisien. VHDL dalam beberapa riset diberikan kecepatan bahwa VHDL berada dalam nano second sehingga akan membantu memberikan respon yang lebih cepat.


🎯 Tujuan dari proyek ini:

 - Menciptakan Controller Lift yang menggunakan VHDL.
 - Mempercepat kinerja Controller lift dengan algoritma yang lebih sederhana.
 - Mengimplementasikan lift yang relevan dengan kehidupan sehari-hari.

## 🔧 HOW IT WORK?
Pada proyek ini digunakan pendekatan Finite State Machine (FSM) untuk mengatur kondisi lift. Berikut adalah 5 state utama yang berlaku:

🛑 IDLE 
⬆️ MOVING_UP
⬇️ MOVING_DOWN
🚪 DOOR_OPEN
🚪 DOOR_CLOSE

State-state ini didefinisikan dalam package lift_controller_package.

✨ Penjelasan State:
State MOVING_DOWN dan MOVING_UP dipengaruhi oleh input dari  keypad input dan floor_calls pada port yang terdapat dalam main program. Jadi jika liftnya berada dalam state MOVING_UP program akan melakukan for loop untuk mengecek lantai diatas apakah ada yang melakukan request ke atas. Jika ada maka dia akan segera membuka lantai tersebut. Setelah dinyatakan tidak ada kemudian mengecek ke lantai bawah apakah ada request atau tidak. Jika dalam menggunakan keypad, kita akan menuju lantai yang kita inginkan baik dalam state  MOVING_DOWN ataupun MOVING_UP tergantung tujuan dan lokasi terakhir penggunaan lift. Jika kita sudah mencapai lantai yang kita tuju maka tidak ada floor_call atau floor_call akan dijadikan 0 dan menunggu request baru dari keypad ataupun dari request lain. Sehingga memasuki IDLE state.

Sementara DOOR_OPEN dan DOOR_CLOSE dipengaruhi oleh input force_door_close dan force_door_open atau door_timer. door_timer akan otomatis membukan pintu sehingga dalam state DOOR_OPEN. door_timer akan aktif ketika lift sudah mencapai lantai tujuan dan bernilai 0. door_timer akan terus bertambah hingga 5 clock. Setelah 5 clock dan force_door_open  = 0 maka pintu akan tertutup dan state akan berubah menjadi DOOR_CLOSE

Sementara pada IDLE itu terjadi pada saat kita pertama kali menggunakan lift atau state awal ketika belum digunakan. IDLE ini juga terjadi ketika tidak ada request dari lantai lain atau input dari keypad. Ketika IDLE maka function determine_lift_priority akan dipanggil untuk menentukan tujuan berikutnya, jika lantai tujuan berikutnya sama dengan lantai ini maka akan tetap berada dalam state IDLE. Jika floor_calls2 atau internal_floor_calls lebih tinggi dari lantai sekarang maka state akan berubah ke MOVING_UP, tetapi jika floor_calls2 atau internal_floor_calls lebih rendah maka state akan berubah ke MOVING_DOWN


## 🧪 Testing
Kami melakukan pengujian untuk memastikan kode berfungsi sesuai deskripsi:

### ⏱️ Time Diagram
![8TnWh.jpg](https://s6.imgcdn.dev/8TnWh.jpg)

### 🖥️ Quartus Simulation
![8TyYV.jpg](https://s6.imgcdn.dev/8TyYV.jpg)
