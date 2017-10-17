#!/usr/bin/env perl

while(1){
	if(`ip a | grep tun0 | wc -l` + 0){
		print "VPNC alive\n";
	}else{
		print "VPNC dead\n";
		while(1){
			open RESOLV,">","/etc/resolv.conf";
			print RESOLV "nameserver 8.8.8.8\n";
			close RESOLV;
			print "Reconnect\n";
			system("vpnc");
			if(`ip a | grep tun0 | wc -l` + 0){
				print "VPNC connected\n";
				last;
			}else{
				print "still dead\n";
				sleep 5;
			}
		}
		sleep 2;
		system("service danted stop");
		sleep 2;
		system("service danted start");
	}
	sleep 30;
}
