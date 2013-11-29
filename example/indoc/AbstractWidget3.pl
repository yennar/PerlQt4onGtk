#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib/';

use Qt4OnGtk;

sub slot {
    my ($p_connect,$p_emit) = @_;
    
    if (defined $p_connect) {
        print "\$p_connect = $p_connect\n";
    }
    if (defined $p_emit) {
        print "\$p_emit = $p_emit\n";
    }    
}

my $w = QObject();
$w->register_signal_map(['signal1','signal2']);
$w->{signal1}->connect(\&slot,'connect signal1');
$w->{signal2}->connect(\&slot,'connect signal2');
$w->{signal1}->emit('emit signal1');

