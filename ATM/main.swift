//
//  main.swift
//  ATM
//
//  Created by muhamad fikri nabil assyawali on 11/07/24.
//

import Foundation

class Tabungan{
    private var saldo : Int
    private var idTabungan: String
    private var password: String
    
    //init default
    init(){
        self.saldo = 0
        self.idTabungan = ""
        self.password = ""
    }
    
    init(saldo: Int, idTabungan: String, password: String) {
        self.saldo = saldo
        self.idTabungan = idTabungan
        self.password = password
    }
    
    //get set
    
    public func getSaldo() -> Int{
        return saldo
    }
    
    public func setSaldo(_ val:Int){
        saldo = val
    }
    
    public func getIdTabungan() -> String{
        return idTabungan
    }
    
    public func setIdTabungan(_ val:String){
        idTabungan = val
    }
    public func getPassword() -> String{
        return password
    }
    public func setPassword(_ val:String){
        password = val
    }
    
    public func ambilUang(_ val:Int)->Bool{
        if val>0 && val <= saldo{
            saldo -= val
            return true
        }
        return false
    }
    
    public func simpanUang(_ val:Int)->Bool{
        if val>0{
            saldo += val
            return true
        }
        return false
    }
    
    public func transferUang(ke tujuan: Tabungan,jumlah:Int)->Bool{
        if ambilUang(jumlah){
            tujuan.simpanUang(jumlah)
            return true
        }
        return false
    }
}

class Nasabah{
    private var nama : String
    private var tabungan : Tabungan
    
    init() {
        self.nama = ""
        self.tabungan = Tabungan()
    }
    
    init(nama: String, t: Tabungan) {
        self.nama = nama
        self.tabungan = t
    }
    
    public func getNama()->String{
        return nama
    }
    public func setNama(_ val:String){
        nama = val
    }
    
    public func getTabungan()->Tabungan{
        return tabungan
    }
    
    public func setTabungan(_ val:Tabungan){
        tabungan = val
    }
    
}

func getInput(prompt:String)->String{
    print(prompt,terminator: ": ")
    return readLine() ?? ""
}

func tampilkanMenu(){
    print("\n=== Menu ATM ===")
    print("1. Cek Saldo")
    print("2. Simpan Uang")
    print("3. Ambil Uang")
    print("4. Transfer Uang")
    print("5. Keluar")
}

let nama = getInput(prompt: "Masukan Nama Nasabah")
let idTabungan = getInput(prompt: "Masukan ID Tabungan")
let password = getInput(prompt: "Masukan Password tabungan")
let saldoAwalString = getInput(prompt: "Masukan Saldo Awal")
let saldoAwal = Int(saldoAwalString) ?? 0

let myTabungan = Tabungan(saldo: saldoAwal, idTabungan: idTabungan, password: password)
let nasabah = Nasabah(nama: nama, t: myTabungan)

var nasabahLain = Nasabah(nama: "Andi", t: Tabungan(saldo: 300, idTabungan: "1234", password: "password"))

var isRunning = true

print("\n Selamat Datang, \(nasabah.getNama())!")

while isRunning {
    tampilkanMenu()
    let pilihan = getInput(prompt: "Pilih menu")

    switch pilihan {
    case "1":
        print("Saldo Anda: \(nasabah.getTabungan().getSaldo())")
    case "2":
        let simpanUangString = getInput(prompt: "Masukkan jumlah uang yang ingin disimpan")
        let simpanUang = Int(simpanUangString) ?? 0
        if nasabah.getTabungan().simpanUang(simpanUang) {
            print("Saldo setelah menabung: \(nasabah.getTabungan().getSaldo())")
        } else {
            print("Jumlah uang tidak valid.")
        }
    case "3":
        let ambilUangString = getInput(prompt: "Masukkan jumlah uang yang ingin diambil")
        let ambilUang = Int(ambilUangString) ?? 0
        if nasabah.getTabungan().ambilUang(ambilUang) {
            print("Saldo setelah mengambil uang: \(nasabah.getTabungan().getSaldo())")
        } else {
            print("Pengambilan uang gagal. Saldo tidak mencukupi atau jumlah tidak valid.")
        }
    case "4":
        let tujuanId = getInput(prompt: "Masukkan ID tabungan tujuan")
        let jumlahTransferString = getInput(prompt: "Masukkan jumlah uang yang ingin ditransfer")
        let jumlahTransfer = Int(jumlahTransferString) ?? 0
        if tujuanId == nasabahLain.getTabungan().getIdTabungan() {
            if nasabah.getTabungan().transferUang(ke: nasabahLain.getTabungan(), jumlah: jumlahTransfer) {
                print("Transfer berhasil. Saldo Anda sekarang: \(nasabah.getTabungan().getSaldo())")
            } else {
                print("Transfer gagal. Saldo tidak mencukupi atau jumlah tidak valid.")
            }
        } else {
            print("ID tabungan tujuan tidak ditemukan.")
        }
    case "5":
        isRunning = false
        print("Terima kasih telah menggunakan layanan kami. Sampai jumpa!")
    default:
        print("Pilihan tidak valid. Silakan coba lagi.")
    }
}


