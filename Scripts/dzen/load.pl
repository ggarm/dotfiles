#!/usr/bin/perl
use strict;

sub load {
  chomp(my $load = shift);
  if($load < 0.10) {
    $load = "^fg(#09ff00)$load^fg()";
  }
  elsif($load >= 0.10 and $load <= 0.20) {
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

sub uptime {
	chomp(my $up = `cat /proc/loadavg`);
	#my ($_1,$_5,$_15) = $up =~ /average: (.+),(.+),(.+)$/;
	my ($_1,$_5,$_15) = $up =~ /(.+) (.+) (.+) .* .*$/;
	$_1 =~ s/\s+//;
	$_5 =~ s/\s+//;
	$_15 =~ s/\s+//;

	$_1 = load($_1);
	$_5 = load($_5);
	$_15 = load($_15);

	return sprintf("$_1^fg(#555555), $_5^fg(#555555), $_15");
}

print uptime();
