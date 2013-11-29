#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib';
use Data::Dumper;

use Qt4OnGtk;


sub main {
    
    my $edit1 = QLineEdit();
    my $edit2 = QLineEdit();
    my $edit3 = $edit1;
    
    if ($edit1 eq $edit2) {
        print "edit1 eq edit2\n";
    } else {
        print "edit1 ne edit2\n";
    }
    
    if ($edit1 eq $edit3) {
        print "edit1 eq edit3\n";
    } else {
        print "edit1 ne edit3\n";
    }    
    
    my $w = {};
    $w->{1} = 2;
    print Dumper $w;
    delete $w->{1};
    print Dumper $w;
}

main();
