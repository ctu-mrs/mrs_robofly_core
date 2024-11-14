sudo apt install -y dpkg dkms
sudo dpkg --purge hailort hailo-all hailofw hailo-tappas-core-3.28.2 hailort-pcie-driver
find /usr/lib/ | grep hailo | sudo xargs rm -f
sudo dpkg --install ./hailo-4_18/hailort-pcie-driver_4.18.0_all.deb
sudo dpkg --install ./hailo-4_18/hailort_4.18.0_arm64.deb
sudo modprobe -r hailo_pci 
sudo modprobe hailo_pci force_desc_page_size=4096

