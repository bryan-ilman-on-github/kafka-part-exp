## Dokumentasi Reproduksi Eksperimen

EFFICIENT TOPIC PARTITIONING OF APACHE KAFKA FOR HIGH-RELIABILITY REAL-TIME DATA STREAMING APPLICATIONS

#### 1. Clone Kafka Partitioning Experiment Github Repository

Langkah pertama adalah kita akan melakukan cloning github repository untuk eksperimen kafka topic partitioning.

| git clone https://github.com/bryan-ilman-on-github/kafka-part-exp.git |
| --------------------------------------------------------------------- |

#### 2. Navigasi ke Repo Eksperimen

Selanjutnya, kita navigasi ke repo github yang baru saja didownload dan pastikan bahwa script mempunyai permission yang tepat untuk dijalankan.

| cd kafka-part-expchmod +x run-experiment.shchmod +x collect-experiment.sh |
| ------------------------------------------------------------------------- |

#### 3. Persiapan Docker pada Host

Pastikan pada host yang akan digunakan sudah terpasang Docker dan Docker Compose. Jika belum terpasang, ikuti langkah berikut untuk menginstal Docker di sistem Ubuntu:

| sudo apt updatesudo apt install -y docker.io docker-compose |
| ----------------------------------------------------------- |

Setelah Docker diinstal, aktifkan dan jalankan Docker daemon:

| sudo systemctl enable dockersudo systemctl start docker |
| ------------------------------------------------------- |

#### 4. Build Docker Images

Jalankan perintah berikut untuk membangun image Docker:

| docker build -t kafka-cluster-image -f kafka-cluster-dockerfile .docker build -t kafka-clients-image -f kafka-clients-dockerfile . |
| ---------------------------------------------------------------------------------------------------------------------------------- |

#### 5. Jalankan Eksperimen

Jalankan eksperimen dengan perintah berikut.

| ./run-experiment.sh -n `<number>` |
| ----------------------------------- |

Isi `<number>` dengan nomor eksperimen yang ingin dijalankan (1-4).

#### 6. Ambil Hasil Eksperimen

Setelah eksperimen selesai, ambil hasilnya dengan kode berikut:

| ./collect-results.sh -n `<number>` |
| ------------------------------------ |

Isi `<number>` dengan nomor eksperimen yang hasilnya ingin diambil (1-4). Jika `<number>` tidak diisi, maka hasil dari semua nomor eksperimen akan diambil. Folder bernama “experiment-`<nomor>`” akan dibuat, berisi hasil eksperimen.

\*\*
