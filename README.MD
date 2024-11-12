## Dokumentasi Reproduksi Eksperimen

[EFFICIENT TOPIC PARTITIONING OF APACHE KAFKA FOR HIGH-RELIABILITY REAL-TIME DATA STREAMING APPLICATIONS](https://www.sciencedirect.com/science/article/pii/S0167739X23004892)

#### 1. Clone Kafka Partitioning Experiment Github Repository

Langkah pertama adalah kita akan melakukan cloning github repository untuk eksperimen kafka topic partitioning.

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0;">
git clone https://github.com/bryan-ilman-on-github/kafka-part-exp.git
</pre>

#### 2. Navigasi ke Repo Eksperimen

Selanjutnya, kita navigasi ke repo github yang baru saja didownload dan pastikan bahwa script mempunyai permission yang tepat untuk dijalankan.

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0;">
cd kafka-part-exp
chmod +x run-experiment.sh
chmod +x collect-experiment.sh
</pre>

#### 3. Persiapan Docker pada Host

Pastikan pada host yang akan digunakan sudah terpasang Docker dan Docker Compose. Jika belum terpasang, ikuti langkah berikut untuk menginstal Docker di sistem Ubuntu:

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0 0 10px 0;">
sudo apt updatesudo apt install -y docker.io docker-compose
</pre>

Setelah Docker diinstal, aktifkan dan jalankan Docker daemon:

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0;">
sudo systemctl enable docker
sudo systemctl start docker
</pre>

#### 4. Build Docker Images

Jalankan perintah berikut untuk membangun image Docker:

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0;">
docker build -t kafka-cluster-image -f kafka-cluster-dockerfile .
docker build -t kafka-clients-image -f kafka-clients-dockerfile .
</pre>

#### 5. Jalankan Eksperimen

Jalankan eksperimen dengan perintah berikut.

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0 0 10px 0;">
./run-experiment.sh -n &lt;number&gt;
</pre>

Isi `<number>` dengan nomor eksperimen yang ingin dijalankan (1-4).

#### 6. Ambil Hasil Eksperimen

Setelah eksperimen selesai, ambil hasilnya dengan kode berikut:

<pre style="border: 1px solid #ccc; padding: 10px; margin: 0 0 10px 0;">
./collect-results.sh -n &lt;number&gt;
</pre>

Isi `<number>` dengan nomor eksperimen yang hasilnya ingin diambil (1-4). Jika `<number>` tidak diisi, maka hasil dari semua nomor eksperimen akan diambil. Folder bernama “experiment-`<nomor>`” akan dibuat, berisi hasil eksperimen.
