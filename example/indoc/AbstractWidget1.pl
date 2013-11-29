#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib/';

use Qt4OnGtk;

my $hello = QPushButton("Hello world!");
print $hello->is('QPushButton'),"\n"; #return 1
print $hello->is('QAbstractWidget'),"\n"; #return 1
print $hello->is('QLineEdit'),"\n"; #return 0