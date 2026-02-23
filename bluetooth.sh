if bluetoothctl show | grep -q "Powered: yes"; then
    echo -n "" # Bluetooth icon (requires Nerd Font or Font Awesome)
else
    echo -n " (off)"
fi
