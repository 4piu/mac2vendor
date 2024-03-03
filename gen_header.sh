#!/usr/bin/env sh

# download csv database
rm db -r; mkdir db
wget --no-verbose -O db/ma-l.csv https://standards-oui.ieee.org/oui/oui.csv || exit 1
wget --no-verbose -O db/ma-m.csv https://standards-oui.ieee.org/oui28/mam.csv || exit 1
wget --no-verbose -O db/ma-s.csv https://standards-oui.ieee.org/oui36/oui36.csv || exit 1

# generate header file
cat << EOF > db/ma.h
/* This file is generated by gen_header.sh, do not edit. */

#include <cstdint>
#include <unordered_map>
using namespace std;

const unordered_map<uint32_t, const char * const> ma_l = {
EOF

awk -F, 'NR > 1 { 
    gsub(/"/, "", $3); 
    gsub(/\\/, "\\\\", $3); 
    printf "    {0x%s, \"%s\"},\n", toupper($2), $3 
}' "db/ma-l.csv" >> "db/ma.h"

cat << EOF >> db/ma.h
};   // 24 bits mask

const unordered_map<uint32_t, const char * const> ma_m = {
EOF

awk -F, 'NR > 1 { 
    gsub(/"/, "", $3); 
    gsub(/\\/, "\\\\", $3); 
    printf "    {0x%s, \"%s\"},\n", toupper($2), $3 
}' "db/ma-m.csv" >> "db/ma.h"

cat << EOF >> db/ma.h
};   // 28 bits mask

const unordered_map<uint64_t, const char * const> ma_s = {
EOF

awk -F, 'NR > 1 { 
    gsub(/"/, "", $3); 
    gsub(/\\/, "\\\\", $3); 
    printf "    {0x%s, \"%s\"},\n", toupper($2), $3 
}' "db/ma-s.csv" >> "db/ma.h"

cat << EOF >> db/ma.h
};   // 36 bits mask
EOF
