#!/usr/bin/env perl
#
#Status bar for dzen, now in perl
# Ricardo Costa © 2010
# vim: set foldmethod=marker foldmarker={} let perl_fold=1

use strict;
use utf8;
use String::Util 'hascontent';
#use String::Utils 'longest';

#my $caption_path = '/home/ricardo/Scripts/dzen/xbm';
my $mail_path = '/home/ricardo/Mail/GMAIL/Inbox';
my $i_music = '/home/ricardo/Scripts/dzen/xbm/music.xbm';
my $i_mail = '/home/ricardo/Scripts/dzen/xbm8x8/mail.xbm';
my $i_arr_down = '/home/ricardo/Scripts/dzen/xbm8x8/net_down_01.xbm';
my $i_arr_up = '/home/ricardo/Scripts/dzen/xbm8x8/net_up_01.xbm';

sub mail {
	open(MAIL_FILE, $mail_path) or
		die("Error: cannot open $mail_path");
	my @mail = <MAIL_FILE>;
	close MAIL_FILE;
	my $count = 0;
	my $mail;
	foreach $mail(@mail) {
		if(index($mail,"Message-I") ge 0){
			$count++;
		}
	}

  if($count == 0) {
	  return("^i($i_mail) ^fg(#5bde58)$count");
  }
  else {
	  return("^i($i_mail) ^fg(#f50208)$count");
  }
}

sub uptime {
  chomp(my $up = `uptime`);
  my ($_1,$_5,$_15) = $up =~ /average: (.+),(.+),(.+)$/;
  $_1 =~ s/\s+//;
  $_5 =~ s/\s+//;
  $_15 =~ s/\s+//;

  $_1 = load($_1);
  $_5 = load($_5);
  $_15 = load($_15);

  return sprintf("^fg(#5bde58)laptop^fg(): $_1^fg(#999999),^fg() $_5^fg(#999999),^fg() $_15");
}

sub load {
  chomp(my $load = shift);
  if($load < 0.10) {
    $load = "^fg(#09ff00)$load^fg()";
  }
  if($load >= 0.10 and $load <= 0.20) {
    $load = "^fg(#28f809)$load^fg()";
  }
  elsif($load >= 0.21 and $load <= 0.30) {
    $load = "^fg(#f2b30e)$load^fg()";
  }
  elsif($load >= 0.31 and $load <= 0.40) {
    $load = "^fg(#f8d509)$load^fg()";
  }
  elsif($load >= 0.41 and $load <= 0.50) {
    $load = "^fg(#f8b009)$load^fg()";
  }
  elsif($load >= 0.51 and $load <= 0.60) {
    $load = "^fg(#f88e09)$load^fg()";
  }
  elsif($load >= 0.61 and $load <= 0.70) {
    $load = "^fg(#f87209)$load^fg()";
  }
  elsif($load >= 0.71 and $load <= 0.80) {
    $load = "^fg(#f85e09)$load^fg()";
  }
  elsif($load >= 0.81 and $load <= 0.90) {
    $load = "^fg(#f84709)$load^fg()";
  }
  elsif($load >= 0.91 and $load <= 1.00) {
    $load = "^fg(#f82409)$load^fg()";
  }
  elsif($load >= 1.01 and $load <= 1.10) {
    $load = "^fg(#f81609)$load^fg()";
  }
  elsif($load >= 1.11 and $load <= 1.20) {
    $load = "^fg(#ff0003)$load^fg()";
  }
  else {
    $load = "^fg(#ff0000)$load^fg()";
  }
  return($load);
}

sub mpd {
my $mpd_len_leftover = 0;
#my $mpd_max_len = 0;
  use Audio::MPD;
  my $mpd = Audio::MPD->new(
    host => '127.0.0.1',
  );

  my $current = $mpd->current;
  if(!defined($current)) {
    return(' MPD: ^fg(#ff0000)Stopped^fg()');
  }

  my $status = "/home/ricardo/Scripts/dzen/xbm8x8/" . $mpd->status->state . '.xbm';

  my $artist = $current->artist // 'undef';
  my $album  = $current->album  // 'undef';
  my $title  = $current->title  // 'undef';
  #my $year   = $current->date   // 0;

  # dzen doesnt handle unicode
  #$artist =~ s/ö/o/g;
  #$artist =~ s/[åä]/a/g;
  #$album  =~ s/ö/o/g;
  #$album  =~ s/[åä]/a/g;
  #$title  =~ s/ö/o/g;
  #$title  =~ s/[åä]/a/g;

	  my $art_len = length($artist);
	  my $alb_len = length($album);
	  my $tit_len = length($title);

	  #$mpd_max_len = $art_len + $alb_len + $tit_len;

	  if($art_len > 30) {
		  $artist = substr($artist, 0, 30) . '^fg(#999999)...^fg()';
	  }
	  else {
		  for($art_len .. 30) {
			  $mpd_len_leftover++;
		  }
	  }
	  if($alb_len > 30) {
		  $album = substr($album, 0, 30) . '^fg(#999999)...^fg()';
	  }
	  else {
		  for($alb_len .. 30) {
			  $mpd_len_leftover++;
		  }
	  }
	  if($tit_len > 30) {
		  $title = substr($title, 0, 30) . '^fg(#999999)...^fg()';
	  }
	  else {
		  for($tit_len .. 30) {
			  $mpd_len_leftover++;
		  }
	  }

  my $pl = "^i($i_music) ^fg(#6be603)$title^fg(#999999) by ^fg(#ff8700)$artist^fg(#999999) from^fg() ^fg(#f8072e)$album^fg()";

  return($pl);
}

sub net {	
my $interface_path = '/sys/class/net/wlan0/statistics';
my $rx_path = "$interface_path/rx_bytes";
my $tx_path = "$interface_path/tx_bytes";
	chomp(my $essid= `iwgetid`);
	$essid =~ s/[^\"]*//;

	open(RX_BYTES, $rx_path) or
		die("Error: cannot open $rx_path");
	my $rx_old = <RX_BYTES>;
	close RX_BYTES;

	open(TX_BYTES, $tx_path) or
		die("Error: cannot open $tx_path");
	
	my $tx_old = <TX_BYTES>;
	close TX_BYTES;

	sleep 1;
	
	open(RX_BYTES, $rx_path) or
		die("Error: cannot open $rx_path");
	my $rx = <RX_BYTES>;
	$rx = int(($rx - $rx_old) / 1024);
	close RX_BYTES;

	open(TX_BYTES, $tx_path) or
		die("Error: cannot open $tx_path");
	
	my $tx = <TX_BYTES>;
	$tx = int (($tx - $tx_old) / 1024);
	close TX_BYTES;

	my $netstats = "^fg()";
	if( hascontent $essid) {
		#printf("%4d kB/s ", $rx);
		#printf("%4d kB/s ", $tx);
		$netstats = "Connected to: ^fg(#5bde58)$essid"
			. "^p(8)"
			. "^fg()^p(3)^i($i_arr_down)^fg(white) "
			. "^fg(#80AA83)$rx kB/s "
			. "^fg()^p(3)^i($i_arr_up)^fg(white) "
			. "^fg(orange3)$tx kB/s ";
	}
	else {
		$netstats = "^fg(#f8072e)Disconnected";
	}

	return $netstats;
}

my $output = "^fg(#484848)"
	. "^fg(#484848) | ^fg()" . &mpd
	. "^fg(#484848) | ^fg()" . &net
	. "^fg(#484848) | ^fg()" . &uptime
	. "^fg(#484848) | ^fg()" . &mail
	#. "^fg(#484848) | ^fg()" . &battery
	. "\n";
  #. "^fg(#484848) | ^fg()";

  print $output;
#print &mpd;
#print "^fg(#484848) | ^fg()";
#print &net;
#print "^fg(#484848) | ^fg()";
#print &uptime;
#print "^fg(#484848) | ^fg()";
#print "\n";
