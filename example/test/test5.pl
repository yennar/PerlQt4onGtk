#!/usr/bin/perl -w

use strict;
use warnings;
use lib '../../lib';
use Data::Dumper;

use Qt4OnGtk;


sub main {
    
    my $edit1 = QLineEdit();
    my $edit2 = QLineEdit();
    my $edit3 = QLineEdit();
    my $edit4 = QLineEdit();
    my $edit5 = QLineEdit();
    
    my $list = QList();
    $list->append($edit1);
    $list->append($edit2);
    $list->_print();
    
    $list->insert(0,$edit3);
    $list->_print();
    $list->insert($edit1,$edit4);
    $list->_print();
    $list->remove($edit1);
    $list->_print();
    $list->append($edit5);
    $list->_print();
}

main();
