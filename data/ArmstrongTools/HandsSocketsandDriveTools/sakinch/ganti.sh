#!/usr/bin/perl
use strict;
use warnings;
use Cwd 'abs_path'; # Untuk mendapatkan path absolut (lebih jelas di pesan)

# --- Direktori Target ---
# Menggunakan "." berarti direktori saat ini (tempat skrip dijalankan)
my $target_dir = "."; 

# --- Buka Direktori ---
opendir(my $dh, $target_dir) or die "Tidak bisa membuka direktori '$target_dir': $!";

print "Memindai direktori: " . abs_path($target_dir) . "\n";
print "------------------------------------\n";

my $rename_count = 0;

# --- Loop Melalui Setiap Item di Direktori ---
while (my $oldname = readdir($dh)) {
    # Lewati direktori '.' (saat ini) dan '..' (induk)
    next if ($oldname eq '.' or $oldname eq '..');

    # Cek apakah nama file mengandung spasi
    if ($oldname =~ m/ /) {
        my $newname = $oldname;
        # Ganti SEMUA spasi dengan garis bawah
        $newname =~ s/ /_/g; 

        # Pastikan nama benar-benar berubah (menghindari rename yang tidak perlu)
        if ($oldname ne $newname) {
            # Cek apakah nama baru sudah ada
            if (-e $newname) {
                warn " GAGAL: Target '$newname' sudah ada. Melewati '$oldname'.\n";
            } else {
                # Lakukan penggantian nama
                if (rename $oldname, $newname) {
                    print " OK: '$oldname' -> '$newname'\n";
                    $rename_count++;
                } else {
                    # Tampilkan error jika gagal rename
                    warn " GAGAL: Tidak bisa rename '$oldname' ke '$newname': $!\n";
                }
            }
        }
    }
}

# --- Tutup Direktori ---
closedir($dh);

print "------------------------------------\n";
print "Selesai. $rename_count item diganti namanya.\n";

exit 0;
