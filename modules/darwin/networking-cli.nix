{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dnsutils
    ldns
    iperf3
    iproute2mac
    mtr
    nmap
    tcpdump
    wireshark-cli
  ];
}
