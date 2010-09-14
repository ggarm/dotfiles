#!/usr/bin/env perl
#
#Status bar for dzen, now in perl
# Ricardo Costa © 2010

use strict;

my $caption_path = "/home/ricardo/Scripts/dzen/xbm";

#net
my $interface_path = "/sys/class/net/wlan0/statistics";
my $rx_path = "$interface_path/rx_bytes";
my $tx_path = "$interface_path/tx_bytes";
my $rx_old = 1;
my $tx_old = 1;

sub net {

	open(RX_BYTES, $rx_path) or
		die("Error: cannot open $rx_path");
	my $rx = <RX_BYTES>;
	my $temp_rx = $rx;
	$rx = ($rx - $rx_old) / 1024;
	close RX_BYTES;

	open(TX_BYTES, $tx_path) or
		die("Error: cannot open $tx_path");
	
	my $tx = <TX_BYTES>;
	my $temp_tx = $tx;
	$tx = ($tx - $tx_old) / 1024;
	close TX_BYTES;

	printf("wlan0:\t %4d kB/s ", $rx);
	print "^fg(#80AA83)^p(3)^i($caption_path/arr_down.xbm)^fg(white) ";
	printf("%4d kB/s ", $tx);
	print "^fg(orange3)^p(3)^i($caption_path/arr_up.xbm)^fg(white) ";
	print "\n";

	$rx_old = $temp_rx;
	$tx_old = $temp_tx;
}

while (1) {
	print &net;
	sleep 1;
}
