#include <iostream>
#include <cstdint>
#include "db/ma.h"

using namespace std;

auto mac_match(uint64_t mac) {
    if (auto it = ma_s.find(mac >> 12); it != ma_s.end()) {
        return it->second;
    } else if (auto it = ma_m.find(mac >> 20); it != ma_m.end()) {
        return it->second;
    } else if (auto it = ma_l.find(mac >> 24); it != ma_l.end()) {
        return it->second;
    } else {
        return "N/A";
    }
}

int main(int argc, char *argv[]) {
    // print help information
    if (argc < 2 || string(argv[1]) == "-h" || string(argv[1]) == "--help") {
        cout << "Usage: " << argv[0] << " MAC_ADDRESS [MAC_ADDRESS ...]\n";
        return 0;
    }

    for (int i = 1; i < argc; ++i) {
        // remove the delimiter from the MAC address
        string str(argv[i]);
        erase(str, ':');
        erase(str, '-');
        // check mac address length
        if (str.length() != 12) {
            cout << "N/A\n";
            continue;
        }

        uint64_t mac = stoull(str, nullptr, 16);
        cout << mac_match(mac) << "\n";
    }

    return 0;
}