#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib/';

use Qt4OnGtk;


sub main {
    my $app = QApplication(\@ARGV);
    my $hello = QPushButton("Hello world!");
    $hello->{clicked}->connect(sub {print("Hello Gtk2-Perl\n");});
    $hello->{clicked}->emit();
    $hello->show();
    exit $app->exec();
}

main();
